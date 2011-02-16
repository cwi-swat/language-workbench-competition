module Plugin

import SourceEditor;
import languages::entities::syntax::Entities;
import ParseTree;

public void main() {
  registerLanguage("Entities", "entities", Tree (str x) {
    return parse(#Entities, x);
  });
}