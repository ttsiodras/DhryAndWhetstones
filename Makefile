CFLAGS+=-O2 -g
CFLAGS+=-march=native

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

stats:
	@cd my.machines/ ; grep VAX * | sort -n -k 6 | sed 's, *VAX.*= *,,'

clean:
	rm -f *.o dhry whet Dhry.txt whets.txt
