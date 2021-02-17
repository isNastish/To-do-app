/* __________________________________HEADER FOR TO_DO APP____________________________________ 

This file consists of all important functions needed for our to-do app, 
there will be only primitivs.
All files stored in "/home/nastish/MyProject/database/" 

For detail description of the app see README.txt file 
*/

#ifndef APPLICATION_H
#define APPLICATION_H

/*
main colors macros.
For detail info see here. https://en.wikipedia.org/wiki/ANSI_escape_code
*/

#define C_BLACK                 "\x1b[30m"
#define C_RED                   "\x1b[31;1m"
#define C_RED_SLIM              "\x1b[31m"
#define C_GREEN                 "\x1b[32m"
#define C_YELLOW                "\x1b[33;1m"
#define C_BLUE                  "\x1b[34m"
#define C_MAGENTA               "\x1b[35;1m"
#define C_CYAN                  "\x1b[36;1m"
#define C_WHITE                 "\x1b[37;1m"

// reset all color to default
#define RESET_TO_DEF                "\x1b[0m"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h> // не стоит включать этот заголовочнай файл из-за одной функции, нужно просто написать ее

#define GLOB_FLAGSARRAY_LEN (sizeof flags_array_glob / sizeof(struct global_cmd_funcs_with_two_args))
#define DEF_STATUS "in progress"
#define MAXLINES 4 // executable file name, flag, another flag, date or header.
#define BUFSIZE 100
#define HEADER_DESCRP_LEN 50000
#define DATE_LEN 11
#define DOC_FILE_PATH "/home/nastish/MyProjects/To-do-app/database/appDoc.txt"
#define GLOBAL_DATA_PATH "/home/nastish/MyProjects/To-do-app/database/globData.bin"

/* creating new files */
FILE *globF; 
FILE *dayF;
unsigned char read_flag = 0;

struct universal_date
{
    unsigned short year;
    unsigned short month;
    unsigned short day;
};

/* main structure for working with global date (все данный во этой структуре мы будем ложить в бинарное дерево 
и сортировать по дате и выводить на экран от самой свежей к самой моздней )*/
struct global_data_node
{
    char *headerOfNode;
    int amountDays; // amount of days finishDate - beginDate;
    struct universal_date *beginDate;
    struct universal_date *finishDate;
    char *statusOfTask; // (done, in progress, rejected)
    char *description; // task description 

    struct global_data_node *leftnode;
    struct global_data_node *rightnode;
};

/* functions to work with structures */
struct global_data_node *talloc_global_task(void); // allocate memory for global_data_node struct
//struct dayTasksNode *tallocDayTask(void); // allocate memory for dayTasksNode struct
struct universal_date *talloc_date(struct universal_date *); // allocate date in memory
struct global_data_node *create_global_tree(struct global_data_node *, struct universal_date *, struct universal_date *, char *, char *, char *); // building a tree of struct global_data_node
//struct datTasksNode *createDayTree(struct dayTasksNode *, int, int); // building a tree of struct dayTasksNode? time in hours, in minutes
/* functions to allocate all description of structs*/
char *allocate_description(char *); 
struct global_data_node *glob_tree_print(struct global_data_node *, unsigned short);


/* simple functions for working with strings or numbers or something else */
int mystrlen(char *word){int n; for(n = 0; *word != '\0'; word++) {n++;} return n;} // length of string
int mystrcmp(const char *argv, char *flag){for(; *argv == *flag; argv++, flag++){if(*argv == '\0'){return 0;}} return *argv - *flag;} // compare strings
int compare_dates(struct universal_date *, struct universal_date *); // compare to dates
int amount_of_days_per_task(struct universal_date *, struct universal_date *); // differents beetwen start and finish in day


/* instruments for function (amountOfDaysPerTask()) */
static char days_in_month[][13] = {
    {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
    {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31} /* leap year */
};

int day_of_year(int, int, int); // compute day of year(how many days was passed after it had begun)
void date_parser(struct universal_date *dateP, char *date, int date_len); // розделяет строку в которой содержиться дата на беззнаковые целые числа
unsigned short myatoi(char []);

/* Functions and structures for parcing command line arguments */
// realization of all this functions will be in file main.c
void show_all_documentation(void); // читает файл с заданными командами и выводит возможные команды на экран

void display_all_globdata(struct global_data_node *, unsigned short identifier);
void error_date_print(struct universal_date);

struct global_data_node *add_glob_data(struct global_data_node *, char *); // header will receive from cm line
struct global_data_node *change_glob_status(struct global_data_node *, char *); // в командную строку поступает дата 
struct global_data_node *change_glob_header(struct global_data_node *, char *);
struct global_data_node *change_glob_description(struct global_data_node *, char *);
struct global_data_node *change_begin_date(struct global_data_node *, char *);
struct global_data_node *change_finish_date(struct global_data_node *, char *);
struct global_data_node *pre_deleting_node_func(struct global_data_node *, char *); // нужно сделать одну функцию для обеих структур
struct global_data_node *show_glob_data_by(struct global_data_node *, char *);

/* aditional functions for functions above */
struct global_data_node *find_date(struct global_data_node *, struct universal_date *, unsigned short sign); // return 1 if date was found and changed, else 0
struct global_data_node *find_date_and_print_content(struct global_data_node *, struct universal_date *);
// возможно набор всех флагов и их документация будут хранится тоже в отдельном файле .txt 

struct global_cmd_funcs_with_two_args
{
    const char *flag;
    struct global_data_node *(*flagFunc)(struct global_data_node *, char *);// pointer on fucntion with two arguments, pointer on struct and, date or time
} flags_array_glob[] = {
    /*-g*/"-sh", show_glob_data_by, 
    /*-g*/"-del", pre_deleting_node_func,
    /*-g*/"-a", add_glob_data,
    /*-g*/"-c", change_glob_status,
    /*-g*/"-h", change_glob_header,
    /*-g*/"-d", change_glob_description,
    /*-g*/"-bd", change_begin_date,
    /*-g*/"-fd", change_finish_date,
    "-ga", add_glob_data,
    "-gdel", pre_deleting_node_func,
    "-gc", change_glob_status,
    "-gh", change_glob_header,
    "-gd", change_glob_description,
    "-gsh", show_glob_data_by,
    "-gbd", change_begin_date,
    "-gfd", change_finish_date,
};

/* parcer function */
const char *inArgsPtr[MAXLINES];

//FILE* parserCmlineArgc(int, const char *[]);
int inside_prog_arg_parser(const char *[]); // returns how many args was written
void description_of_task_parser(char *); // description parcer
int mygetLine(char [], int);

/* writing and reading struct from file */
void write_glob_struct_to_file(struct global_data_node *, FILE *);
struct global_data_node *read_glob_struct_from_file(struct global_data_node *, FILE *);

struct global_data_node *glob_main_arg_parser(struct global_data_node *, int, const char *[], int *);

void show_documentation(void); /* read file where all our documentation stored and display it on the screen */
void printing_header_and_Descrp();

/* printing functiouns */
void print_first_five_columns(struct global_data_node *, unsigned int);
void print_top_of_table(int, int); /* print top piece of table */
void print_bottom_of_table(void); /* print bottom part of table */

/* print headerOfNode and description if in columns enough space */
void display_header_descrp(struct global_data_node *globP, unsigned int h_len, unsigned int d_len); 

/* print headerOfNode and description if in both columns not enough space to store data in one line */
void display_owersize_header_descrp(struct global_data_node *globP, unsigned int h_len, unsigned int d_len);
int display_owersize_header(struct global_data_node *globP, unsigned int h_len, int *h_i);
int display_owersize_descrp(struct global_data_node *globP, unsigned int d_len, int *d_i);

/* 
recursive func that print max amount of words which can be stored in one single line in column 
*/
void print_header(struct global_data_node *globP, unsigned int header_len, 
    unsigned int *nSymbols, int *i, int *k); 
void print_description(struct global_data_node *globP, unsigned int description_len,
    unsigned int *nSymbols, int *i, int *k); // ptiny description recursively


void print_whole_header(struct global_data_node *globP, unsigned int headerLen, 
    unsigned int descrpLen); /* function that print whole header from start to finish */
void print_whole_description(struct global_data_node *globP, 
    unsigned int descriptionLen); // function that prints whole description if size more then size of column 


struct global_data_node *make_tree_balanced(struct global_data_node *globP); /* function that make tree balanced always, 
        rebuild tree choicing average element by date as a root */
void free_whole_tree(struct global_data_node *rootP); // distruct whole tree

void input_date_begin(struct global_data_node *globP);
void input_date_finish(struct global_data_node *globP);
void input_status(struct global_data_node *globP);
void input_header(struct global_data_node *globP);
void input_description(struct global_data_node *glonP);
int date_manipulation(char *searching_date);

void printing_main_func(struct global_data_node *globP);

struct global_data_node *delete_node_by_date(struct global_data_node *rootP, struct universal_date *dateP);

/*
we can add functions that change date only after the function that makes tree
balanced will be written!

and we still need function that deletes nodes
*/

#endif
