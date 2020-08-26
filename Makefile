# -*- Makefile -*-

# I prefer all steps in compilation.

application: application.o
	gcc application.o -o application

application.o: application.s application.h
	gcc -c application.s

application.s: application.c
	gcc -S application.c 
	

#gcc -E application.c
# remove all .o files, all .s files, and executable application file
clean:
	rm *.o *.s application
