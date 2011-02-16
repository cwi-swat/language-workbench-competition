module languages::entities::ast::Entities

data Entities 
	= entities(list[Entity] entities);
	
data Entity
	= entity(str name, list[Field] fields);
	
data Field 
	= field(Type \type, str name);

data Type 
	= primitive(PrimitiveType primitive)
	| reference(str name);

data PrimitiveType
	= string()
	| date()
	| integer()
	| boolean();

