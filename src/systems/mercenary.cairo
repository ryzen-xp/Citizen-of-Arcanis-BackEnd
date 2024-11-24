use starknet::ContractAddress;
use dojo_starter::{components::{mercenary::{Mercenary,MercenaryTrait},world::World,utils::{uuid, RandomTrait}}};
use dojo::model::{ModelStorage, ModelValueStorage};

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct RareItem {
    #[key]
    pub player: ContractAddress,
    pub item_id: u128, // Unique identifier for the rare item.
    pub source: RareItemSource, // Source of the item (mission/enemy).
}

#[derive(Serde, Copy, Drop, Introspect)]
pub enum RareItemSource {
    Mission, // Mission ID where the item was obtained.
    Enemy, // Enemy contract address.
}

#[generate_trait]
impl MercenaryWorldImpl of MercenaryWorldTrait {


    fn mint_mercenary(ref self: World, owner: ContractAddress) -> Mercenary {
        let id:u128 = 234;//uuid(self);
        let mut random = RandomTrait::new();
        let seed = random.next();
        let mercenary = MercenaryTrait::new(owner,id,seed);
        // let mut world = self.world(@"dojo_starter");
        self.write_model(@mercenary);
        mercenary
    }

    fn get_mercenary(ref self:World, id:u128) -> Mercenary {
        // let mut world = self.world(@"dojo_starter");
        let mercenary: Mercenary = self.read_model(id);
        assert(mercenary.owner.is_non_zero(), 'mercenary not exists');
        mercenary
    }

    fn register_rare_item(ref self: World, player: ContractAddress, item_id: u128, source: RareItemSource)-> RareItem {
        let existing: RareItem = self.read_model(player);
        assert_eq!(existing.item_id , item_id,"Player already have this item");
    
        let rare_item = RareItem {
            item_id,
            player,
            source,
        };
    
        self.write_model(@rare_item);
        rare_item
    }


}