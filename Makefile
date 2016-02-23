export NODE_ENV = test
export TAKY_DEV = 1

main:
	if [ -a build ] ; \
	then \
			rm -rf build/ ; \
	fi;
	mkdir build
	iced -c --runtime inline --output build module.iced

r:
	$(MAKE)
	node build/module.js

