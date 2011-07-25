module lang::entities::syntax::Ident

lexical Ident 
	= @category="Identifier" id: ([a-zA-Z][a-zA-Z0-9]* !>> [A-Za-z0-9]) \ Reserved  ;
	
lexical Name
	= name: Ident id;
	
