CC=aarch64-linux-android-gcc

## use local path to build for 8155 android. 
CFLAGS += -Wall -pedantic -I -DHAVE___FPENDING -DTIME  -pie -fPIE \
		  -I/work/g7/lagvm_p/LINUX/android/out/soong/ndk/sysroot/usr/include -I /work/g7/lagvm_p/LINUX/android/out/soong/ndk/sysroot/usr/include/aarch64-linux-android/ \
		  --sysroot=/work/g7/lagvm_p/LINUX/android/prebuilts/ndk/r16/platforms/android-24/arch-arm64/ \
		   -L /work/g7/lagvm_p/LINUX/android/out/soong/ndk/platforms/android-24/arch-arm64/usr/lib


tinymembench: main.c util.o util.h asm-opt.h version.h asm-opt.o x86-sse2.o arm-neon.o mips-32.o aarch64-asm.o
	${CC} -O2 ${CFLAGS} -o tinymembench main.c util.o asm-opt.o x86-sse2.o arm-neon.o mips-32.o aarch64-asm.o -lm

util.o: util.c util.h
	${CC} -O2 ${CFLAGS} -c util.c

asm-opt.o: asm-opt.c asm-opt.h x86-sse2.h arm-neon.h mips-32.h
	${CC} -O2 ${CFLAGS} -c asm-opt.c

x86-sse2.o: x86-sse2.S
	${CC} -O2 ${CFLAGS} -c x86-sse2.S

arm-neon.o: arm-neon.S
	${CC} -O2 ${CFLAGS} -c arm-neon.S

aarch64-asm.o: aarch64-asm.S
	${CC} -O2 ${CFLAGS} -c aarch64-asm.S

mips-32.o: mips-32.S
	${CC} -O2 ${CFLAGS} -c mips-32.S

clean:
	-rm -f tinymembench
	-rm -f tinymembench.exe
	-rm -f *.o
