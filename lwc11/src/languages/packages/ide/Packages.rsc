module languages::packages::ide::Packages

import SourceEditor;
import languages::packages::syntax::Packages;
import languages::entities::syntax::Entities;
import languages::entities::syntax::Layout;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;

import languages::packages::ast::Packages;

import ParseTree;

public str PACKAGE_EXTENSION = "package";

public void registerPackages() {
  registerLanguage("Packages", PACKAGE_EXTENSION, Tree (str x, loc l) {
    return parse(#languages::packages::syntax::Packages::Package, x, l);
  });
}