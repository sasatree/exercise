
gcc_options = -std=c++17 -Wall -Wextra --pedantic-errors -g

program : main.cpp gf.o all.h.gch
	g++ $(gcc_options) -include all.h $< -o $@

gf.o : gf.cpp gf.hpp addGFAlpha.hpp all.h.gch
	g++ $(gcc_options) -include all.h -c $< -o $@

all.h.gch : all.h
	g++ $(gcc_options) -x c++-header -o $@ $<

run : program
	./program

clean :
	rm -f ./program
	rm -f ./all.h.gch
	rm -f ./gf.o
	rm -rf ./program.dSYM

.PHONY : run clean
