module languages::entities::syntax::Layout

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
