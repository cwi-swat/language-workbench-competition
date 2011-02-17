module languages::instances::syntax::Instances

import languages::entities::syntax::Ident;
import languages::entities::syntax::Layout;

start syntax Instances
	= instances: Instance*;
	
syntax Instance
	= instance: Ident Ident "=" "{" Assign* "}";
	
syntax Assign
	= assign: Ident "=" Value;
	
syntax Value 
	= @category="Constant" date: Int "." Int "." Int
	| @category="Constant" string: Str
	| @category="Constant" integer: Int
	| reference: Ident;
	
syntax Int
	= lex [0-9]+ # [0-9];

syntax Str
	= lex [\"] StrChar* [\"];

syntax StrChar
	= lex ![\"]
	| lex [\\][\"];