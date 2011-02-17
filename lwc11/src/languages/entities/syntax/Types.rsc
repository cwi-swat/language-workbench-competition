module languages::entities::syntax::Types

import languages::entities::syntax::Ident;

syntax Type 
	= @category="Type" primitive: PrimitiveType
	| @category="Type" reference: Name;

syntax PrimitiveType 
	= string: "string" 
	| date: "date" 
	| integer: "integer" 
	| boolean: "boolean";

syntax Reserved
	= "string"
	| "date"
	| "integer"
	| "boolean";