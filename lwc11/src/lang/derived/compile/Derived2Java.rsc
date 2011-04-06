module lang::derived::compile::Derived2Java

import String;
import List;

extend lang::entities::compile::Entities2Java;
import lang::derived::ast::Derived;

public str field2java(derived(t, n, exp)) {
	return getter(t, n, exp2java(exp));
}

public str field2java(annotated(host(a), t, n)) {
	method = substring(a, 1, size(a) - 1);
	return getter(t, n, "<method>(this)");
}

private str getter(Type t, str n, value exp) {
	<tn, cn> = <type2java(t), capitalize(n)>;
	return "public <tn> get<cn>() {
	       '    return <exp>;
           '}";
}

public str exp2java(const(integer(n))) 			= "<n>";
public str exp2java(const(float(f))) 			= "<f>";
public str exp2java(const(boolean(b))) 			= "<b>";
public str exp2java(const(string(s))) 			= replaceAll(s, "\n", "\\n\"\n\t + \"");
public str exp2java(const(date(d, m, y)))		= "new java.util.Date(<y>, <m>, <d>)";
public str exp2java(Expression::field(n))		= "get<capitalize(n)>()";
public str exp2java(neg(a))						= "(-<exp2java(a)>)";
public str exp2java(mul(lhs, rhs))				= "(<exp2java(lhs)> * <exp2java(rhs)>)";
public str exp2java(div(lhs, rhs))				= "(<exp2java(lhs)> / <exp2java(rhs)>)";
public str exp2java(add(lhs, rhs))				= "(<exp2java(lhs)> + <exp2java(rhs)>)";
public str exp2java(sub(lhs, rhs))				= "(<exp2java(lhs)> - <exp2java(rhs)>)";

public list[str] derived2java(Entities es) {
	return entities2java(es);
}
