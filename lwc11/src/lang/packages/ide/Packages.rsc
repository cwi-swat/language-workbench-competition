module lang::packages::ide::Packages

import util::IDE;
import lang::packages::syntax::Packages;
import lang::packages::check::Packages;
import lang::packages::ide::Outline;
import lang::packages::utils::Implode;
import lang::packages::utils::Parse;
import lang::packages::compile::Package2Java;
import lang::packages::compile::Package2XML;


import ParseTree;
import List;
import Message;
import XMLDOM;
import IO;

public str PACKAGES_EXTENSION = "package";
public str PACKAGES_LANGUAGE = "Packages";

public void generateJava(Package  pt, loc l) {
	for (<name, class> <- package2java(implode(pt))) {
		writeFile(|project://lwc11/output/<name>.java|, class);
	}
}

public void generateXML(Package pt, loc l) {
	xml = package2xml(implode(pt));
	writeXMLPretty(|project://lwc11/output/<baseName(l)>.xml|, xml);
}

private str baseName(loc l) {
	if (/\/<base:[a-zA-Z0-9_]+>\.package$/ := l.path) {
		return base;
	}
	throw "Could not match basename in <l.path>";
}


public void registerPackages() {
	contribs = {
		popup(
			menu(PACKAGES_LANGUAGE,[
	    		action("Generate Java", generateJava), 
	    		action("Generate XML", generateXML) 
		    ])
	  	)
	};
	

 	registerLanguage(PACKAGES_LANGUAGE, PACKAGES_EXTENSION, parsePackage);
  	registerOutliner(PACKAGES_LANGUAGE, outlinePackage);
  	registerAnnotator(PACKAGES_LANGUAGE, checkAndAnnotatePT);
  	registerContributions(PACKAGES_LANGUAGE, contribs);
  	 
}

public Package checkAndAnnotatePT(Package pt) {
  	return pt[@messages = { m | m <- check(|project://lwc11/input|, implode(pt)), m.at.path == (pt@\loc).path }];
}

