
.PHONY: all clean deb-package

all: deb-package

deb-package:
	if [ ! -d .build ] ; then  mkdir .build ; fi
	if [ ! -d .build/usr/libexec/transix-dslite-tunnel ] ; then mkdir -p .build/usr/libexec/transix-dslite-tunnel ; fi
	if [ ! -d .build/etc/iproute2/rt_tables.d ] ; then mkdir -p .build/etc/iproute2/rt_tables.d ; fi
	cp src/transix-dslite-tunnel.sh .build/usr/libexec/transix-dslite-tunnel
	cp src/dslite.conf .build/etc/iproute2/rt_tables.d
	cp -r DEBIAN .build/
	if [ ! -d .build/lib/systemd/system ] ; then mkdir -p .build/lib/systemd/system ; fi
	cp src/transix-dslite-tunnel.service .build/lib/systemd/system
	fakeroot dpkg-deb --build .build . 
clean:
	if [ -d .build ] ; then rm -r .build ; fi
	find . -type f -name '*~' -delete





