module lang::entities::syntax::Entities

import lang::entities::syntax::Layout;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;

start syntax Entities
	= entities: Entity* entities;

syntax Entity 
    = @Foldable entity: "entity" Name name "{" Field* "}";

syntax Field 
    = field: Type Ident name;




