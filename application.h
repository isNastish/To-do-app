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

#define APP__VERSION "1.0.1"
#define PATH_SIZE 60 // size of array that contains path
#define DAY_FLAGSARRAY_LEN (sizeof flagsArrayDay / sizeof(struct daycmdFuncsWithTwoArgs))
#define GLOB_FLAGSARRAY_LEN (sizeof flagsArrayGlob / sizeof(struct globalcmdFuncsWithTwoArgs))
#define DEF_STATUS "in progress"
#define MAXLINES 4 // executable file name, flag, another flag, date or header.
#define BUFSIZE 100
#define ALLOCSIZE 1000
#define HEADER_DESCRP_LEN 50000
#define DATE_LEN 11
#define DOC_FILE_PATH "/home/nastish/MyProjects/To-do-app/database/appDoc.txt"

/* creating new files */
FILE *createFile(FILE *, char *);

struct universalDate
{
    unsigned short year;
    unsigned short month;
    unsigned short day;
};

/* main structure for working with global date (все данный во этой структуре мы будем ложить в бинарное дерево 
и сортировать по дате и выводить на экран от самой свежей к самой моздней )*/
struct globalDataNode
{
    char *headerOfNode;
    int amountDays; // amount of days finishDate - beginDate;
    struct universalDate *beginDate;
    struct universalDate *finishDate;
    char *statusOfTask; // (done, in progress, rejected)
    char *description; // task description 

    struct globalDataNode *leftnode;
    struct globalDataNode *rightnode;
};


/* main structure for working with day tasks (все данные типа этой структуры мы будем маллочить выделяя
память сначала для одной структуры такого типа, а потом если что будем делать realloc(), причем будем сортировать 
алгоритмом быстрой сортировки по времени
*/
struct tasksOnDay
{
    unsigned short hours;
    unsigned short minutes;
    char *status;
    char *descriptionOfTask;
};

/* global pointers to both struct */
//struct dayTasksNode *dayRootPtr = NULL;
//struct globalDataNode *globRootPtr = NULL;

/* functions to work with structures */
struct globalDataNode *tallocGlobaltask(void); // allocate memory for globalDataNode struct
//struct dayTasksNode *tallocDayTask(void); // allocate memory for dayTasksNode struct
struct universalDate *tallocDate(struct universalDate *); // allocate date in memory
struct globalDataNode *createGlobalTree(struct globalDataNode *, struct universalDate *, struct universalDate *, char *, char *, char *); // building a tree of struct globalDataNode
//struct datTasksNode *createDayTree(struct dayTasksNode *, int, int); // building a tree of struct dayTasksNode? time in hours, in minutes
/* functions to allocate all description of structs*/
char *allocateDescription(char *); 
void globTreeprint(struct globalDataNode *);


/* simple functions for working with strings or numbers or something else */
int mystrlen(char *word){int n; for(n = 0; *word != '\0'; word++) {n++;} return n;} // length of string
int mystrcmp(const char *argv, char *flag){for(; *argv == *flag; argv++, flag++){if(*argv == '\0'){return 0;}} return *argv - *flag;} // compare strings
int compareDates(struct universalDate *, struct universalDate *); // compare to dates
int amountOfDaysPerTask(struct universalDate *, struct universalDate *); // differents beetwen start and finish in day


/* instruments for function (amountOfDaysPerTask()) */
static char daysInmonth[][13] = {
    {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
    {0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31} /* leap year */
};

int dayOfyear(int, int, int); // compute day of year(how many days was passed after it had begun)
int comapareTime(int []);
void dateParser(struct universalDate *, char [], int); // розделяет строку в которой содержиться дата на беззнаковые целые числа
unsigned short myatoi(char []);

/* Functions and structures for parcing command line arguments */
// realization of all this functions will be in file main.c
void showAllDocumentation(void); // читает файл с заданными командами и выводит возможные команды на экран

void displayAllGlobData(struct globalDataNode *);
void displayAllDayData(struct tasksOnDay *);

struct globalDataNode *addGlobData(struct globalDataNode *, char *); // header will receive from cm line
struct globalDataNode *changeGlobStatus(struct globalDataNode *, char *); // в командную строку поступает дата 
struct globalDataNode *changeGlobHeader(struct globalDataNode *, char *);
struct globalDataNode *changeGlobDescription(struct globalDataNode *, char *);
struct globalDataNode *showGlobDataBy(struct globalDataNode *, char *);
struct globalDataNode *deleteGlobDataBy(struct globalDataNode *, char *); // нужно сделать одну функцию для обеих структур
struct globalDataNode *change_begin_date(struct globalDataNode *, char *);
struct globalDataNode *change_finish_date(struct globalDataNode *, char *);
struct globalDataNode *change_header(struct globalDataNode *, char *);
struct globalDataNode *change_description(struct globalDataNode *, char *);

struct tasksOnDay *showDayDataBy(struct tasksOnDay *, char *);
struct tasksOnDay *changeDayStatus(struct tasksOnDay *, char *);
struct tasksOnDay *addDayData(struct tasksOnDay *, char *); // header 
struct tasksOnDay *deleteDayDataBy(struct tasksOnDay *, char *);

/* aditional functions for functions above */
struct globalDataNode *findstatusinTree(struct globalDataNode *, struct universalDate *); // return 1 if date was found and changed, else 0
struct globalDataNode *finddateinTree(struct globalDataNode *, struct universalDate *);
// возможно набор всех флагов и их документация будут хранится тоже в отдельном файле .txt 

struct globalcmdFuncsWithTwoArgs
{
    const char *flag;
    struct globalDataNode *(*flagFunc)(struct globalDataNode *, char *);// pointer on fucntion with two arguments, pointer on struct and, date or time
} flagsArrayGlob[] = {
    /*-g*/"-sh", showGlobDataBy, 
    /*-g*/"-d", deleteGlobDataBy,
    /*-g*/"-a", addGlobData,
    /*-g*/"-c", changeGlobStatus,
    /*-g*/"-bd", change_begin_date,
    /*-g*/"-fd", change_finish_date,
    /*-g*/"-h", change_header,
    /*-g*/"-ds", change_description,
    "-ga", addGlobData,
    "-gd", deleteGlobDataBy,
    "-gc", changeGlobStatus,
    "-gsh", showGlobDataBy,
    "-gbd", change_begin_date,
    "-gfd", change_finish_date,
    "-gh", change_header,
    "-gds", change_description,
};

struct daycmdFuncsWithTwoArgs
{
    const char *flag;
    struct tasksOnDay *(*flagFunc)(struct tasksOnDay*, char *);
} flagsArrayDay[] = {
    /*-l*/"-sh", showDayDataBy,
    /*-l*/"-d", deleteDayDataBy,
    /*-l*/"-a", addDayData,
    /*-l*/"-c", changeDayStatus,
    "-la", addDayData,
    "-ld", deleteDayDataBy,
    "-lc", changeDayStatus,
    "-lsh", showDayDataBy,
}; /* -g or -l means that exist first default argument */


/* parcer function */
char *inArgsPtr[MAXLINES];

//FILE* parserCmlineArgc(int, const char *[]);
int insideProgArgParser(char *[]); // returns how many args was written
void descriptionOfTaskParser(char *); // description parcer
int mygetLine(char [], int);

/* writing and reading struct from file */
void writeGlobStructToFile(struct globalDataNode *, FILE *);
struct globalDataNode *readGlobStructFromFile(struct globalDataNode *, FILE *);

void writeDayStructToFile(struct tasksOnDay *, FILE *);
struct tasksOnDay *readDayStructFromFile(FILE *);

/* functions for freeing memory */
//void freeStruct(void *);
//void freeDescription(char *);

struct globalDataNode *globmainArgParser(struct globalDataNode *, FILE *, int, const char *[], int *);
struct tasksOnDay *daymainArgParser(struct tasksOnDay *, FILE *, int,  const char *[], int *);

void showDocumentation(void); /* read file where all our documentation stored and display it on the screen */
void printingHeadandDescrp();

/* printing functiouns */
void printfirstFivecolumn(struct globalDataNode *, unsigned int);
void printtopOfTable(int, int); /* print top piece of table */
void printbottomOfTable(void); /* print bottom part of table */

/* print headerOfNode and description if in columns enough space */
void display_header_descrp(struct globalDataNode *globP, unsigned int h_len, unsigned int d_len); 

/* print headerOfNode and description if in both columns not enough space to store data in one line */
void display_owersize_header_descrp(struct globalDataNode *globP, unsigned int h_len, unsigned int d_len);
int display_owersize_header(struct globalDataNode *globP, unsigned int h_len, int *h_i);
int display_owersize_descrp(struct globalDataNode *globP, unsigned int d_len, int *d_i);

/* 
recursive func that print max amount of words which can be stored in one single line in column 
*/
void printHeader(struct globalDataNode *globP, unsigned int header_len, 
    unsigned int *nSymbols, int *i, int *k); 
void printDescription(struct globalDataNode *globP, unsigned int description_len,
    unsigned int *nSymbols, int *i, int *k); // ptiny description recursively


void printWholeHeader(struct globalDataNode *globP, unsigned int headerLen, 
    unsigned int descrpLen); /* function that print whole header from start to finish */
void printWholeDescription(struct globalDataNode *globP, 
    unsigned int descriptionLen); // function that prints whole description if size more then size of column 


struct globalDataNode *makeTreeBalanced(struct globalDataNode *globP); /* function that make tree balanced always, 
        rebuild tree choicing average element by date as a root */
void delete_whole_tree(struct globalDataNode *rootP); // distruct whole tree

#endif

                                            /* _______________________ЗАДАЧИ______________________________________*/


/*  - нужна функция которая бы сравнивала одну дату с другой и выясняла какая дата старше а какая младше,
        наверное путем возвращения разници в днях между ними.

    - создать функцию которая бы считала разницу в днях между датой постановки задачи и ориентировочной датой окончания задачи.
    
    - проблема, как искать по чем-то другом кроме даты, и как удалять допустим по названию ???
        (можно создать копию структуры, в которую в начале выполнения программы запишуться все данные, но отсортируются не по дате, а по названию, и тогда
        ........ оставим пока эту проблему и будем сортировать все по дате!)

    - касательно аллокации памяти для структур, нам нужно аллоцировать полностью все, потом это все переписать в файл и только тогда почистить память!

    - не забыть почистить потом память !

    - написал функциию которая считает количество дней между двумя датами, ну жно ее потом проверить, не факт что она корректно работает!

    - самую первую глобальню задачу нужно добавлять среднюю по срокам, например на пол года, тогда дерево будет сбалансированным,
        а если мы сначала добавим задачу продолжительность 2 дня, а потом будем все добавлять сроком больше чем два дня, то получится не сбалансированное дерево, 
        так-же если добавить задачу напимер на пять лет, а потом добавлять мелкие задачи!

1    - нужна функция которая записует все узлы дерева в файл таким образом как они находятся в дереве!


2    - реализовать все тоже управление которое есть через командную строку, только внутри программы,
        нужен цикл который будет все время держать программу 

3!    - решить проблему если дерево не сбалансированное, 
        как-то перезаписывать дерево выбирая среднюю дату между самой старой и самой новой!
        может перед тем как строить древо, заносить элементы в массив в порядке возрастания дат,
        выбирать средний элемент  как root и от него уже строить дерево.

4    - реализовать логику для записи данных(планов на день), так как эта часть вообще не готова!

5    - проблему в том что нужно колонку в таблице там где описание заполнить таким образом что-бы
        все описание поместилось и не здвинулись грани таблици, тое-сть нужно ее в каких-то местах 
        переводить на новыю строку, и по концу формировать горизонтальную черту таблици 



6    - пока самая важная задача это как отображать данные так что-бы они поместились в таблицу


7    - разделить парсинг аргуметов командной строки на две главных функции, одна для структуры 
        globalDataNode а вторая для dayTasksNode


8    - вынести в отделбную функцию отрисовку данных header and description, потому как они практическик 
        идентичны в двух местах, нужно слепить с них одну 

9    - решение проблемы с отображением, когда мы встречаем первый пробел или запятую или точку.. после 20 написанных символов
        мы делаем еще один цикл что-бы проверить будет ли еще хоть один пробел или запята я или точка.. до конца размера колонки
        если будет, то мы вписываем это слово до пробела, а все остальные переносим на новую строку
        если нет, переносим все начиная от первого пробела после 20 символов.

10   - добавить возможность модифицировать полностью все данны в таблице, сначала модифицировать 
        оглавление и описание задачи, а потом к датам, так-как с сроками сложнее, 
        нужно поменять дату и перестроить бинарное дерево 

11   - исправить ошибку с вводом, так-как сейчас в заголовок можно вводить не больше
        100 символов по моему, нужно зделать так что-бы можно было вводить сколько угодно!

12   - rewrite all function names, etc using underscore


13   - fix в функции которая выводит на экран заголовок и описание иногда бывает
        что в конце строки не выводиться точка, запятая или дефиз!


14   - make function that only print all "in progress" data or only "done" data and "denied" data.
*/
