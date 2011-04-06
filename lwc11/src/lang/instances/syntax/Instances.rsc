module lang::instances::syntax::Instances

import lang::entities::syntax::Ident;
import lang::entities::syntax::Layout;
import lang::instances::syntax::Values;

start syntax Instances
	= instances: Require* requires Instance* instances
	;

syntax Require
	= require: "require" Ident name
	;

syntax Instance
	= @Foldable instance: Name entity Name name "=" "{" Assign* "}";
	
syntax Assign
	= assign: Ident name "=" Expression;

syntax Expression
	= const: Value value
	| reference: Name name
	;
	
