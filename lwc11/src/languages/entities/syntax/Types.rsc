module languages::entities::syntax::Types

import languages::entities::syntax::Ident;

syntax Type 
	= primitive: PrimitiveType
	| reference: Ident;

syntax PrimitiveType 
	= string: "string" 
	| date: "date" 
	| integer: "integer" 
	| boolean: "boolean";
