module lang::packages::utils::Implode

import lang::packages::ast::Packages;
import lang::packages::syntax::Packages;

import ParseTree;

public lang::packages::ast::Packages::Package implode(lang::packages::syntax::Packages::Package pt) {
	return implode(#lang::packages::ast::Packages::Package, pt);
}
