module lang::packages::utils::Parse

import lang::packages::syntax::Packages;
import lang::entities::syntax::Entities;
import lang::entities::syntax::Layout;
import lang::entities::syntax::Ident;
import lang::entities::syntax::Types;

import ParseTree;

public lang::packages::syntax::Packages::Package parsePackage(loc file) {
	return parse(#lang::packages::syntax::Packages::Package, file);
}

public lang::packages::syntax::Packages::Package parsePackage(str x, loc file) {
	return parse(#lang::packages::syntax::Packages::Package, x, file);
}

