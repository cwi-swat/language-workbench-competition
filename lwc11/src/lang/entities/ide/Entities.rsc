module lang::entities::ide::Entities

import lang::entities::syntax::Entities;
import lang::entities::syntax::Layout;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;

import lang::entities::ide::Check;
import lang::entities::ide::Outline;

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

