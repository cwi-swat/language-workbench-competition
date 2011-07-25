module lang::entities::syntax::Entities

extend lang::entities::syntax::Layout;
extend lang::entities::syntax::Ident;
extend lang::entities::syntax::Types;

start syntax Entities
	= entities: Entity* entities;

syntax Entity 
    = @Foldable entity: "entity" Name name "{" Field* "}";

syntax Field 
    = field: Type Ident name;




