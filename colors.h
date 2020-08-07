/*______________________COLORS SET___________________________

All colors for printing our data to console, detail information 
about colors see here: 
https://ru.wikipedia.org/wiki/Управляющие_последовательности_ANSI

*/


#ifndef COLORS_H

#define COLOROS_H

/* main colors macros */

#define C_BLACK                 "\x1b[30m"
#define C_RED                   "\x1b[31;1m"
#define C_RED_SLIM              "\x1b[31m"
#define C_GREEN                 "\x1b[32m"
#define C_YELLOW                "\x1b[33;1m"
#define C_BLUE                  "\x1b[34m"
#define C_MAGENTA               "\x1b[35;1m"
#define C_CYAN                  "\x1b[36;1m"
#define C_WHITE                 "\x1b[37m"

// reset all color to default
#define RESET_TO_DEF                "\x1b[0m"

#endif
