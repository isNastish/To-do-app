#include "application.h"

int main(int argc, const char *argv[])
{
    system("clear");
    int firstArgLen, main_flag = 0; char *p;

    // first element is always name of executable file
    if ((p = (char *)malloc(firstArgLen = strlen(*argv) + 1)) != NULL) {strcpy(p, *argv); *(p + firstArgLen) = '\0'; inArgsPtr[0] = p;} 
    assert(p != NULL);

    struct global_data_node *globRootP = NULL; // poiner to array of such structs

    // check argumnets from command line, and call proper func
    if (argc > 1)
    {
        if (*(*(argv + 1) + 1) == 'g') {globRootP = glob_main_arg_parser(globRootP, argc, argv, &main_flag);} // global data
        else if(mystrcmp(*(argv + 1), "--help") == 0) {show_all_documentation();}
        else 
        {
            printf(C_RED_SLIM "error: not correct argument <%s>\n" RESET_TO_DEF, *(argv + 1));
            printf("see documentation '--help'\n");
            main_flag = 1;
        }
    }
    else main_flag = 1;
    while(main_flag) // main loop
    {
        printf(C_YELLOW "~:" RESET_TO_DEF); // user input. 
        int countArgs = inside_prog_arg_parser(inArgsPtr);
        if(countArgs > 1)
        {
            if(*(*(inArgsPtr + 1) + 0) == '-' && (*(*(inArgsPtr + 1) + 1) == 'g' || *(*(inArgsPtr + 1) + 1) == 's')) {globRootP = glob_main_arg_parser(globRootP, countArgs, inArgsPtr, &main_flag);}
            else if(mystrcmp(*(inArgsPtr + 1), "--help") == 0) {show_all_documentation();}
            else if(strcmp(*(inArgsPtr + 1), "-e") == 0) break;
            else // undefined "command line" flag
            {
                printf(C_RED_SLIM "error: unknown command line flag <%s>\n" RESET_TO_DEF, *(inArgsPtr + 1));
                printf("see allowed arguments '--help'\n");
                continue;
            }
        }
        else // if press CTRL + D on linux, countArgs will be 1
        {
            printf(C_RED_SLIM "\nerror: no arguments were detected.\n" RESET_TO_DEF);
            printf("see allowed arguments '--help'\n");
            break;
        }
    }
    write_glob_struct_to_file(globRootP, globF);
    fclose(globF);
    free_whole_tree(globRootP);
    return 0;
}

/* allocation for structure of type struct global_data_node */
struct global_data_node *talloc_global_task(void)
{
    struct global_data_node *globptr;
    globptr = (struct global_data_node *) malloc(sizeof(struct global_data_node));
    assert(globptr != NULL);
    return globptr;
}

/* allocate date */
struct universal_date *talloc_date(struct universal_date *ptrD)
{
    struct universal_date *p;
    p = (struct universal_date *) malloc(sizeof(struct universal_date));
    assert(p != NULL);
    p->day = ptrD->day, p->month = ptrD->month, p->year = ptrD->year;
    return p;
}

/* allocation any kind of description */
char *allocate_description(char *dscrp)
{
    char *descriptionP;
    descriptionP = (char *) malloc(mystrlen(dscrp) + 1); // 1 for symbol '\0' 
    assert(descriptionP != NULL);
    strcpy(descriptionP, dscrp);
    return descriptionP;
}

/* important function in our prog, it reads all arguments and text from input */
int mygetLine(char *args, int lim)
{
    char symbol;
    int len;
    for(len = 0; len < lim && (symbol = getchar()) != EOF && symbol != '\n'; len++) {*(args + len) = symbol;}
    if(symbol == '\n') {*(args + len++) = symbol;}
    *(args + len) = '\0';
    return len;
}

/* DON'T FORGET TO FREE THE MEMORY ALLOCATED HERE */
int inside_prog_arg_parser(const char *inArgsPtr[])
{
    int i, lenLine, ptrCount = 1, argLen = 0;
    char *p, argsline[HEADER_DESCRP_LEN + 50], arg[HEADER_DESCRP_LEN];
    lenLine = mygetLine(argsline, HEADER_DESCRP_LEN + 50);
    
    for(i = 0; i < lenLine; i++)
    {
        if(!isspace(*(argsline + i))) {arg[argLen] = *(argsline + i); ++argLen; continue;}
        else
        {
            if((p = (char *)malloc(argLen + 1)) == NULL) {assert(p != NULL); /* some work with errors */;} // plus 1 for '\0', don't forget to free memory
            else {arg[argLen] = '\0';strcpy(p, arg); inArgsPtr[ptrCount++] = p; argLen = 0;}

            /* in case if we skip all flags and reach sentences that will be stored in tree */
            if(*(argsline + i + 1) != '-' && *(argsline + i) != '\n')
            {
                for(i += 1, argLen = 0; i < lenLine; i++, argLen++) {arg[argLen] = *(argsline + i);}
                if((p = (char *)malloc(argLen)) == NULL) {assert(p != NULL); /* work with error */;}
                else {arg[argLen - 1] = '\0'; strcpy(p, arg); inArgsPtr[ptrCount++] = p;break;}
            }
            else {continue;}
        }
    }
    return ptrCount;
} 

/* function compares two dates */
int compare_dates(struct universal_date *oldP, struct universal_date *newP)
{
    if(oldP->year > newP->year || oldP->year < newP->year) {return oldP->year - newP->year;}
    else
    {
        if(oldP->month > newP->month || oldP->month < newP->month) {return oldP->month - newP->month;}
        else
        {
            if(oldP->day > newP->day || oldP->day < newP->day) {return oldP->day - newP->day;}
            else return 0; /* it means that task was given at the same day */
        }
    }
}

/* calculate amount of days beetwen date of the start and date of the planning finish */
int amount_of_days_per_task(struct universal_date *startP, struct universal_date *endP)
{
    int leap_year_start, leap_year_finish;
    int start = day_of_year(startP->year, startP->month, startP->day);
    int finish = day_of_year(endP->year, endP->month, endP->day);

    if(startP->year == endP->year)
        return finish - start;
    else
    {   /* if 1 - leap, 0 - not leap */
        leap_year_start = startP->year % 4 == 0 && startP->year % 100 != 0 || startP->year % 400 == 0; // check if begin year is leap or not 
        leap_year_finish = endP->year % 4 == 0 && endP->year % 100 != 0 || endP->year % 400 == 0; // if finish year leap pr not

        if(endP->year == startP->year + 1) // if finish year is the next year after start year
        {
            if(leap_year_start) {return 366 - start + finish;} /* if leap year */
            else {return 365 - start + finish;}
        }
        else // if not the same year
        {
            int i, local_year_leap, count_days;
            count_days = 0;
            for(i = endP->year - 1; i > startP->year; i--)
            {
                local_year_leap = (i) % 4 == 0 && (i) % 100 != 0 || (i) % 400 == 0;
                count_days += (local_year_leap) ? 366 : 365; // calculate amount of days beetwen begin year and finish year

            }
            if(leap_year_start) {return 366 - start + count_days + finish;}
            else {return 365 - start + count_days + finish;}
        }
    }
}


int day_of_year(int year, int month, int day)
{
    int i, leap;
    leap = year % 4 == 0 && year % 100 != 0 || year % 400 == 0; // compute leap year or not, 1 - leap, 0 - not leap
    for(i = 1; i < month; i++) {day += days_in_month[leap][i];}
    return day;
}

struct global_data_node *create_global_tree(struct global_data_node *ptrG, struct universal_date *beginDateptr, struct universal_date *finishDateptr, \
    char *descrp, char *header, char *status) // status (in progress)as a default
{
    // printf("%p\n", ptrG);
    // printf("%s\n", descrp);
    // printf("%s\n", header);
    // printf("%s\n", status);
    // printf("start date : %d %d %d\n", beginDateptr->day, beginDateptr->month, beginDateptr->year);
    // printf("finish : %d %d %d\n", finishDateptr->day, finishDateptr->month, finishDateptr->year);

    int resultOfcompare;

    if(NULL == ptrG)
    {
        ptrG = talloc_global_task();
        ptrG->headerOfNode = allocate_description(header);
        ptrG->description = allocate_description(descrp);
        ptrG->beginDate = talloc_date(beginDateptr);
        ptrG->finishDate = talloc_date(finishDateptr);
        ptrG->amountDays = amount_of_days_per_task(ptrG->beginDate, ptrG->finishDate);
        ptrG->statusOfTask = allocate_description(status);
        ptrG->leftnode = ptrG->rightnode = NULL;
    }
    else if((resultOfcompare = compare_dates(ptrG->beginDate, beginDateptr)) == 0)
    {
        /* тут нужно сдвинуть ветку бинарного дерева и поместить такой-же узел сразу за таким -же самым узлом.
        причем нужно что-бы придыдущий узел указывал на только что вставленный и желательно если у предыдущего узла есть правая ветвь, указатель на 
        нее нужно переприсвоить новоприбывшему узлу, и соответсвенно указатель на всю левую часть на которую указывал старый такой-же узел нужно присвоить в новый узел.
        */

       // left node must be smaller and right node must be equal or bigger, i have a bug here
        if(NULL != ptrG->leftnode)
        {
           struct global_data_node *tempRight = (NULL != ptrG->rightnode) ? (ptrG->rightnode) : NULL;
           struct global_data_node *tempLeft = ptrG->leftnode; // присваиваем времменно ссылку на левый узел который мы хотим подвинуть 
           ptrG->leftnode = create_global_tree(NULL, beginDateptr, finishDateptr, descrp, header, status);
           ptrG->leftnode->leftnode = tempLeft; 
           ptrG->leftnode->rightnode = tempRight;

        }
        else // if that node doesn't have leftnode
            ptrG->leftnode = create_global_tree(ptrG->leftnode, beginDateptr, finishDateptr, descrp, header, status);
       
    }
    else if(resultOfcompare > 0) 
        ptrG->leftnode = create_global_tree(ptrG->leftnode, beginDateptr, finishDateptr, descrp, header, status);
    else 
        ptrG->rightnode = create_global_tree(ptrG->rightnode, beginDateptr, finishDateptr, descrp, header, status);
    return ptrG; /* return pointer on root */
    
}

/* There is a big problem here, when we inside programm we can write pointers and then read them and display the value that they store, because 
this pointers consists of references on allocated block of memory with our word, but we can't read written in such way file
outside the programm, because references will not be exist, so we must write to file real values not pointers on
allocated memory with our words, and then we can easily read them, anyway we receive 'Segmentation fault' error.
So we must write all pieces of struct separately but before each one, write their lenght to file to, in order to read now 
length of word and allocated proper block of memory before reading word  */
struct global_data_node *read_glob_struct_from_file(struct global_data_node *globP, FILE * fileP)
{
    int stop_read_flag;
    while(1)
    {
        struct global_data_node tempP;
        size_t len_header;
        size_t len_description;
        size_t len_status;

        stop_read_flag = fread(&len_header, sizeof(len_header), 1, fileP); if(!stop_read_flag) break;
        tempP.headerOfNode = (char *)malloc(len_header);
        fread(tempP.headerOfNode, 1, len_header, fileP);
        fread(&len_description, sizeof(len_description), 1, fileP);
        tempP.description = (char *)malloc(len_description);
        fread(tempP.description, 1, len_description, fileP);
        fread(&len_status, sizeof(len_status), 1, fileP);
        tempP.statusOfTask = (char *)malloc(len_status);
        fread(tempP.statusOfTask, 1, len_status, fileP);
        fread(&tempP.amountDays, sizeof(int), 1, fileP);
        tempP.beginDate = (struct universal_date *)malloc(sizeof(struct universal_date));
        fread(&tempP.beginDate->day, sizeof(unsigned short), 1, fileP); 
        fread(&tempP.beginDate->month, sizeof(unsigned short), 1, fileP);
        fread(&tempP.beginDate->year, sizeof(unsigned short), 1, fileP);
        tempP.finishDate = (struct universal_date *)malloc(sizeof(struct universal_date));
        fread(&tempP.finishDate->day, sizeof(unsigned short), 1, fileP);
        fread(&tempP.finishDate->month, sizeof(unsigned short), 1, fileP);
        fread(&tempP.finishDate->year, sizeof(unsigned short), 1, fileP); 
        tempP.leftnode = tempP.rightnode = NULL;

        globP = create_global_tree(globP, tempP.beginDate, tempP.finishDate, tempP.description, tempP.headerOfNode, tempP.statusOfTask);
        free(tempP.finishDate);
        free(tempP.beginDate);
        free(tempP.description);
        free(tempP.statusOfTask);
        free(tempP.headerOfNode);
    }
    return globP;
} 

void write_glob_struct_to_file(struct global_data_node *globP, FILE * fileP)
{
    if(globP != NULL)
    {
        size_t len_header      = strlen(globP->headerOfNode) + 1;
        size_t len_description = strlen(globP->description)  + 1;
        size_t len_status      = strlen(globP->statusOfTask) + 1;
 
        fwrite(&len_header, sizeof(len_header), 1, fileP);
        fwrite(globP->headerOfNode, 1, len_header, fileP); // write each symbol, each byte.
        fwrite(&len_description, sizeof(len_description), 1, fileP);
        fwrite(globP->description, 1, len_description, fileP);
        fwrite(&len_status, sizeof(len_status), 1, fileP);
        fwrite(globP->statusOfTask, 1, len_status, fileP);
        fwrite(&globP->amountDays, sizeof(int), 1, fileP);
        fwrite(&globP->beginDate->day, sizeof(unsigned short), 1, fileP);
        fwrite(&globP->beginDate->month, sizeof(unsigned short), 1, fileP);
        fwrite(&globP->beginDate->year, sizeof(unsigned short), 1, fileP);
        fwrite(&globP->finishDate->day, sizeof(unsigned short), 1, fileP);
        fwrite(&globP->finishDate->month, sizeof(unsigned short), 1, fileP);
        fwrite(&globP->finishDate->year, sizeof(unsigned short), 1, fileP);

        write_glob_struct_to_file(globP->leftnode, fileP);
        write_glob_struct_to_file(globP->rightnode, fileP);
    }
}

static unsigned long long task_number;
void printing_main_func(struct global_data_node *globP)
{
    print_first_five_columns(globP, task_number);
    unsigned int headerLen = strlen(globP->headerOfNode), descrpLen = strlen(globP->description);
    if(headerLen > 35 && descrpLen < 78) // if header length bigger then column size 
    {
        print_whole_header(globP,headerLen, descrpLen);
    }
    else if(headerLen < 36 && descrpLen > 77) // if descrp length bigger then column size
    {
        int i;
        for(i = 0; i < (int)headerLen; i++) {printf("%c", globP->headerOfNode[i]);}
        for(; i < 35; i++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
        print_whole_description(globP, descrpLen);
    } 
    else if(headerLen > 35 && descrpLen > 77) // if both data bigger then their column sizes
    {
        display_owersize_header_descrp(globP, headerLen, descrpLen);
    }
    else {display_header_descrp(globP, headerLen, descrpLen);} // if enough place fror both
}

struct global_data_node *glob_tree_print(struct global_data_node *glob_rootP, unsigned short identifier)
{
    if(glob_rootP != NULL)
    {
        switch(identifier)
        {
            case 0: // display whole tree
                glob_tree_print(glob_rootP->leftnode, identifier);
                printing_main_func(glob_rootP);
                printf(C_MAGENTA "  |");
                for(int i = 0; i < 170; i++) {printf("-");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
                ++task_number;
                glob_tree_print(glob_rootP->rightnode, identifier);
                break;
            case 1: // display all data with statusOfTask "in progress"   '-s1'
                glob_tree_print(glob_rootP->leftnode, identifier);
                if(mystrcmp(glob_rootP->statusOfTask, "in progress") == 0)
                {
                    printing_main_func(glob_rootP);
                    printf(C_MAGENTA "  |");
                    for(int i = 0; i < 170; i++) {printf("-");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
                    ++task_number;
                }
                glob_tree_print(glob_rootP->rightnode, identifier);
                break;
            case 2: // display all data with statusOfTask "denied"      '-s2'
                glob_tree_print(glob_rootP->leftnode, identifier);
                if(mystrcmp(glob_rootP->statusOfTask, "denied") == 0)
                {
                    printing_main_func(glob_rootP);
                    printf(C_MAGENTA "  |");
                    for(int i = 0; i < 170; i++) {printf("-");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
                    ++task_number;
                }
                glob_tree_print(glob_rootP->rightnode, identifier);
                break;
            case 3: // display all data with statusOfTask "done"        '-s3'
                glob_tree_print(glob_rootP->leftnode, identifier);
                if(mystrcmp(glob_rootP->statusOfTask, "done") == 0)
                {
                    printing_main_func(glob_rootP);
                    printf(C_MAGENTA "  |");
                    for(int i = 0; i < 170; i++) {printf("-");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
                    ++task_number;
                }
                glob_tree_print(glob_rootP->rightnode, identifier);
        }
    }
}

/* functions that works with flags from command line, print already allocated data! */
void display_all_globdata(struct global_data_node *globP, unsigned short identifier)
{
    int flag = 0;
    system("clear");
    printf(C_CYAN "\t\t\t\t\t\t\t\t\t\tGLOBAL TASKS\n"); printf(C_MAGENTA "   __");
	for(int i = 0; i < 56; i++) {printf(C_MAGENTA " __");}; printf("\n");
	for(int i = 0; i <= 2; i++)
	{
        if(i < 2) {print_top_of_table(flag, i);}
        else if(i == 2) {task_number = 1; glob_tree_print(globP, identifier); task_number = 1;}
	}
    print_bottom_of_table();
}

struct global_data_node *add_glob_data(struct global_data_node *globPtr, char *header)
{
    struct universal_date sdateP;
    struct universal_date fdateP;
    int addHeaderflag = 0;
    char addmoreData = 'y', garbich; /* means yes as a default */
    while(addmoreData != 'n')
    {
        int sdateLen, fdateLen, descrpLen, headerLen;
        char startDate[DATE_LEN], finishDate[DATE_LEN], header_[HEADER_DESCRP_LEN], description[HEADER_DESCRP_LEN];
        printf(C_GREEN "start date: " RESET_TO_DEF);
        sdateLen = mygetLine(startDate, DATE_LEN);
        *(startDate + sdateLen - 1) = '\0'; // replace '\n' with '\0'

        printf(C_GREEN "finish date: " RESET_TO_DEF);
        fdateLen = mygetLine(finishDate, DATE_LEN);
        *(finishDate + fdateLen - 1) = '\0';

        printf(C_GREEN "description: " RESET_TO_DEF);
        descrpLen = mygetLine(description, HEADER_DESCRP_LEN);
        *(description + descrpLen - 1) = '\0';
        if(addHeaderflag > 0)
        {
            printf(C_GREEN "header: " RESET_TO_DEF);
            headerLen = mygetLine(header_, HEADER_DESCRP_LEN);
            *(header_ + headerLen - 1) = '\0';
        }

        date_parser(&sdateP, startDate, sdateLen);
        date_parser(&fdateP, finishDate, fdateLen);

        globPtr = create_global_tree(globPtr, &sdateP, &fdateP, description, (addHeaderflag  == 0) ? header : header_, DEF_STATUS);
        printf(C_RED_SLIM "Add more data?" RESET_TO_DEF); // there after input we have two symbols 'y' and '\n'
        scanf("%c", &addmoreData);
        scanf("%c", &garbich); // we need it, because our next getchar() in mygetline() func will read '\n' symbol and jump return
        ++addHeaderflag;
    }
    system("clear");
    return globPtr;
}

void date_parser(struct universal_date *dateP, char *str_date, int date_len) 
{
    int count_dots = 0, index = 0;
    char tempDate[5]; //, *p = str_date;
    //date_len = strlen(p);
    //*(str_date + date_len) = '\0';

    for(int i = 0; i < date_len; i++) 
    {
        if(*(str_date + i) != '.') {tempDate[index] = *(str_date + i); ++index;}
        else
        {
            ++count_dots;
            if(count_dots == 1) {tempDate[index] = '\0'; dateP->day = myatoi(tempDate); index = 0; continue;}
            if(count_dots == 2) 
            {
                tempDate[index] = '\0';
                dateP->month = myatoi(tempDate), index = 0;
                for(i += 1; i < date_len; i++) {tempDate[index] = *(str_date + i); ++index;}
                tempDate[index] = '\0';
                dateP->year = myatoi(tempDate);
                return;
            }
        }
    }
}

/* convert day, month, year into numbers */
unsigned short myatoi(char date[]) 
{
    int i; unsigned short n;
    if(date[0] == '0') {i = 1;}
    else {i = 0;}
    for(i; isspace(date[i]); i++); 
    for(n = 0; isdigit(date[i]); i++) {n = 10 * n + (date[i] - '0');}
    return n;
}

// common finding proper date function for all changes, sign - number(decide what to change, description, header etc.)
void error_date_print(struct universal_date dateP)
{
    printf(C_RED "error: date " RESET_TO_DEF);
    (dateP.day > 9) ? printf("  %d.", dateP.day) : printf("  0%d.", dateP.day);
    (dateP.month > 9) ? printf("%d.", dateP.month) : printf("0%d.", dateP.month);
    printf("%d  wasn't found!\n", dateP.year);
}

struct global_data_node *show_glob_data_by(struct global_data_node *globP, char *date_to_show)
{
    struct universal_date temp_date;
    struct global_data_node *tempP;
    date_parser(&temp_date, date_to_show, date_manipulation(date_to_show));
    tempP = find_date_and_print_content(globP, &temp_date);
    if(NULL == tempP) {error_date_print(temp_date); return globP;}
    return globP;
}

struct global_data_node *find_date(struct global_data_node *globrootP, struct universal_date *dateP, unsigned short sign)
{
    int resultdate;
    if(NULL == globrootP) {return NULL;}
    else if((resultdate = compare_dates(globrootP->beginDate, dateP)) > 0) {find_date(globrootP->leftnode, dateP, sign);}
    else if(resultdate < 0) {find_date(globrootP->rightnode, dateP, sign);}
    else // matching 
    {
        switch(sign)
        {
            case 1: // change statusOfTask
            input_status(globrootP);
            return globrootP; 
            case 2: // change headerOfNode
            input_header(globrootP);
            return globrootP;
            case 3: // change description
            input_description(globrootP);
            return globrootP;

            /*
            case 4: // change beginDate
            input_date_begin(globrootP); 
            return globrootP;
            case 5: // change finishDate
            input_date_finish(globrootP);
            return globrootP;
            */
        }
    }
}

int date_manipulation(char *searching_date)
{
    char *p = searching_date;
    int date_len = strlen(p);
    *(searching_date + date_len) = '\0';
    return date_len;
}

/* set of functions to change global data statusOfTask
################################################################################################################*/ 
struct global_data_node *change_glob_status(struct global_data_node *globP, char *searching_date) // receive begin date
{
    struct universal_date key_date;
    struct global_data_node *ref_to_node;
    date_parser(&key_date, searching_date, date_manipulation(searching_date));
    ref_to_node = find_date(globP, &key_date, 1);
    if(NULL == ref_to_node) {error_date_print(key_date); return globP;}
    show_glob_data_by(globP, searching_date);
    return globP;
}

void input_status(struct global_data_node *globP)
{
    /*There is no need in realloc() for status because from the beginning we allocate memory
    for size of word "in progress", it's the biggest possible size, so we can't write in statusOfTask
    word length of which bigger then length "in progress"*/
    char status[12];
    printf(C_GREEN "status: " RESET_TO_DEF);
    int status_len = mygetLine(status, DATE_LEN) - 1; // DATE_LEN  = strlen("in progress"), so we can use it here too
    *(status + status_len) = '\0';
    strcpy(globP->statusOfTask, status); 
}

/*set of functions to change global data headerOfNode
################################################################################################################*/
struct global_data_node *change_glob_header(struct global_data_node *globP, char *searching_date)
{
    struct universal_date key_date;
    struct global_data_node *ref_to_node;
    date_parser(&key_date, searching_date, date_manipulation(searching_date));
    ref_to_node = find_date(globP, &key_date, 2);
    if(NULL == ref_to_node) {error_date_print(key_date); return globP;}
    show_glob_data_by(globP, searching_date);
    return globP;
}

void input_header(struct global_data_node *globP) 
{
    char header[HEADER_DESCRP_LEN];
    printf(C_GREEN "header : " RESET_TO_DEF);
    int header_len = mygetLine(header, HEADER_DESCRP_LEN) - 1;
    *(header + header_len) = '\0'; // '\n' - we replace this symbol with '\0'
    globP->headerOfNode = (char *)realloc(globP->headerOfNode, header_len); // not header_le + 1 because header_len includes space for '\0'
    strcpy(globP->headerOfNode, header); // проблема в том что память была выделана для предложения одной длинны, а мы пытаемся засунуть туда предложение совсем другой длинны
}

/*set of functions to change global data description
################################################################################################################*/
struct global_data_node *change_glob_description(struct global_data_node *globP, char *searching_date)
{
    struct universal_date key_date;
    struct global_data_node *ref_to_node;
    date_parser(&key_date, searching_date, date_manipulation(searching_date));
    ref_to_node = find_date(globP, &key_date, 3);
    if(NULL == ref_to_node) {error_date_print(key_date); return globP;}
    show_glob_data_by(globP, searching_date);
    return globP;  
}

void input_description(struct global_data_node *globP)
{
    char description[HEADER_DESCRP_LEN];
    printf(C_GREEN "dascription : " RESET_TO_DEF);
    int description_len = mygetLine(description, HEADER_DESCRP_LEN) - 1;
    *(description + description_len) = '\0';
    globP->description = (char *)realloc(globP->description, description_len);
    strcpy(globP->description, description); 
}

/*set of functions to change global data description
###############################################################################################################*/
struct global_data_node *change_begin_date(struct global_data_node *globP, char *searching_date)
{
    ;
}

void input_date_begin(struct global_data_node *globP)
{
    char begin_date[DATE_LEN];
    printf(C_GREEN "start date : " RESET_TO_DEF);
    int date_len = mygetLine(begin_date, DATE_LEN);
    *(begin_date + date_len - 1) = '\0';

    struct universal_date temp;
    date_parser(&temp, begin_date, date_len);
    globP->beginDate->day = temp.day;
    globP->beginDate->month = temp.month;
    globP->beginDate->year = temp.year;

}

/*set of functions to change global data description
################################################################################################################*/
struct global_data_node *change_finish_date(struct global_data_node *globP, char *searching_date)
{
    ;
}

void input_date_finish(struct global_data_node *globP)
{
    char finish_date[DATE_LEN];
    printf(C_GREEN "finish date : " RESET_TO_DEF);
    int date_len = mygetLine(finish_date, DATE_LEN);
    *(finish_date + date_len - 1) = '\0';

    struct universal_date temp;
    date_parser(&temp, finish_date, date_len); 
    globP->beginDate->day = temp.day;
    globP->beginDate->month = temp.month;
    globP->beginDate->year = temp.year;
}
/*#############################################################################################################*/

struct global_data_node *find_date_and_print_content(struct global_data_node *globrootP, struct universal_date *dateP)
{
    int resultdate;
    if(NULL == globrootP) {return NULL;}
    else if((resultdate = compare_dates(globrootP->beginDate, dateP)) > 0) {find_date_and_print_content(globrootP->leftnode, dateP);}
    else if(resultdate < 0) {find_date_and_print_content(globrootP->rightnode, dateP);}
    else // such date was found 
    {
        int flag = 0;
        system("clear");
        printf(C_MAGENTA "   __");
        for(int i = 0; i < 56; i++) {printf(" __");} printf("\n");
        for(int i = 0; i <= 2; i++)
        {
            if( i < 2) {print_top_of_table(flag, i);}
            else if(i == 2) {printing_main_func(globrootP);}
        }print_bottom_of_table();
        return globrootP;
    }
}

/* recursive function to properly print header if not enough space in column 
this func helps me to know how much words can be stored in one line */
void print_whole_header(struct global_data_node *globP, unsigned int h_len, unsigned int d_len) 
{
    unsigned int nSymbolsinLine, emptyColumn, printdescrp;
    nSymbolsinLine = emptyColumn = printdescrp = 0;

    for(int i = 0; i < h_len; ++i)
    {
        if(i == h_len - 1 && nSymbolsinLine < 36) /* means that now we will print the last symbol, but if not enough place */
        {
           ++nSymbolsinLine;
           printf("%c", globP->headerOfNode[i]);
           for(int k = 0; k < (35 - nSymbolsinLine); k++) {printf(" ");}; printf(C_MAGENTA "|"); // 35 inclusively
           for(int g = 0; g < 77; g++) {printf(" ");}; printf("|\n" RESET_TO_DEF); // 77 inclusively
           break;
        }
        else if(nSymbolsinLine > 10 && (globP->headerOfNode[i] == ' ' || globP->headerOfNode[i] == ',' || globP->headerOfNode[i] == '.' || 
            globP->headerOfNode[i] == '!' || globP->headerOfNode[i] == '?' || globP->headerOfNode[i] == '-'))
        {
            int k = i;
            print_header(globP, h_len, &nSymbolsinLine, &i, &k); /* k = i in first call */
            if(!printdescrp) /* if description hasn't been printed, we print it, and increase descrpPrint flag on 1 */
            {
                int x; printdescrp = 1;
                for(int j = 0; j < (35 - nSymbolsinLine); j++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
                for(x = 0; x < d_len; x++) {printf("%c", globP->description[x]);}
                for(; x < 77; x++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
            }
            else /* if was printed, we print empty line */
            {
                for(int j = 0; j < (35 - nSymbolsinLine); j++) {printf(" ");}; printf(C_MAGENTA "|");
                for(int g = 0; g < 77; g++) {printf(" ");}; printf("|\n" RESET_TO_DEF);
            }
            emptyColumn = 1;
            nSymbolsinLine = 0;
            continue;
        }
        else if(emptyColumn) /* print all empty column before header column */
        {
            printf(C_MAGENTA "  |  ");
            for(int z = 0; z < 56; z++)
            {
                if(z == 1 || z == 6 || z == 11 || z == 13) {printf("|  ");}
                else if(z == 18) {printf("|" RESET_TO_DEF); break;} /* break when we reach the last "|" before header column */
                else             {printf("   ");}
            }emptyColumn = 0;
        }
        printf("%c", globP->headerOfNode[i]);
        ++nSymbolsinLine;
    }
}

void print_header(struct global_data_node *globP, unsigned int h_len, unsigned int *nSymbols, int *i, int *k)
{
    for(; *k < h_len && (*k - *i) < (35 - *nSymbols); ++(*k)) // don't work with end of string 
    {
        if(*k == h_len - 1)
        {
            for(; *i < *k + 1; ++(*i)) {printf("%c", globP->headerOfNode[*i]); ++(*nSymbols);}
            break;
        }
        else if(globP->headerOfNode[*k] == ' ' || globP->headerOfNode[*k] == ',' || globP->headerOfNode[*k] == '.'
            || globP->headerOfNode[*k] == '?' || globP->headerOfNode[*k] == '!' || globP->headerOfNode[*k] == '-')
        {
            for(; *i < *k; ++(*i)) 
            {
                printf("%c", globP->headerOfNode[*i]);
                ++(*nSymbols);
            }++(*k); // if spaces, comas, dots ...., we must increade *k because we will have endless circle 
            print_header(globP, h_len, nSymbols, i, k);
            break;
        }
    }
} // i think it's done!

void print_whole_description(struct global_data_node *globP, unsigned int d_len)
{
    unsigned int nSymbolsinLine, emptyColumn;
    nSymbolsinLine = emptyColumn = 0;

    for(int i = 0; i < d_len; ++i)
    {
        if(i == d_len - 1 && nSymbolsinLine < 78) /* means that now we will print the last symbol, but if not enough place */
        {
           ++nSymbolsinLine;
           printf("%c", globP->description[i]);
           for(int j = 0; j < (77 - nSymbolsinLine); j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF); // 77 inclusively
           break;
        }
        // decrease 50 on 45 in future,
        else if(nSymbolsinLine > 45 && (globP->description[i] == ' ' || globP->description[i] == ',' || globP->description[i] == '.' || 
            globP->description[i] == '!' || globP->description[i] == '?' || globP->description[i] == '-'))
        {
            int k = i;
            print_description(globP, d_len, &nSymbolsinLine, &i, &k);
            for(int j = 0; j < (77 - nSymbolsinLine); j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
            emptyColumn = 1;
            nSymbolsinLine = 0;
            continue;
        }
        else if(emptyColumn)
        {
            printf(C_MAGENTA "  |  ");
            for(int z = 0; z < 56; z++)
            {
                if(z == 1 || z == 6 || z == 11 || z == 13 || z  == 18) {printf("|  ");}
                else if(z == 30) {printf("|" RESET_TO_DEF); break;} /* break when we reach the last "|" before header column */
                else             {printf("   ");}
            }
            emptyColumn = 0;
        }
        printf("%c", globP->description[i]);
        ++nSymbolsinLine;
    }
}

void print_description(struct global_data_node *globP, unsigned int d_len, unsigned int *nSymbols, int *i, int *k)
{

    for(; *k < d_len && (*k - *i) < (77 - *nSymbols); ++(*k)) 
    {
        if(*k == d_len - 1)
        {
            for(; *i < *k + 1; ++(*i)) {printf("%c", globP->description[*i]); ++(*nSymbols);}
            break;
        }
        else if(globP->description[*k] == ' ' || globP->description[*k] == ',' || globP->description[*k] == '.'
            || globP->description[*k] == '?' || globP->description[*k] == '!' || globP->description[*k] == '-')
        {
            for(; *i < *k; ++(*i)) 
            {
                printf("%c", globP->description[*i]);
                ++(*nSymbols);
            }++(*k); // if spaces, comas, dots ...., we must increade *k because we will have endless circle 
            print_description(globP, d_len, nSymbols, i, k);
            break;
        }
    }
}


void display_owersize_header_descrp(struct global_data_node *globP, unsigned int h_len, unsigned int d_len)
{
    unsigned int temp_h_len = h_len, temp_d_len = d_len;
    int h_i, d_i, h_flag, d_flag;
    h_i = d_i = h_flag = d_flag = 0;

    /* we must find first data that was totaly ptinted, temp_len of this data will be 0,
    so the data that left will have more lines in table so we must be navigated on this data
    */
    while(1)
    {
        // returning value zero means that whole data was printed.
        if(temp_h_len) {temp_h_len = display_owersize_header(globP, h_len, &h_i); ++h_flag;} 
        if(temp_d_len) {temp_d_len = display_owersize_descrp(globP, d_len, &d_i); ++d_flag;} 

        /* we must check which data was totaly printed first, 
        if descsription - means that header data has more lines and we must print empty description column,
        else simply reture, we must create flag to see witch data will be printed earlier.
        */
        if(temp_h_len == 0 && temp_d_len == 0)
        {
            if(h_flag > d_flag) {for(int j = 0; j < 77; j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF); return;}
            else return;
        }
        // display empty columns 
        printf(C_MAGENTA "  |  ");
        for(int j = 0; j < 56; ++j)
        {
            if(j == 1 || j == 6 || j == 11 || j == 13) printf("|  ");
            else if(j == 18)    
            {
                if((temp_h_len != 0 && temp_d_len == 0) || (temp_h_len == temp_d_len)) {printf("|" RESET_TO_DEF); break;}
                else if(temp_h_len == 0 && temp_d_len != 0) {printf("|  "); continue;}
            }
            else if(j == 30) {printf("|" RESET_TO_DEF); break;}
            else printf("   ");
        }
    }
}


int display_owersize_header(struct global_data_node *globP, unsigned int h_len, int *h_i)
{
    unsigned int nSymbolsinLine = 0;

    for(; *h_i < h_len; ++(*h_i))
    {
        /* means that now we will print the last symbol, but if not enough place */
        if(*h_i == h_len - 1 && nSymbolsinLine < 36) 
        {
           ++nSymbolsinLine;
           printf("%c", globP->headerOfNode[*h_i]);
           for(int k = 0; k < (35 - nSymbolsinLine); k++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF); // 35 inclusively
           return 0;
        }
        else if(nSymbolsinLine > 10 && (globP->headerOfNode[*h_i] == ' ' || globP->headerOfNode[*h_i] == ',' || globP->headerOfNode[*h_i] == '.' || 
            globP->headerOfNode[*h_i] == '!' || globP->headerOfNode[*h_i] == '?' || globP->headerOfNode[*h_i] == '-'))
        {
            int k = *h_i;
            print_header(globP, h_len, &nSymbolsinLine, h_i, &k); /* k = i in first call */
            for(int j = 0; j < (35 - nSymbolsinLine); j++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
            nSymbolsinLine = 0;
            return (*h_i == h_len) ? 0 : 1;
        }
        if(0 == nSymbolsinLine && globP->headerOfNode[*h_i] == ' ' && *h_i != 0) continue;
        printf("%c", globP->headerOfNode[*h_i]);
        ++nSymbolsinLine;
    }
    return 0;
}

int display_owersize_descrp(struct global_data_node *globP, unsigned int d_len, int *d_i)
{
    unsigned int nSymbolsinLine = 0;

    for(; *d_i < d_len; ++(*d_i))
    {
        /* means that now we will print the last symbol, but if not enough place */
        if(*d_i == d_len - 1 && nSymbolsinLine < 78) 
        {
           ++nSymbolsinLine;
           printf("%c", globP->description[*d_i]);
           for(int j = 0; j < (77 - nSymbolsinLine); j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF); // 77 inclusively
           return 0;
        }
        else if(nSymbolsinLine > 45 && (globP->description[*d_i] == ' ' || globP->description[*d_i] == ',' || globP->description[*d_i] == '.' 
            || globP->description[*d_i] == '!' || globP->description[*d_i] == '?' || globP->description[*d_i] == '-'))
        {
            int k = *d_i;
            print_description(globP, d_len, &nSymbolsinLine, d_i, &k);
            for(int j = 0; j < (77 - nSymbolsinLine); j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
            nSymbolsinLine = 0;
            return (*d_i == d_len) ? 0 : 1;
        }
        if(0 == nSymbolsinLine && globP->description[*d_i] == ' ' && *d_i != 0) continue;
        printf("%c", globP->description[*d_i]);
        ++nSymbolsinLine;
    }
    return 0;
}


void print_first_five_columns(struct global_data_node *globP, unsigned int task_number)
{
    printf(C_MAGENTA "  |");
    printf(C_CYAN "%5d" RESET_TO_DEF, task_number);
    printf(C_MAGENTA "|" RESET_TO_DEF);

    (globP->beginDate->day > 9) ? printf("  %d.", globP->beginDate->day) : printf("  0%d.",globP->beginDate->day);
    (globP->beginDate->month > 9) ? printf("%d.", globP->beginDate->month) : printf("0%d.", globP->beginDate->month);
    printf("%d  ", globP->beginDate->year);
    printf(C_MAGENTA "|" RESET_TO_DEF);

    (globP->finishDate->day > 9) ? printf("  %d.", globP->finishDate->day) : printf("  0%d.", globP->finishDate->day);
    (globP->finishDate->month > 9) ? printf("%d.", globP->finishDate->month) : printf("0%d.", globP->finishDate->month);
    printf("%d  ", globP->finishDate->year);
    printf(C_MAGENTA "|" RESET_TO_DEF);

    printf("%5d", globP->amountDays);
    printf(C_MAGENTA "|" RESET_TO_DEF);

    if((mystrcmp(globP->statusOfTask, "in progress")) == 0) {printf(C_YELLOW " %s  ", globP->statusOfTask);}
    else if((mystrcmp(globP->statusOfTask, "done")) == 0) {printf(C_GREEN "     %s     ", globP->statusOfTask);}
    else if((mystrcmp(globP->statusOfTask, "denied")) == 0) {printf(C_RED_SLIM "    %s    ", globP->statusOfTask);}
    printf(C_MAGENTA "|" RESET_TO_DEF);
}


void print_top_of_table(int flag, int i)
{
    printf(C_MAGENTA "  |");
    if(i == 0) {printf(C_BLUE "  №  " RESET_TO_DEF); flag = 5;}
    for(int j = flag; j < 170; j++)
    {
        if(i == 1)       {printf(C_MAGENTA "-"); continue;}
        else if(j == 5)  {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE "  start date  ");j = 19;}}
        else if(j == 20) {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE "  finish date "); j = 34;}}
        else if(j == 35) {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE " day "); j = 40;}}
        else if(j == 41) {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE "    status   ");j = 54;}}
        else if(j == 56) {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE "\t\t task name\t       "); j = 91;}} // 35 inclusively
        else if(j == 92) {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE "                                description                                 "); j = 168;}} // 77 inclusively
        else             {printf(C_MAGENTA " ");}
    }
    printf(C_MAGENTA "|\n"); flag = 0;
}

void print_bottom_of_table(void)
{
    printf(C_MAGENTA "  |__");
    for(int i = 0; i < 56; i++) 
    {
        if(i == 1)       {printf("|__");}
        else if(i == 6)  {printf("|__");}
        else if(i == 11) {printf("|__");}
        else if(i == 13) {printf("|__");}
        else if(i == 18) {printf("|__");}
        else if(i == 30) {printf("|__");}
        else             {printf(C_MAGENTA " __");}
    }
    printf("|\n\n" RESET_TO_DEF);
}

void display_header_descrp(struct global_data_node *globP, unsigned int headerLen, unsigned int descrpLen)
{
    int i, j;
    for(i = 0; i < (int)headerLen; ++i) {printf("%c", globP->headerOfNode[i]);}
    for(; i < 35; i++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
    for(j = 0; j < (int)descrpLen; j++) {printf("%c", globP->description[j]);}
    for(; j < 77; j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF); 
}

/* function that delete one node from tree, it's complicated func because we need rebuild 
all tree to save tree properties */
struct global_data_node *pre_deleting_node_func(struct global_data_node *globPtr, char *str_date)
{
    struct universal_date date_to_del;
    date_parser(&date_to_del, str_date, date_manipulation(str_date));
    globPtr = delete_node_by_date(globPtr, &date_to_del);
}

struct global_data_node *delete_node_by_date(struct global_data_node *rootP, struct universal_date *dateP)
{
    if(NULL == rootP) return rootP;
    else
    {
        ;
    }
}

void show_all_documentation(void)
{
    ;
    /*
    Read file that contains all documentation and display all text on the screen
    all available flags, all combinations of them, and what this programm can do.
    All documentation is located in one .txt file called 'appDoc'.
    */
}

/* we must debug this func because now it's not very clean */
void free_whole_tree(struct global_data_node *rootP)
{
    if(NULL != rootP)
    { 
        free_whole_tree(rootP->leftnode);
        free(rootP->headerOfNode);
        free(rootP->statusOfTask);
        free(rootP->description);
        free(rootP->beginDate);
        free(rootP->finishDate);
        free(rootP);
        free_whole_tree(rootP->rightnode);
    }
}

struct global_data_node *glob_main_arg_parser(struct global_data_node *glob_rootP, int argc, const char *argv[], int *mainflag)
{
    /* Build tree and allocate memory for all data in file, and return pointer on root if data exist in file of course */
    if(!read_flag)
    {
        globF = fopen(GLOBAL_DATA_PATH, "r+"); // 'r+' - open for modification (read + write) 
        glob_rootP = read_glob_struct_from_file(glob_rootP, globF);
        fseek(globF, 0, SEEK_SET); 
        read_flag = 1;
    }
    if(argc == 2)
    {
        if((mystrcmp(argv[1], "-g") == 0)) {display_all_globdata(glob_rootP, 0); (*mainflag)++;} // display all data
        else if((mystrcmp(argv[1], "-s1") == 0)) {display_all_globdata(glob_rootP, 1); (*mainflag)++;} // display all data with "in progress status"
        else if((mystrcmp(argv[1], "-s2") == 0)) {display_all_globdata(glob_rootP, 2); (*mainflag)++;} // display all data with "denied" status
        else if((mystrcmp(argv[1], "-s3") == 0)) {display_all_globdata(glob_rootP, 3); (*mainflag)++;} // display all data with "done" status
        else
        {
            /* there may be something more complicated */
            printf(C_RED "%s\t%s\n", *(argv + 1), "error: incorrect comand line argument!" RESET_TO_DEF);
        }
    }
    else if(argc > 2)
    {
        if(argc == 3)
        {
            for(int i = 0; i < GLOB_FLAGSARRAY_LEN; i++)
            {
                if(strcmp(argv[1], flags_array_glob[i].flag) == 0)
                {
                    if(*(*(argv + 1) + 1) == 'g')
                    {
                        glob_rootP = flags_array_glob[i].flagFunc(glob_rootP, (char *)argv[2]);
                        (*mainflag)++;
                        break;
                    }
                    else;/* work with error!, not importatnt for now, maybe it will be a function */
                }
                else; /* work with error */
            }
        }
        else if(argc == 4) // change
        {
            for(int i = 0; i < GLOB_FLAGSARRAY_LEN; i++)
            {
                if(strcmp(argv[1], "-g") == 0) /* -g */
                {
                    if(strcmp(argv[2], flags_array_glob[i].flag) == 0) 
                    {
                        glob_rootP = flags_array_glob[i].flagFunc(glob_rootP, (char *)argv[3]);
                        (*mainflag)++;
                        break;
                    }
                    else; // work with errors
                }
                else; // work with errors
            }
        }
        else; // work with errors
    }
    return glob_rootP;
}