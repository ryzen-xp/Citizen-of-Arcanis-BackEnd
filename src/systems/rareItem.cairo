use core::starknet::{ContractAddress, get_caller_address};
use dojo_starter::{
    components::{
        mercenary::{Mercenary, MercenaryTrait},
        world::World,
        utils::{uuid, RandomTrait},
        rareItem::{rareItem, RareItemSource, rare_items},
    },
};

use starknet::storage::{
    StoragePointerReadAccess, StoragePointerWriteAccess, Vec, VecTrait, MutableVecTrait, Map, 
};
use dojo::model::{ModelStorage, ModelValueStorage};

#[generate_trait]
impl rareItemImpl of rareItemTrait {
    fn register_rare_item(
        ref self: World,
        item_id: u128,
        source: RareItemSource,
    ) -> rareItem {
        let player = get_caller_address();

        // Read the player's existing rare items from storage
        let mut existing_items = self.read_model::<rare_items>(player);

        // Check for duplicates
        let duplicate_item = existing_items.iter().find(|item| item.item_id == item_id);
        if duplicate_item.is_some() {
            panic!("Player already has this item");
        }

        // Create a new rare item
        let new_item = rareItem {
            item_id,
            item_source: source,
        };

        // Add the new item to the player's inventory
        existing_items.push(new_item);

        // Write the updated item list back to storage
        self.write_model(existing_items);

        new_item
    }
}