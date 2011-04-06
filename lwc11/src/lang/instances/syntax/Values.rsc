module lang::instances::syntax::Values

syntax Value 
	= @category="Constant" date: Int "." Int "." Int
	| @category="Constant" string: Str
	| @category="Constant" integer: Int
	| @category="Constant" float: Float
	;
	
syntax Int
	= lex [0-9]+ 
	# [0-9]
	;

syntax Float
	= lex [0-9]+ "." [0-9]+ 
	# [0-9] 
	;

syntax Str
	= lex [\"] StrChar* [\"]
	;

syntax StrChar
	= lex ![\"]
	| lex [\\][\"]
	;