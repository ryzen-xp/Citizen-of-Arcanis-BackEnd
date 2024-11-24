use starknet::ContractAddress;
use dojo_starter::{components::{mercenary::{Mercenary,MercenaryTrait},world::World,utils::{uuid, RandomTrait}}};
use dojo::model::{ModelStorage, ModelValueStorage};
use dojo_starter::{
    components::{
        rareItem::{rareItem , m_RareItem,RareItemSource }, //here import other components you need
    }
};



#[generate_trait]
impl rareItemImpl of rareItemTrait {
fn register_rare_item(
    ref self: World, 
    player: ContractAddress, 
    item_id: u128, 
    source: RareItemSource
) -> rareItem {
    // Read the existing RareItem associated with the player
    let mut existing: rareItem = self.read_model(player);
    
    // Check if the item_id already exists for this player
    if existing.items.iter().any(|item| item.item_id == item_id) {
        panic!("Player already has this item");
    }
    
    // Create a new item
    let new_item = item{
        item_id,
        source,
    };
    
    // Update the items vector for the player
    existing.items.push(new_item);

    // Write the updated RareItem model back to the World
    self.write_model(existing);

    // Return the updated RareItem
    existing
}
}