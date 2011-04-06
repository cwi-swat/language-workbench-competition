module lang::derived::syntax::Derived

import lang::entities::syntax::Layout;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;
import lang::entities::syntax::Entities;

import lang::instances::syntax::Values;

syntax Field 
	= derived: Type Ident "=" Expression
	| annotated: Annotation Type Ident 
	;
	
syntax Annotation
	= @category="MetaVariable" host: "@host" "(" Str arg ")"
	; 
	
syntax Expression
	= const: Value value
	| field: Ident var
	| bracket Bracket: "(" Expression exp ")"
	| neg: "-" Expression arg
	> 
	left (
		mul: Expression lhs "*" Expression rhs
		| div: Expression lhs "/" Expression rhs
	) 
	>
	left (
		add: Expression lhs "+" Expression rhs
		| sub: Expression lhs "-" Expression rhs
	);
	
