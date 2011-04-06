module lang::derived::ide::Derived

import lang::derived::syntax::Derived;
import lang::entities::syntax::Entities;

// TODO: type check expressions
import lang::entities::check::Entities;
import lang::entities::ide::Outline;
import lang::derived::utils::Parse;
import lang::derived::utils::Implode;
import lang::derived::compile::Derived2Java;

import util::IDE;
import List;
import IO;
import Message;
import ParseTree;

public str DERIVED_EXTENSION = "derived";
public str DERIVED_LANGUAGE = "Derived";

public void generateJava(Entities pt, loc l) {
	for (<name, class> <- entities2java(implode(pt))) {
		writeFile(|project://lwc11/output/<name>.java|, class);
	}
}


public void registerDerived() {
	contribs = {
		popup(
			menu(DERIVED_LANGUAGE,[
	    		action("Generate Java", generateJava) 
		    ])
	  	)
	};
	
  	registerLanguage(DERIVED_LANGUAGE, DERIVED_EXTENSION, parseEntities);
  	registerAnnotator(DERIVED_LANGUAGE, checkAndAnnotatePT);
	registerOutliner(DERIVED_LANGUAGE, outlineEntities);
	registerContributions(DERIVED_LANGUAGE, contribs);
}   

private Entities checkAndAnnotatePT(Entities pt) {
  	return pt[@messages = toSet(check(implode(pt)))];
}

