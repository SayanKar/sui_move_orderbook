module orderbook::orderbook {
    
    use sui::math;
    use sui::event;
    use std::vector;
    use sui::transfer;
    use sui::sui::SUI;
    use kar::kar::KAR;
    use sui::balance::{Self, Balance};
    use sui::tx_context::{Self,TxContext};
    use sui::object::{Self, UID};
    use sui::coin::{Self, Coin};
    
    /// Maintains the state of the orderbook which is a shared object
    /// Can include trading fees as well
    struct OrderBook has key {
        id: UID,
        /// Stores all the active sell orders
        sell_orders: vector<Order>,
        /// Stores all the active buy orders
        buy_orders: vector<Order>,
    }

    /// Stores information about the order
    struct Order has key, store {
        id: UID,
        /// Order creator address
        creator: address,
        /// Stores the amount of KAR to sell or buys
        amount: u64,
        /// Stores the amount SUI we want to pay per KAR
        price: u64,
        /// Keeps track of amount which needs to be filled
        amount_to_be_filled: u64,
        /// Stores SUI balance for buy KAR orders
        sui: Balance<SUI>,
        /// Stores KAR balance for sell KAR orders
        kar: Balance<KAR>,
    }

    /// Insufficient sui amount sent
    const EInsufficientSuiAmount: u64 = 0; 
    
    /// Insufficient kar amount sent
    const EInsufficientKarAmount: u64 = 0; 

    // ====== Events ======
    
    /// For when a order is filled partially or as a whole 
    struct OrderFilled has copy, drop{
        seller: address,
        buyer: address,
        amount: u64,
        price: u64,
    }

    // ====== Functions ======

    fun init(ctx: &mut TxContext) {
        transfer::share_object(OrderBook {
            id: object::new(ctx),
            sell_orders: vector::empty<Order>(),
            buy_orders: vector::empty<Order>(),
        });
    }

    /// Trys to fullfills buy order from existing sell orders and includes buy order into vector buy_orders
    /// If sending move than required coins they will be stuck in the buy order 
    /// (Allows more than required as it decrease one step in testing of spliting coin)
    public entry fun buy_kar(orderbook: &mut OrderBook, amount: u64, price: u64, sui: Coin<SUI>, ctx: &mut TxContext) {

        assert!(coin::value(&sui) >= amount * price, EInsufficientSuiAmount);

        // Check if current sell_orders can fullfill buy request
        let amount_to_be_filled: u64 = amount;
        let index: u64 = 0;
        let total_sell_orders: u64 = vector::length(&orderbook.sell_orders);
        let sui_balance = coin::into_balance(sui);

        // Can improve by keeping a heap
        // Need to implement lock
        while(index < total_sell_orders && amount_to_be_filled > 0) {

            let sell_order = vector::borrow_mut(&mut orderbook.sell_orders, index);

            if(sell_order.price == price) {
                let fullfilled_amount: u64 = math::min(sell_order.amount_to_be_filled, amount_to_be_filled);
                sell_order.amount_to_be_filled = math::max(sell_order.amount_to_be_filled - fullfilled_amount, 0);
                amount_to_be_filled = math::max(amount_to_be_filled - fullfilled_amount, 0);

                if(balance::value(&sell_order.kar) >= fullfilled_amount 
                    && balance::value(&sui_balance) >= fullfilled_amount * price) {
                    
                    // transfer kar to buy order creator
                    send_balance(balance::split(&mut sell_order.kar, fullfilled_amount), tx_context::sender(ctx), ctx);

                    // transfer sui to sell order creator
                    send_balance(balance::split(&mut sui_balance, fullfilled_amount * price), sell_order.creator, ctx);

                    event::emit(OrderFilled { 
                        seller: sell_order.creator,
                        buyer: tx_context::sender(ctx),
                        amount: fullfilled_amount,
                        price: price,                    
                    });
                };             
            };
            index = index + 1;
        };

        // Add a buy order to the list
        let buy_order = Order {
            id: object::new(ctx),
            creator: tx_context::sender(ctx),
            amount: amount,
            price: price,
            amount_to_be_filled: amount_to_be_filled,
            kar: balance::zero<KAR>(),
            sui: sui_balance
        };
        vector::push_back(&mut orderbook.buy_orders, buy_order);

    }

    /// Trys to fullfills sell order from existing buy orders and includes sell order into vector sell_orders
    /// If sending move than required coins they will be stuck in the sell order 
    /// (Allows more than required as it decrease one step in testing of spliting coin)
    public entry fun sell_kar(orderbook: &mut OrderBook, amount: u64, price: u64, kar: Coin<KAR>, ctx: &mut TxContext) {

        assert!(coin::value(&kar) >= amount, EInsufficientKarAmount);

        // Check if current buy_orders can fullfill sell request
        let amount_to_be_filled: u64 = amount;
        let index: u64 = 0;
        let total_buy_orders: u64 = vector::length(&orderbook.buy_orders);
        let kar_balance = coin::into_balance(kar);

        // Can improve by keeping a heap
        // Need to implement lock
        while(index < total_buy_orders && amount_to_be_filled > 0) {

            let buy_order = vector::borrow_mut(&mut orderbook.buy_orders, index);

            if(buy_order.price == price) {
                
                let fullfilled_amount: u64 = math::min(buy_order.amount_to_be_filled, amount_to_be_filled);
                
                buy_order.amount_to_be_filled = math::max(buy_order.amount_to_be_filled - fullfilled_amount, 0);
                amount_to_be_filled = math::max(amount_to_be_filled - fullfilled_amount, 0);

                if(balance::value(&buy_order.sui) >= fullfilled_amount * price
                    && balance::value(&kar_balance) >= fullfilled_amount) {
                    
                    // transfer kar to buy order creator
                    send_balance(balance::split(&mut kar_balance, fullfilled_amount), buy_order.creator, ctx);

                    // transfer sui to sell order creator
                    send_balance(balance::split(&mut buy_order.sui, fullfilled_amount * price), tx_context::sender(ctx), ctx);

                    event::emit(OrderFilled { 
                        seller: tx_context::sender(ctx),
                        buyer: buy_order.creator,
                        amount: fullfilled_amount,
                        price: price,                    
                    });
                };             
            };
            index = index + 1;
        };

        // Add a sell order to the orderbook.sell_orders
        let sell_order = Order {
            id: object::new(ctx),
            creator: tx_context::sender(ctx),
            amount: amount,
            price: price,
            amount_to_be_filled: amount_to_be_filled,
            kar: kar_balance,
            sui: balance::zero<SUI>() 
        };
        vector::push_back(&mut orderbook.sell_orders, sell_order);

    }

    fun send_balance<T>(balance: Balance<T>, to: address, ctx: &mut TxContext) {
        transfer::public_transfer(coin::from_balance(balance, ctx), to)
    }
}