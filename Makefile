CFLAGS+=-O2 -g

IS_ARM:=$(shell bash -c 'uname -a | grep arm>/dev/null && echo 1 || echo 0')
ifeq (${IS_ARM},1)
CFLAGS+=-march=armv6 -mfloat-abi=hard -mfpu=vfp
else
CFLAGS+=-march=native
endif

all:	bench
	
bench:	| dhry whet
	@echo --------------------
	@echo Running Dhrystone...
	@echo --------------------
	@echo | ./dhry
	@echo --------------------
	@echo Running Whetstone...
	@echo --------------------
	@echo | ./whet
	@echo =================================
	@echo =================================
	@echo "Results:"
	@head Dhry.txt
	@head -19 whets.txt

dhry:	cpuidc.o  dhry_1.o dhry_2.o
	${CC} -o $@ $^

whet:	cpuidc.o whets.o
	${CC} -o $@ $^ -lm

%.o:	%.c
	${CC} -c -o $@ ${CFLAGS} $<

clean:
	rm -f *.o dhry whet Dhry.txt whets.txt
