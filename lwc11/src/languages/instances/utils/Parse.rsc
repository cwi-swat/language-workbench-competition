module languages::instances::utils::Parse

import languages::instances::syntax::Instances;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Types;
import languages::entities::syntax::Layout;

import languages::instances::ast::Instances;
import ParseTree;

public languages::instances::ast::Instances::Instances parse(loc file) {
	pt = parse(#languages::instances::syntax::Instances::Instances, file);
	return implode(#languages::instances::ast::Instances::Instances, pt);
}