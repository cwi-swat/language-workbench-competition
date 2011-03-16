module lang::entities::utils::Test

import lang::entities::utils::Parse;
import lang::entities::utils::Merge;
import lang::entities::ast::Entities;

private str ROOT = "lwc11/src/lang/entities/utils";

public Entities personEntities() {
  return parse(|project://<ROOT>/person.entities|);
}

public Entities mergedPersonCar() {
  return merge(|project://<ROOT>/person.entities|, |project://<ROOT>/car.entities|);
}
