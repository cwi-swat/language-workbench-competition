module languages::entities::utils::Test

import languages::entities::utils::Parse;
import languages::entities::utils::Merge;
import languages::entities::ast::Entities;

private str ROOT = "lwc11/src/languages/entities/utils";

public Entities personEntities() {
  return parse(|project://<ROOT>/person.entities|);
}

public Entities mergedPersonCar() {
  return merge(|project://<ROOT>/person.entities|, |project://<ROOT>/car.entities|);
}
