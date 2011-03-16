module lang::instances::syntax::Instances

import lang::entities::syntax::Ident;
import lang::entities::syntax::Layout;

start syntax Instances
	= instances: Require* requires Instance* instances
	;

syntax Require
	= require: "require" Ident name
	;

syntax Instance
	= @Foldable instance: Name entity Name name "=" "{" Assign* "}";
	
syntax Assign
	= assign: Ident name "=" Value;
	
syntax Value 
	= @category="Constant" date: Int "." Int "." Int
	| @category="Constant" string: Str
	| @category="Constant" integer: Int
	| reference: Name name
	;
	
syntax Int
	= lex [0-9]+ # [0-9];

syntax Str
	= lex [\"] StrChar* [\"];

syntax StrChar
	= lex ![\"]
	| lex [\\][\"];