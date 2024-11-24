use core::traits::TryInto;
use starknet::ContractAddress;
use core::fmt::{Display, Formatter, Error};

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct rareItem {
    #[key]
    pub player: ContractAddress, 
    pub items : vec<item>,
}
pub struct item{
    #[key]
    pub item_id :u128,
    pub source : RareItemSource,
}

#[derive(Serde, Copy, Drop, Introspect)]
pub enum RareItemSource {
    Mission, 
    Enemy, 
}