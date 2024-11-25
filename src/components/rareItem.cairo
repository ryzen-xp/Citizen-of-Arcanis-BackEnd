use starknet::ContractAddress;
use starknet::storage::{
    StoragePointerReadAccess, StoragePointerWriteAccess, Vec, VecTrait, MutableVecTrait, Map,
};

#[storage]
struct Storage {
   pub rare_items: Map<ContractAddress, Vec<rareItem>>,
}

#[derive(Serde, Copy, Drop)]
pub struct rareItem {
    pub item_id: u128,
    pub item_source: RareItemSource,
}

#[derive(Serde, Copy, Drop)]
pub enum RareItemSource {
    Mission,
    Enemy,
}

// Function to check if a player has a specific item
// fn has_item(player: ContractAddress, item_id: u128) -> bool {
//     let player_items = self.storage().rare_items.get(player);
//     player_items.iter().any(|item| item.item_id == item_id)
// }