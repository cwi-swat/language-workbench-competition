module languages::entities::ide::Entities

import SourceEditor;
import languages::entities::syntax::Entities;
import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;

import languages::entities::check::Entities;
import languages::entities::ast::Entities;

import List;
import ParseTree;
import IO;

public str ENTITIES_EXTENSION = "entities";

public void registerEntities() {
  	registerLanguage("Entities", ENTITIES_EXTENSION, Tree (str x, loc l) {
    	return parse(#languages::entities::syntax::Entities::Entities, x, l);
  	});
  
	registerOutliner("Entities", outline);
}   

node outline(languages::entities::syntax::Entities::Entities x) {
  	r = "ENTITIESFILE"("Entities"([
  					"entity"()[@label="<n>"][@\loc=e@\loc] 
  					| /`entity <Name n> { <Field* _> }` := x
  					]))[@label="Entities"];
  	println(r);
  	return r;
}

/* 
  // This causes an infinite loop currently; the markers trigger a document change
  registerAnnotator("Entities", languages::entities::syntax::Entities::Entities (languages::entities::syntax::Entities::Entities input) {
  		Tree pt = input;
  		ast = implode(#languages::entities::ast::Entities::Entities, pt);
  		errors = check(ast);
  		pt@messages = toSet(errors);
  		return pt;
	}
  );
}
*/