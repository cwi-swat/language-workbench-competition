module languages::derived::compile::Derived2Java

import languages::entities::compile::Entities2Java;
import languages::entities::ast::Entities;
import languages::derived::ast::Derived;

public list[str] derived2java(Entities es) {
	return for (e <- es.entities) {
			append "
	public class <e.name.name> {
	<for (f <- e.fields) {>
	<field2java(f)>
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