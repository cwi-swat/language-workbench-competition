module languages::instances::ide::Instances


import languages::instances::syntax::Instances;
import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;

import languages::instances::check::Instances;
import languages::instances::ast::Instances;
import languages::entities::ast::Entities;

import List;
import ParseTree;
import SourceEditor;



public void registerInstances() {
  registerLanguage("Instances", "instances", Tree (str x, loc l) {
    	return parse(#languages::instances::syntax::Instances::Instances, x, l);
  });

/*  
  registerAnnotator("Instances", languages::instances::syntax::Instances::Instances (languages::instances::syntax::Instances::Instances input) {
  		Tree pt = input;
  		ast = implode(#languages::instances::ast::Instances::Instances, pt);
  		errors = check(ast, entities([]));
  		pt@messages = toSet(errors);
  		return pt;
	}
  );
*/
}