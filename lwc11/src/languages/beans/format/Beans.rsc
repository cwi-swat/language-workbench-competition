module languages::beans::format::Beans

import languages::beans::ast::Beans;

import box::Box;
import box::Box2Text;

import String;

data Bean
	= class(str name, list[Attribute] attributes, list[Accessor] accessors);

data Attribute
	= attribute(str name, str \type);

data Accessor
	= setter(str name, str \type)
	| getter(str name, str \type);
	


public str format(Bean bean) {
	return format(bean2box(bean));
}

public Box bean2box(Bean bean) {
	return V([
		H([
			KW(L("public")), KW(L("class")), VAR(L(bean.name)), L("{")
		])[@hs=1],
		I([
			V(
				[ attr2box(a) | a <- bean.attributes ]
				+ [acc2box(a) | a <- bean.accessors ]
			)
		]),
		L("}")
	]);		
}

public Box attr2box(Attribute a) {
	return H([
		KW(L("private")), L(a.\type), VAR(L(a.name))
	])[@hs=1];
}

public Box acc2box(Accessor a) {
	switch (a) {
		case setter(n, t):
			return V([H([
				KW(L("public")), 
				KW(L("void")), 
				H([
					VAR(L("set" + capitalize(a.name))),
					L("("),
					L(a.\type)
				])[@hs=0],
				H([
					VAR(L(a.name)),
					L(")")
				])[@hs=0],
				L("{")
			])[@hs=1],
			I([
				H([
					H([
						KW(L("this")),
						L("."),
						VAR(L(a.name))
					])[@hs=0],
					L("="),
					H([
						VAR(L(a.name)),
						L(";")
					])[@hs=0]
				])[@hs=1]
			]),
			L("}")
			]);
		
		case getter(n, t): 
		 return V([H([
				KW(L("public")), 
				L(a.\type), 
				H([
					VAR(L("get" + capitalize(a.name))),
					L("()")
				])[@hs=0],
				L("{")
			])[@hs=1],
			I([
				H([
					KW(L("return")),
					H([
						KW(L("this")),
						L("."),
						VAR(L(a.name)),
						L(";")
					])[@hs=0]
				])[@hs=1]
			]),
			L("}")
			]);
	}
}

public str capitalize(str s) {
  return toUpperCase(substring(s, 0, 1)) + substring(s, 1);
}