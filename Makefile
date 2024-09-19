# makefile for vgp-tools/src containing library and core utilities

DEST_DIR = ./bin

CFLAGS = -O3 -Wall -fPIC -Wextra -Wno-unused-result -fno-strict-aliasing -DNDEBUG # NDEBUG drops asserts
#CFLAGS = -g -Wall -Wextra -fno-strict-aliasing  # for debugging

CCPP = g++

LIB = libONE.a
PROGS = ONEstat ONEview

all: $(LIB) $(PROGS)

clean:
	$(RM) *.o ONEstat ONEview $(LIB) ZZ* TEST/ZZ* ONEcpptest.cpp ONEcpptest
	$(RM) -r *.dSYM

install:
	mkdir -p $(DEST_DIR)
	cp $(PROGS) $(DEST_DIR)

package:
	make clean
	tar -zcf ONE-core.tar.gz *.c *.h Makefile

### library

LIB_OBJS = ONElib.o

ONElib.o: ONElib.h

$(LIB): $(LIB_OBJS)
	ar -cr $@ $^
	ranlib $@

### programs

ONEstat: ONEstat.c $(LIB)
	$(CC) $(CFLAGS) -o $@ $^

ONEview: ONEview.c $(LIB)
	$(CC) $(CFLAGS) -o $@ $^

### test

test: ONEview TEST
	./ONEview TEST/small.seq
	./ONEview -b -o TEST/ZZ-small.1seq TEST/small.seq
	bash -c "cd TEST ; source t1.sh ; source t2.sh ; cd .."

ONEcpptest.cpp: ONElib.hpp
	\ln -s ONElib.hpp $@

ONEcpptest: ONEcpptest.cpp ONElib.o
	$(CCPP) -D TEST_HEADER -o $@ $^

cpptest: ONEcpptest
	./ONEcpptest TEST/ZZ-small.1seq

### end of file
