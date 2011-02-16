module languages::entities::syntax::Entities

start syntax Entities
	= entities: Entity*;

syntax Entity 
    = entity: "entity" Ident "{" Field* "}";

syntax Field 
    = field: Type Ident;

syntax Type 
	= primitive: PrimitiveType
	| reference: Ident;

syntax PrimitiveType 
	= string: "string" 
	| date: "date" 
	| integer: "integer" 
	| boolean: "boolean";

syntax Ident 
	= lex id: [a-zA-Z][a-zA-Z0-9]* - PrimitiveType # [A-Za-z0-9] ;

syntax LAYOUT 
	= lex whitespace: [\t-\n\r\ ] 
    | lex Comment ;

layout LAYOUTLIST 
    = LAYOUT* 
	# [\t-\n \r \ ] 
	# "/*" ;

syntax Comment 
	= lex @category="Comment"  "/*" CommentChar* "*/" ;

syntax CommentChar 
	= lex ![*] | lex Asterisk ;

syntax Asterisk
	= lex [*] # [/] ;


