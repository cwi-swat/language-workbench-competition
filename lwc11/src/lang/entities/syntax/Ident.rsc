module languages::entities::syntax::Ident

syntax Ident 
	= lex @category="Identifier" id: [a-zA-Z][a-zA-Z0-9]* - Reserved # [A-Za-z0-9] ;
	
syntax Name
	= name: Ident id;
	
syntax Reserved = ;