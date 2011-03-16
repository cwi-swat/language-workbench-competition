module lang::packages::utils::Parse

import lang::packages::ast::Packages;
import lang::packages::syntax::Packages;
import lang::entities::syntax::Entities;
import lang::entities::syntax::Layout;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;

import ParseTree;

public lang::packages::ast::Packages::Package parse(loc file) {
	return implode(#lang::packages::ast::Packages::Package,
			parse(#lang::packages::syntax::Packages::Package, file));
}
