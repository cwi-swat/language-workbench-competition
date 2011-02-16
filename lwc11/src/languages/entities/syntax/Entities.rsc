module languages::entities::syntax::Entities

import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;

start syntax Entities
	= entities: Entity*;

syntax Entity 
    = entity: "entity" Ident "{" Field* "}";

syntax Field 
    = field: Type Ident;




