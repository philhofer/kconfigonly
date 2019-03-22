.SUFFIXES:=

kversion.mk:
	./latest-kversion > $@

# pick up KERNVER
include kversion.mk

kbuild-${KERNVER}.tar.gz: linux-${KERNVER}.tar.xz
	./extract.sh $< $@

linux-${KERNVER}.tar.xz:
	curl https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${KERNVER}.tar.xz -o $@

.PHONY: all clean
all: kbuild-${KERNVER}.tar.gz

clean:
	rm kversion.mk
	rm -r linux-*/
	rm -f *.tar.gz *.xz
