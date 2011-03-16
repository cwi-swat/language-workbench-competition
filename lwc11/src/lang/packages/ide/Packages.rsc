module lang::packages::ide::Packages

import SourceEditor;
import lang::packages::syntax::Packages;
import lang::entities::syntax::Entities;
import lang::entities::syntax::Layout;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;

import lang::packages::ast::Packages;
import lang::packages::ide::Outline;

import ParseTree;

public str PACKAGE_EXTENSION = "package";

public void registerPackages() {
 	registerLanguage("Packages", PACKAGE_EXTENSION, Tree (str x, loc l) {
    	return parse(#lang::packages::syntax::Packages::Package, x, l);
  	});
  	registerOutliner("Packages", outlinePackage);
}