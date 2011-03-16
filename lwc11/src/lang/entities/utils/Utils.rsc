module languages::entities::utils::Utils

import Graph;

public Graph[&T] reflexiveReduction(Graph[&T] g) {
  return { <x, y> | <x, y> <- g, x != y };
}

public Graph[&T] symmetricReduction(Graph[&T] g) {
  result = {};
  for (<x, y> <- g) {
      if (<y, x> in g) {
         if (<y, x> notin result) {
            result += {<x, y>};
         }
      }
      else {
        result += {<x,y>};
      }
  }
  return result;
}

public Graph[&T] symmetricReflexiveReduction(Graph[&T] g) {
  return symmetricReduction(reflexiveReduction(g));
}