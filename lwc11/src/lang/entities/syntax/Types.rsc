module lang::entities::syntax::Types

extend lang::entities::syntax::Ident;

syntax Type 
	= @category="Type" primitive: PrimitiveType
	| @category="Type" reference: Name;

syntax PrimitiveType 
	= string: "string" 
	| date: "date" 
	| integer: "integer" 
	| boolean: "boolean"
	| currency: "currency";

keyword Reserved
	= "string"
	| "date"
	| "integer"
	| "boolean"
	| "currency";