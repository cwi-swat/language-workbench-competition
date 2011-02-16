module languages::entities::utils::Merge

import languages::entities::utils::Parse;
import languages::entities::ast::Entities;

public Entities merge(loc files...) {
  return entities(( [] | it + parse(f).entities | f <- files)); 
}