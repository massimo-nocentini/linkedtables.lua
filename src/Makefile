

install:
	mkdir -p /usr/local/lib/lua/5.4/	# just for ensuring that the dest dir exists
	mkdir -p /usr/local/share/lua/5.4/	# just for ensuring that the dest dir exists
	cp linkedpool.lua linkedstack.lua linkedqueue.lua /usr/local/share/lua/5.4/

test:
	cd ../test/ && lua linkedstack-test.lua
	cd ../test/ && lua linkedqueue-test.lua
