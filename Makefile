SRCDIR=src

VPATH=$(SRCDIR)

HDR=$(wildcard $(SRCDIR)/*.h)

CC := /scratch/android-stc/bin/aarch64-linux-android-gcc
CFLAGS := -Wall -O3 -g -std=c99 -fPIC -fopenmp -Wall -fPIE -pie -I/scratch/moskewcz/android/adreno/include 
SYSROOT := /scratch/moskewcz/android/sysroot_msm8996
#SYSROOT := /scratch/moskewcz/android/sysroot_msm8994
LDFLAGS := -fPIE -pie \
	-L${SYSROOT}/system/lib64 -Wl,-rpath-link,${SYSROOT}/system/lib64 \
	-L${SYSROOT}/system/vendor/lib64 -Wl,-rpath-link,${SYSROOT}/system/vendor/lib64 \
	-lOpenCL

SPARSE ?= sparse
SPARSEFLAGS=-Wsparse-all -Wno-decl

clinfo:

clinfo.o: clinfo.c $(HDR)

clean:
	$(RM) clinfo.o clinfo

sparse: clinfo.c
	$(SPARSE) $(CPPFLAGS) $(CFLAGS) $(SPARSEFLAGS) $^

.PHONY: clean sparse
