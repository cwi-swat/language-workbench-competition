module lang::instances::syntax::Values

syntax Value 
	= @category="Constant" date: Int "." Int "." Int
	| @category="Constant" string: Str
	| @category="Constant" integer: Int
	| @category="Constant" float: Float
	;
	
lexical Int = [0-9]+ !>> [0-9];

lexical Float = [0-9]+ "." [0-9]+ !>> [0-9];

lexical Str = [\"] (![\"] | ([\\][\"]))* [\"];