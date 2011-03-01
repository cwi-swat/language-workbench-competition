module languages::instances::ide::Links

import languages::instances::syntax::Instances;
import languages::entities::syntax::Ident;
import languages::entities::syntax::Layout;

import ParseTree;
import IO;

anno loc Ident@link;

public Instances annotateWithLinks(Instances is) {
	ns = ( i.name.id: i.name@\loc | /Instance i := is );
	return visit (is) {
		case Value v => visit(v) { case Ident n :
			if (n in ns) {
				n@link = ns[n];
				println("Adding link to <n> ( <ns[n]> )");
				insert n;
			}
			else {
				fail;
			}
		}
	}
}