module languages::derived::syntax::Derived

import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;
import languages::entities::syntax::Entities;

syntax Field 
	= derived: Type Ident "=" Expression
	;
	
syntax Expression
	= nat: Natural value
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
	
syntax Natural
	= lex [0-9]+
	# [0-9]
	;