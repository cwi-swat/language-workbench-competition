module languages::entities::ast::Entities

data Entities 
	= entities(list[Entity] entities);
	
data Entity
	= entity(Name name, list[Field] fields);
	
data Field 
	= field(Type \type, str name);

data Type 
	= primitive(PrimitiveType primitive)
	| reference(Name name);
	
data Name
	= name(str name);

data PrimitiveType
	= string()
	| date()
	| integer()
	| boolean();

anno loc Entities@location;
anno loc Entity@location;
anno loc Field@location;
anno loc Type@location;
anno loc Name@location;

anno str Name@print;
