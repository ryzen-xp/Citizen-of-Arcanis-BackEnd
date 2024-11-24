use starknet::ContractAddress;

#[derive(Serde, Copy, Drop, Introspect)]
pub struct rareItem {
    #[key]
    pub player: ContractAddress, 
    pub items: Vec<item>,
}

#[derive(Serde, Copy, Drop, Introspect)]
pub struct item {
    pub item_id: u128,
    pub item_source: RareItemSource, 
}

#[derive(Serde, Copy, Drop, Introspect)]
pub enum RareItemSource {
    Mission, 
    Enemy, 
}

// Define the trait
// pub trait IsPresent {
//     fn is_present(&self, item_id: u128) -> bool;
// }

// Implement the trait for rareItem
// impl IsPresent for rareItem {
//     fn is_present(&self, item_id: u128) -> bool {
//         self.items.iter().any(|itm| itm.item_id == item_id)
//     }
// }

