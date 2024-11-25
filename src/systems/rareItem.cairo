use core::starknet::{ContractAddress, get_caller_address};
use dojo_starter::{
    components::{
        mercenary::{Mercenary, MercenaryTrait},
        world::World,
        utils::{uuid, RandomTrait},
        rareItem::{rareItem, RareItemSource, rare_items ,rare_itemsTrait, rare_itemsImpl ,rareItemImpl ,rareItemTrait,},
    },
};
const MAX_INVENTORY_CAPACITY: usize = 10;

use starknet::storage::{
    StoragePointerReadAccess, StoragePointerWriteAccess, Vec, VecTrait, MutableVecTrait, Map,StoragePathEntry,
};
use dojo::model::{ModelStorage, ModelValueStorage};

#[generate_trait]
impl rareItem_managmentImpl of rareItem_managmentTrait {
    fn register_rare_item(
        ref self: World,
        item_id: u128,
        source: RareItemSource,
    ) -> rareItem {
        let player = get_caller_address();


        let mut existing_items: rare_items= self.read_model(player);


        // Check for available item (not already present)
        if existing_items.has_available_item(item_id) {
            panic!("Player already has this item or inventory is full");
        }

        // Create a new rare item
        let new_item = rareItemTrait::new(item_id , source);

        // Add the new item to the player's inventory
        let added = existing_items.add_rare_item(new_item); 
        if !added {
            panic!("Player item  inventory is full");
        }

         new_item
    }
}