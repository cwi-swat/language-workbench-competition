module lang::entities::syntax::Layout

lexical Whitespace = [\t-\n\r\ ];
    
layout LAYOUTLIST 
    = (Whitespace | Comment)* !>> [\t-\n \r \ ]  !>> "/*" ;

lexical Comment 
	= @category="Comment"  "/*" ([*] !>> [/] | ![*])* "*/" ;