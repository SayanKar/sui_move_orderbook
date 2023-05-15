# sui_move_orderbook

To tryout the module, install sui locally and publish the packages.

* Go through the tutorial to [install sui](https://docs.sui.io/build/install), this would also install sui cli.
* Create a local sui network. Refer [link](https://docs.sui.io/build/sui-local-network).
* Create accounts and fund them from local faucet.

After setting up sui locally, clone the repo and move into orderbook package:

```bash
git clone https://github.com/SayanKar/sui_move_orderbook.git
cd sui_move_orderbook/orderbook
```
To publish the package use the following command at the root folder of orderbook package:

```bash
sui client publish --gas {YOUR_GAS_OBJECT_ID} --gas-budget 100000000 --with-unpublished-dependencies
```

On success you would get the following output:

```txt
----- Transaction Digest ----
4Rh7ddBUwzgNYqTnZwVzjD8A2xAsbayMpqTLD8VCc9xA
----- Transaction Data ----
Transaction Signature: [Signature(Ed25519SuiSignature(Ed25519SuiSignature([0, 173, 200, 115, 226, 89, 12, 17, 223, 105, 57, 20, 222, 202, 170, 215, 40, 213, 203, 113, 213, 108, 74, 173, 146, 209, 182, 90, 143, 181, 187, 151, 141, 13, 104, 144, 116, 91, 35, 60, 205, 136, 228, 88, 178, 103, 122, 124, 31, 52, 92, 196, 23, 183, 182, 42, 203, 251, 83, 85, 107, 8, 0, 142, 3, 93, 36, 231, 97, 29, 253, 179, 84, 119, 209, 213, 144, 205, 28, 70, 122, 47, 69, 60, 186, 204, 92, 124, 76, 24, 24, 161, 33, 88, 197, 38, 243])))]
Transaction Kind : Programmable
Inputs: [Pure(SuiPureValue { value_type: Some(Address), value: "0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b" })]
Commands: [
  Publish(<modules>,0x0000000000000000000000000000000000000000000000000000000000000001,0x0000000000000000000000000000000000000000000000000000000000000002),
  TransferObjects([Result(0)],Input(0)),
]

Sender: 0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b
Gas Payment: Object ID: 0x2aa7f71db5c5ad86cd943aaaffdafaf02378f621a59d7291a6d649c626851edf, version: 0x22, digest: DmEoZRGTCoZBiMfwShnMAcFD5xnMvPHyFpqDQHGuoqNS 
Gas Owner: 0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b
Gas Price: 1000
Gas Budget: 100000000

----- Transaction Effects ----
Status : Success
Created Objects:
  - ID: 0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5 , Owner: Immutable
  - ID: 0x39d3873d7c31215d3ba5c3818a84899c603d8ba92fcdb40735fe8ae5b1965b05 , Owner: Shared
  - ID: 0x8259bb879e943bc3faca6fb78ee00e5934c7b219a12f34e8874ba4dda3cb33a5 , Owner: Immutable
  - ID: 0xec787ed09e06b5638102a8a9889945076d954792cdf8b8a7221f461fe69cde96 , Owner: Account Address ( 0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b )
  - ID: 0xf21359b1debc36b8458dd651661f20a1830500821fbab4ba663875ac5f02c819 , Owner: Account Address ( 0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b )
Mutated Objects:
  - ID: 0x2aa7f71db5c5ad86cd943aaaffdafaf02378f621a59d7291a6d649c626851edf , Owner: Account Address ( 0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b )

----- Events ----
Array []
----- Object changes ----
Array [
    Object {
        "type": String("mutated"),
        "sender": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        "owner": Object {
            "AddressOwner": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        },
        "objectType": String("0x0000000000000000000000000000000000000000000000000000000000000002::coin::Coin<0x0000000000000000000000000000000000000000000000000000000000000002::sui::SUI>"),
        "objectId": String("0x2aa7f71db5c5ad86cd943aaaffdafaf02378f621a59d7291a6d649c626851edf"),
        "version": String("35"),
        "previousVersion": String("34"),
        "digest": String("E7Fe9TTmj9R4LfPwm3ghEWazutNCcxJqRQoTAqjch8N2"),
    },
    Object {
        "type": String("published"),
        "packageId": String("0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5"),
        "version": String("1"),
        "digest": String("92LApnoeBeCL95SnaPbaC8M5xEGLJBoThmDqwpeoehn5"),
        "modules": Array [
            String("kar"),
            String("orderbook"),
        ],
    },
    Object {
        "type": String("created"),
        "sender": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        "owner": Object {
            "Shared": Object {
                "initial_shared_version": Number(35),
            },
        },
        "objectType": String("0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5::orderbook::OrderBook"),
        "objectId": String("0x39d3873d7c31215d3ba5c3818a84899c603d8ba92fcdb40735fe8ae5b1965b05"),
        "version": String("35"),
        "digest": String("Hvw8S8W26ZaGaGdTXsiBYpQUE5exXoyEqd9NJUCHph4e"),
    },
    Object {
        "type": String("created"),
        "sender": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        "owner": String("Immutable"),
        "objectType": String("0x0000000000000000000000000000000000000000000000000000000000000002::coin::CoinMetadata<0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5::kar::KAR>"),
        "objectId": String("0x8259bb879e943bc3faca6fb78ee00e5934c7b219a12f34e8874ba4dda3cb33a5"),
        "version": String("35"),
        "digest": String("BA4wQcvSDHCasgQySyAjqH41xL2VQqgvh8BVHJoFwMhq"),
    },
    Object {
        "type": String("created"),
        "sender": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        "owner": Object {
            "AddressOwner": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        },
        "objectType": String("0x0000000000000000000000000000000000000000000000000000000000000002::coin::TreasuryCap<0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5::kar::KAR>"),
        "objectId": String("0xec787ed09e06b5638102a8a9889945076d954792cdf8b8a7221f461fe69cde96"),
        "version": String("35"),
        "digest": String("ARbLmxzSyeVGwoefupeKRYyFNFHhzCCWuEUV543wdaJE"),
    },
    Object {
        "type": String("created"),
        "sender": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        "owner": Object {
            "AddressOwner": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        },
        "objectType": String("0x0000000000000000000000000000000000000000000000000000000000000002::package::UpgradeCap"),
        "objectId": String("0xf21359b1debc36b8458dd651661f20a1830500821fbab4ba663875ac5f02c819"),
        "version": String("35"),
        "digest": String("DqPtGZkzwYcrMLgcqGJjhTuc7MR5Avd42WM5UzspxDFZ"),
    },
]
----- Balance changes ----
Array [
    Object {
        "owner": Object {
            "AddressOwner": String("0x28ac150b77e17edc6e78587dd8bea5fbbaa63705f5bbe0eda55b9dbd7966282b"),
        },
        "coinType": String("0x0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"),
        "amount": String("-27131080"),
    },
]
```

You can note down a few details here:

* Look for Object created with `"type": String("published")` pick the objectId `0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5`. This is the package address note it down.

* We have a shared object with property `"Shared": Object {"initial_shared_version": Number(35),},` and type `"objectType": String("0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5::orderbook::OrderBook")`, pick the objectId for this
`0x39d3873d7c31215d3ba5c3818a84899c603d8ba92fcdb40735fe8ae5b1965b05` as this is the orderbook shared object storing the sell and buy orders.

* Look for a Object with `"objectType":String("0x0000000000000000000000000000000000000000000000000000000000000002::coin::TreasuryCap<0x10d55ea2889067afad342bce52e7fa95051ec0f389358baa80692a316c5ba0d5::kar::KAR>")` and pick its objectId `0x8259bb879e943bc3faca6fb78ee00e5934c7b219a12f34e8874ba4dda3cb33a5`. This is the TreasuryCap Object which can be used to Mint KAR tokens and send to a address by passing treasuryCap along with other params to coin::mint_and_transfer.


To interact with the orderbook use sui-cli or sui explorer, by putting the package address in search bar you get a interface to interact with the public entry functions.

