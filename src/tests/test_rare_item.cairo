#[cfg(test)]
mod tests {
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use dojo_cairo_test::{spawn_test_world, NamespaceDef, TestResource};
    use dojo_starter::{
        systems::{rareItem::{rareItemTrait
          //if you change it properly to components, the must be add below rareItem::{RareItemSource} 
        }},
    };
    use dojo_starter::{
        components::{
            rareItem::{rareItem , m_RareItem,RareItemSource }, //here import other components you need
        }
    };
    fn namespace_def() -> NamespaceDef {
        let ndef = NamespaceDef {
            namespace: "dojo_starter", resources: [
                TestResource::Model(m_RareItem::TEST_CLASS_HASH.try_into().unwrap()),
            ].span()
        };

        ndef
    }
    #[test]
    fn test_rare_item_registration() {
       
         // Initialize test environment
         let player = starknet::contract_address_const::<0x07dc7899aa655b0aae51eadff6d801a58e97dd99cf4666ee59e704249e51adf2>();//test address
         let ndef = namespace_def();
         let mut world = spawn_test_world([ndef].span());

        // Data for the rare item
        let item_id: u128 = 12345;
        let source = RareItemSource::Mission;

        let rare_item = rareItemTrait::register_rare_item(ref world, item_id, source);

        // Verify the registered rare item

        assert_eq!(rare_item.items.item_id, item_id, "Item ID is incorrect");
        assert_eq!(rare_item.player, player, "Player address is incorrect");
        assert_eq!(rare_item.items.item_source, source, "Source of the rare item is incorrect");

        // Try to register the same rare item again
        let duplicate_item_result = std::panic::catch_unwind(|| {
            MercenaryWorldTrait::register_rare_item(ref world, player, item_id, source);
        });


        assert!(duplicate_item_result.is_err(), "Duplicate item registration did not panic as expected");
    }
}