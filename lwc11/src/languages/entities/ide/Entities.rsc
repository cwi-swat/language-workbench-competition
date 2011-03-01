module languages::entities::ide::Entities

import languages::entities::syntax::Entities;
import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;

import languages::entities::ide::Check;
import languages::entities::ide::Outline;

import SourceEditor;
import List;
import ParseTree;
import IO;

public str ENTITIES_EXTENSION = "entities";

public void registerEntities() {
  	registerLanguage("Entities", ENTITIES_EXTENSION, Tree (str x, loc l) {
    	return parse(#languages::entities::syntax::Entities::Entities, x, l);
  	});
  
  	registerAnnotator("Entities", checkAndAnnotatePT);
	registerOutliner("Entities", outlineEntities);
}   

