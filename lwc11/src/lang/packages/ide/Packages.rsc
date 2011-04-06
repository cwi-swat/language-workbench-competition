module lang::packages::ide::Packages

import util::IDE;
import lang::packages::syntax::Packages;
import lang::packages::check::Packages;
import lang::packages::ide::Outline;
import lang::packages::utils::Implode;
import lang::packages::utils::Parse;

import ParseTree;
import List;

public str PACKAGE_EXTENSION = "package";

public void registerPackages() {
 	registerLanguage("Packages", PACKAGE_EXTENSION, parsePackage);
  	registerOutliner("Packages", outlinePackage);
  	registerAnnotator("Packages", checkAndAnnotatePT); 
}

private Package checkAndAnnotatePT(Package pt) {
  	return pt[@messages = toSet(check(|project://lwc11/input|,implode(pt)))];
}