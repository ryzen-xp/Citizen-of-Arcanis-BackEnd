use core::starknet::{ContractAddress, get_caller_address};
use dojo_starter::{components::{mercenary::{Mercenary,MercenaryTrait},world::World,utils::{uuid, RandomTrait}}};
use dojo::model::{ModelStorage, ModelValueStorage};
use dojo_starter::{
    components::{
        rareItem::{rareItem ,item ,RareItemSource }, //here import other components you need
    }
};



#[generate_trait]
impl rareItemImpl of rareItemTrait {
fn register_rare_item(
    ref self: World, 
    
    item_id: u128, 
    source: RareItemSource
) -> rareItem {
    let player  = get_caller_address();
   
    let mut existing: rareItem = self.read_model(player);
    
    // Check if the item_id already exists for this player
    if existing.items.iter().any(|item| item.item_id == item_id) {
        panic!("Player already has this item");
    }
    
    // Create a new item
    let new_item = item{
        item_id,
        item_source :source,
    };
    

    existing.items.push(new_item);


    self.write_model(existing);


    existing
}
}