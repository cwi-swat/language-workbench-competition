module languages::box::transform::Box2XML

import box::Box;
import XMLDOM;
import List;


private str DEFAULT_STYLES = "
body {
	font-family: Monaco, Courier;
	font-size: 10pt;
}

.keyword {
	font-weight: bold;
	color: rgb(157,65, 126);
}

.variable {
	font-style: italic;
}
";

private Node DEFAULT_STYLE_ELEMENT = element(none(), "style", [
											attribute(none(), "type", "text/css"),
											charData(DEFAULT_STYLES)
										]);

public Node box2html(Box box) {
	return document(
		element(none(), "html", [
			element(none(), "head", [DEFAULT_STYLE_ELEMENT]),
			element(none(), "body", [box2xml(box)])
		])
	);
}

public Node box2xml(Box box) {
	switch (box) {
		case H(list[Box] h): return normal(h, box@hs);
	    case V(list[Box] v): return vertical(v, box@vs ? 0);
	    case HOV (list[Box] hov): return normal(hov, box@hs);
	    case HV (list[Box] hv): return normal(hv, box@hs);
	    case I(list[Box] i): return itemized(i);
	    //case R(list[Box] r): return row(r);
	    //case A(list[Box] a): return table(a);
	    case L(str l): return charData(l);
	    case KW(Box kw): return span("keyword", kw);
	    case VAR(Box var): return span("variable", var);
	    case NM(Box nm): return span("name", nm);
	    case STRING(Box string): return span("string", string);
	    case COMM(Box comm): return span("comment", comm);
	    case MATH(Box math): return span("math", math);
	    default: throw "Unsupported box expression: <box>";
	}

}

public Node span(str class, Box box) {
	return element(none(), "span", [attribute(none(), "class", class), box2xml(box)]);
}

public Node normal(list[Box] bs, int hs) {
	return element(none(), "div", [
		attribute(none(), "style", "display: inline;"),
		hspaced(bs, hs)]);
}


public list[Node] hspaced(list[Box] bs, int hs) {
	return spaced(bs, hs, entityRef("nbsp"));
}

public list[Node] vspaced(list[Box] bs, int vs) {
	return spaced(bs, vs, element(none(), "br", []));
}

public list[Node] spaced(list[Box] bs, int s, Node space) {
	if (bs == []) {
		return [];
	}
	spaces = [];
	if (s > 0) {
		spaces = [ space | i <- [0..s-1] ];
	}
	return ( [box2xml(head(bs))] |  it + spaces + [box2xml(b)] | b <- tail(bs) );
}


public Node vertical(list[Box] bs, int vs) {
	return element(none(), "div", vspaced(bs, vs));
}

public Node itemized(list[Box] bs) {
	return element(none(), "ul",[
		attribute(none(), "style", "list-style-type: none;"),
		[ element(none(), "li", [box2xml(b)]) | b <- bs ]]);
}

anno int Box@hs;
anno int Box@vs;
anno int Box@is;
anno int Box@width;
anno int Box@height;
