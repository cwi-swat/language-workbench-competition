module Plugin

import languages::entities::ide::Entities;
import languages::instances::ide::Instances;
import languages::packages::ide::Packages;

public void main() {
	registerEntities();
	registerInstances();
	registerPackages();
}