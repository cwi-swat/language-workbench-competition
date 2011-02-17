module languages::entities::compile::Entities2Java

import languages::entities::ast::Entities;
import String;

public list[str] entities2java(Entities es) {
	return for (e <- es.entities) {
		append "
public class <e.name.name> {
<for (f <- e.fields) {>
<field2java(f)>
<}>
}
";
	}	
}

public str capitalize(str s) {
  return toUpperCase(substring(s, 0, 1)) + substring(s, 1);
}

public str field2java(Field f) {
	t = type2java(f.\type);
	n = f.name;
	cn = capitalize(n);
	return "
private <t> <n>;
public <t> get<cn>() {
	return this.<n>;
}
public void set<cn>(<t> <n>) {
	this.<n> = <n>;
}
";
}

public str type2java(Type t) {
	switch (t) {
		case primitive(string()): 	return "java.lang.String";
		case primitive(date()): 	return "java.util.Date";
		case primitive(integer()):	return "java.lang.Integer";
		case primitive(boolean()):	return "java.lang.Boolean";
		case reference(Name n): 	return n.name;
		default: throw "Unhandled type: <t>";
	}
}
	
