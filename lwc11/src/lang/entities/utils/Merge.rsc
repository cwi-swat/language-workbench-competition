module lang::entities::utils::Merge

import lang::entities::utils::Parse;
import lang::entities::ast::Entities;

public Entities merge(loc files...) {
	return merge({ parse(f) | f <- files });
}

public Entities merge(set[Entities] ess) {
	return entities(( [] | it + es.entities | es <- ess ));
}