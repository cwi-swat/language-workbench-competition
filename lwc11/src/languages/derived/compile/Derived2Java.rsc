module languages::derived::compile::Derived2Java

import languages::entities::compile::Entities2Java;
import languages::entities::ast::Entities;
import languages::derived::ast::Derived;

import String;
import List;

public list[str] derived2java(Entities es) {
	return for (e <- es.entities) {
			append "
	public class <e.name.name> {
	<for (f <- e.fields) {>
	<if (f is annotated) {>
		<annotated2java(f, e)>
	<} else {>
		<field2java(f)>
	<}>
	<}>
	}
	";
	}
	// does not work, extension of field2java is not seen
	// within Entities2Java	
	return entities2java(es);
}

// need extend module to allow extension of func in Entities2Java
public str field2java(derived(t, n, exp)) {
	<tn, cn> = <type2java(t), capitalize(n)>;
	return "
public <tn> get<cn>() {
	return <exp2java(exp)>;
}
";
}

public str annotated2java(Field f, Entity e) {
	<tn, cn> = <type2java(f.\type), capitalize(f.name)>;
	gs = [ "get<capitalize(other.name)>()" | other <- e.fields, other != f ];
	assert f.annotation.name == "host";
	method = substring(f.annotation.string, 1, size(f.annotation.string) - 1);
	return "
public <tn> get<cn>() {
	return <method>(<intercalate(", ", gs)>);
}
	";
}


public str exp2java(Expression exp) {
	switch (exp) {
	 	case nat(n): 		return "<n>";
		case field(n):		return "this.<n>";
		case neg(a):		return "(-<exp2java(a)>)";
		case mul(lhs, rhs):	return "(<exp2java(lhs)> * <exp2java(rhs)>)";
		case div(lhs, rhs):	return "(<exp2java(lhs)> / <exp2java(rhs)>)";
		case add(lhs, rhs):	return "(<exp2java(lhs)> + <exp2java(rhs)>)";
		case sub(lhs, rhs):	return "(<exp2java(lhs)> - <exp2java(rhs)>)";
		default: throw "Unhandled expression: <exp>";
	}
}