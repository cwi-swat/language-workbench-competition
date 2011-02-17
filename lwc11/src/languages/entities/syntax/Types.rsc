module languages::entities::syntax::Types

import languages::entities::syntax::Ident;

// TODO: add explicit reference nonterminal
// that can be extended to qualified names
// in package version of entities.

syntax Type 
	= @category="Type" primitive: PrimitiveType
	| @category="Type" reference: Ident;

syntax PrimitiveType 
	= string: "string" 
	| date: "date" 
	| integer: "integer" 
	| boolean: "boolean";
