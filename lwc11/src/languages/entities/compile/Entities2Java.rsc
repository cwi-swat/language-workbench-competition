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

public str field2java(field(typ, n)) {
	<t, cn> = <type2java(typ), capitalize(n)>;
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

public str type2java(primitive(string())) = 	"java.lang.String";
public str type2java(primitive(date())) = 		"java.util.Date";
public str type2java(primitive(integer())) = 	"java.lang.Integer";
public str type2java(primitive(boolean())) = 	"java.lang.Boolean";
public str type2java(reference(name(str n))) = 	n;


