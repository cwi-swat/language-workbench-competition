module lang::entities::compile::Entities2Java

import lang::entities::ast::Entities;
import String;

public rel[str,str] entities2java(Entities es) {
	return { <e.name.name, entity2java(e)> | e <- es.entities };
}

public str entity2java(Entity e) {
	return "public class <e.name.name> {
           '<for (f <- e.fields) {>
           '  <field2java(f)>
           '<}>
		   '}";
}


public str field2java(Field::field(typ, n)) {
	<t, cn> = <type2java(typ), capitalize(n)>;
	return "private <t> <n>;
		   'public <t> get<cn>() {
	       '    return this.<n>;
           '}
           'public void set<cn>(<t> <n>) {
	       '    this.<n> = <n>;
           '}";
}

public str type2java(primitive(string())) = 	"java.lang.String";
public str type2java(primitive(integer())) = 	"java.lang.Integer";
public str type2java(primitive(boolean())) = 	"java.lang.Boolean";
public str type2java(primitive(date())) = 		"java.util.Date";
public str type2java(primitive(currency())) = 	"java.util.Currency";
public str type2java(reference(name(str n))) = 	n;


public str capitalize(str s) {
  return toUpperCase(substring(s, 0, 1)) + substring(s, 1);
}
