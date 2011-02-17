module languages::entities::syntax::Ident

import languages::entities::syntax::Types;

syntax Ident 
	= lex @category="Identifier" id: [a-zA-Z][a-zA-Z0-9]* - PrimitiveType # [A-Za-z0-9] ;
	
