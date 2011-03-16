module lang::entities::syntax::Types

import lang::entities::syntax::Ident;

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