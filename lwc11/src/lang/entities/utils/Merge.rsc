module languages::entities::utils::Merge

import languages::entities::utils::Parse;
import languages::entities::ast::Entities;

public Entities merge(loc files...) {
	return merge({ parse(f) | f <- files });
}

public Entities merge(set[Entities] ess) {
	return entities(( [] | it + es.entities | es <- ess ));
}