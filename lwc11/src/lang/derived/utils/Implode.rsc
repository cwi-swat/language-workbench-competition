module lang::derived::utils::Implode

import lang::entities::syntax::Entities;
import lang::derived::ast::Derived;
import lang::entities::ast::Entities;

import ParseTree;

public lang::entities::ast::Entities::Entities implode(lang::entities::syntax::Entities::Entities pt) {
	return implode(#lang::entities::ast::Entities::Entities, pt);
}