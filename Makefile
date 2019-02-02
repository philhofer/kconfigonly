KERNVER=4.19.19

kbuild-${KERNVER}.tar.gz: linux-${KERNVER}.tar.xz
	./extract.sh $< $@

linux-${KERNVER}.tar.xz:
	curl https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-${KERNVER}.tar.xz -o $@

all: kbuild-${KERNVER}.tar.gz

clean:
	rm -r linux-*/
	rm -f *.tar.gz *.xz
