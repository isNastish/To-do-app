#include "application.h"

int main(int argc, const char *argv[])
{
    system("clear");
    int firstArgLen, main_flag = 0; char *p;

    // first element is always name of executable file
    if((p = (char *)malloc(firstArgLen = mystrlen(*argv) + 1)) != NULL) {strcpy(p, *argv); *(p + firstArgLen) = '\0'; inArgsPtr[0] = p;} 
    assert(p != NULL);

    FILE* dayFP = createFile(dayFP, "dayData.bin");
    FILE* globFP = createFile(globFP, "globData.bin");

    struct tasksOnDay *dayRootP = NULL; // maybe it unnecessary */
    struct globalDataNode *globRootP = NULL; // poiner to array of such structs

    // decide what type of data we will be operate on
    if(argc > 1)
    {
        if(*(*(argv + 1) + 1) == 'g') {globRootP = globmainArgParser(globRootP, globFP, argc, argv, &main_flag);} // global data
        else if(*(*(argv + 1) + 1) == 'l') {dayRootP = daymainArgParser(dayRootP, dayFP, argc, argv, &main_flag);} // local data
        else if(mystrcmp(*(argv + 1), "--help") == 0) {showAllDocumentation();}
        else 
        {
            printf(C_RED_SLIM "error: not correct argument <%s>\n" RESET_TO_DEF, *(argv + 1));
            printf("see documentation '--help'\n");
            main_flag = 1;
        }
    }
    else main_flag = 1;
    while(main_flag)  /* main circle, runs when we inside programm */
    {
        printf(C_YELLOW "~:" RESET_TO_DEF); // user input. 
        int countArgs = insideProgArgParser(inArgsPtr);
        if(countArgs > 1)
        {
            if(*(*(inArgsPtr + 1) + 1) == 'g') {globRootP = globmainArgParser(globRootP, globFP, countArgs, inArgsPtr, &main_flag);}
            else if(*(*(inArgsPtr + 1) + 1) == 'l') {dayRootP = daymainArgParser(dayRootP, dayFP, countArgs, inArgsPtr, &main_flag);}
            else if(mystrcmp(*(inArgsPtr + 1), "--help") == 0) {showAllDocumentation();}
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
    writeGlobStructToFile(globRootP, globFP);
    //writeDayStructToFile(dayRootPtr, dayfileP);
    //fclose(dayFP);
    fclose(globFP);
    //delete_whole_tree(globRootP); // big problem here, don't work at all
    //printf("free memory: success!\n");
    /*
    free all allocated memory, don't forget Alex! 
    free(inArgsPtr);
    */
    return 0;
}

FILE *createFile(FILE *fileP, char *fileName)
{
    char data_folder_path[60] = "/home/nastish/MyProjects/To-do-app/database/";
    void strconcat(char *, const char *);
    strconcat(data_folder_path, fileName);
    fileP = fopen(data_folder_path, "ab+"); // open file for read and write, don't rewrite the file 
    assert(fileP != NULL);
    return fileP;
}

/* concatenation func */
void strconcat(char *destination, const char *source)
{
    while(*destination) destination++;
    while((*destination++ = *source++) != '\0');
}

/* allocation for structure of type struct globalDataNode */
struct globalDataNode *tallocGlobalTask(void)
{
    struct globalDataNode *globptr;
    globptr = (struct globalDataNode *) malloc(sizeof(struct globalDataNode));
    assert(globptr != NULL);
    return globptr;
}

/* allocation for structure of type dayTasksNode */
struct tasksOnDay *tallocDayTask(void)
{
    struct tasksOnDay *dayptr;
    dayptr = (struct tasksOnDay *) malloc(sizeof(struct tasksOnDay));
    assert(dayptr != NULL);
    return dayptr;
}

/* allocate date */
struct universalDate *tallocDate(struct universalDate *ptrD)
{
    struct universalDate *p;
    p = (struct universalDate *) malloc(sizeof(struct universalDate));
    assert(p != NULL);
    p->day = ptrD->day, p->month = ptrD->month, p->year = ptrD->year;
    return p;
}

/* allocation any kind of description */
char *allocateDescription(char *dscrp)
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
int insideProgArgParser(char *inArgsPtr[])
{
    int i, lenLine, ptrCount = 1, argLen = 0;
    char *p, argsline[HEADER_DESCRP_LEN + 50], arg[HEADER_DESCRP_LEN];
    lenLine = mygetLine(argsline, HEADER_DESCRP_LEN + 50);
    
    for(i = 0; i < lenLine; i++)
    {
        if(!isspace(*(argsline + i))) {arg[argLen] = *(argsline + i); ++argLen; continue;}
        else
        {
            if((p = (char *)malloc(argLen + 1)) == NULL) {assert(p != NULL); /* some work with errors */;} // plus 1 for '\0'
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
int compareDates(struct universalDate *ptrOld, struct universalDate *ptrNew)
{
    if(ptrOld->year > ptrNew->year || ptrOld->year < ptrNew->year) {return ptrOld->year - ptrNew->year;}
    else
    {
        if(ptrOld->month > ptrNew->month || ptrOld->month < ptrNew->month) {return ptrOld->month - ptrNew->month;}
        else
        {
            if(ptrOld->day > ptrNew->day || ptrOld->day < ptrNew->day) {return ptrOld->day - ptrNew->day;}
            else return 0; /* it means that task was given at the same day */
        }
    }
}

/* calculate amount of days beetwen date of the start and date of the planning finish */
int amountOfDaysPerTask(struct universalDate *startptr, struct universalDate *endptr)
{
    int leapYearStart, leapYearFinish;
    int start = dayOfyear(startptr->year, startptr->month, startptr->day);
    int finish = dayOfyear(endptr->year, endptr->month, endptr->day);

    if(startptr->year == endptr->year)
        return finish - start;
    else
    {
        /* if 1 - leap, 0 - not leap */
        leapYearStart = startptr->year % 4 == 0 && startptr->year % 100 != 0 || startptr->year % 400 == 0; // check if begin year is leap or not 
        leapYearFinish = endptr->year % 4 == 0 && endptr->year % 100 != 0 || endptr->year % 400 == 0; // if finish year leap pr not

        if(endptr->year == startptr->year + 1) // if finish year is the next year after start year
        {
            if(leapYearStart) {return 366 - start + finish;} /* if leap year */
            else {return 365 - start + finish;}
        }
        else // if not the same year
        {
            int i, localYearLeap, countDays;
            countDays = 0;
            for(i = endptr->year - 1; i > startptr->year; i--)
            {
                localYearLeap = (i) % 4 == 0 && (i) % 100 != 0 || (i) % 400 == 0;
                countDays += (localYearLeap) ? 366 : 365; // calculate amount of days beetwen begin year and finish year

            }
            if(leapYearStart) {return 366 - start + countDays + finish;}
            else {return 365 - start + countDays + finish;}
        }
    }
}


int dayOfyear(int year, int month, int day)
{
    int i, leap;
    leap = year % 4 == 0 && year % 100 != 0 || year % 400 == 0; // compute leap year or not, 1 - leap, 0 - not leap
    for(i = 1; i < month; i++) {day += daysInmonth[leap][i];}
    return day;
}

struct globalDataNode *createGlobalTree(struct globalDataNode *ptrG, struct universalDate *beginDateptr, struct universalDate *finishDateptr, \
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
        ptrG = tallocGlobalTask();
        ptrG->headerOfNode = allocateDescription(header);
        ptrG->description = allocateDescription(descrp);
        ptrG->beginDate = tallocDate(beginDateptr);
        ptrG->finishDate = tallocDate(finishDateptr);
        ptrG->amountDays = amountOfDaysPerTask(ptrG->beginDate, ptrG->finishDate);
        ptrG->statusOfTask = allocateDescription(status);
        ptrG->leftnode = ptrG->rightnode = NULL;
    }
    else if((resultOfcompare = compareDates(ptrG->beginDate, beginDateptr)) == 0)
    {
        /* тут нужно сдвинуть ветку бинарного дерева и поместить такой-же узел сразу за таким -же самым узлом.
        причем нужно что-бы придыдущий узел указывал на только что вставленный и желательно если у предыдущего узла есть правая ветвь, указатель на 
        нее нужно переприсвоить новоприбывшему узлу, и соответсвенно указатель на всю левую часть на которую указывал старый такой-же узел нужно присвоить в новый узел.
        */

       // left node must be smaller and right node must be equal or hugher, i gave a bug here
        if(NULL != ptrG->leftnode)
        {
           struct globalDataNode *tempRight = (NULL != ptrG->rightnode) ? (ptrG->rightnode) : NULL;
           struct globalDataNode *tempLeft = ptrG->leftnode; // присваиваем времменно ссылку на узел левый узел который мы хотим подвинуть 
           ptrG->leftnode = createGlobalTree(NULL, beginDateptr, finishDateptr, descrp, header, DEF_STATUS);
           ptrG->leftnode->leftnode = tempLeft; // возможно привыходе адресс может потерятся, по этому нужно проверить эту функцию в будещем!
           ptrG->leftnode->rightnode = tempRight;

        }
        else // if that node doesn't have leftnode
            ptrG->leftnode = createGlobalTree(ptrG->leftnode, beginDateptr, finishDateptr, descrp, header, DEF_STATUS);
       
    }
    else if(resultOfcompare > 0) 
        ptrG->leftnode = createGlobalTree(ptrG->leftnode, beginDateptr, finishDateptr, descrp, header, DEF_STATUS); // go to left node
    else 
        ptrG->rightnode = createGlobalTree(ptrG->rightnode, beginDateptr, finishDateptr, descrp, header, DEF_STATUS);
    return ptrG; /* return pointer on root */
    
}

/* There is a big problem, is that when we inside programm we can write poiners and then read them, because 
this pointers consists of references on allocated block of memory with our word, but we can't read written in such way file
outside the programm, because references will not be exist, so we must write to file real values not pointers on
allocated memory with our words, and then we can easily read them, anyway we receive 'Segmentation fault' error.
So we must write all pieces of struct separately but before each one, write their lenght to file to, in order to read now 
length of word and allocated proper block of memory before reading word  */
struct globalDataNode *readGlobStructFromFile(struct globalDataNode *globP, FILE * fileP)
{
    int stop_read_flag;
    while(1)
    {
        struct globalDataNode tempP;
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
        tempP.beginDate = (struct universalDate *)malloc(sizeof(struct universalDate));
        fread(&tempP.beginDate->day, sizeof(unsigned short), 1, fileP); 
        fread(&tempP.beginDate->month, sizeof(unsigned short), 1, fileP);
        fread(&tempP.beginDate->year, sizeof(unsigned short), 1, fileP);
        tempP.finishDate = (struct universalDate *)malloc(sizeof(struct universalDate));
        fread(&tempP.finishDate->day, sizeof(unsigned short), 1, fileP);
        fread(&tempP.finishDate->month, sizeof(unsigned short), 1, fileP);
        fread(&tempP.finishDate->year, sizeof(unsigned short), 1, fileP); 
        tempP.leftnode = tempP.rightnode = NULL;

        globP = createGlobalTree(globP, tempP.beginDate, tempP.finishDate, tempP.description, tempP.headerOfNode, tempP.statusOfTask);
        free(tempP.finishDate);
        free(tempP.beginDate);
        free(tempP.description);
        free(tempP.statusOfTask);
        free(tempP.headerOfNode);
    }
    return globP;
} 


void writeGlobStructToFile(struct globalDataNode *globP, FILE * fileP) /* receive pointer on root */
{
    if(globP != NULL)
    {
        size_t len_header      = strlen(globP->headerOfNode) + 1;
        size_t len_description = strlen(globP->description)  + 1;
        size_t len_status      = strlen(globP->statusOfTask) + 1;

        // writing separate data to file 
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

        writeGlobStructToFile(globP->leftnode, fileP);
        writeGlobStructToFile(globP->rightnode, fileP);
    }
}

static unsigned long long task_number;
void globTreeprint(struct globalDataNode *globrootP)
{
    if(globrootP != NULL) // own address, not address of the left or right nodes
    {
        globTreeprint(globrootP->leftnode); // null

        printfirstFivecolumn(globrootP, task_number);
        unsigned int headerLen = strlen(globrootP->headerOfNode), descrpLen = strlen(globrootP->description);
        if(headerLen > 35 && descrpLen < 78) // if header length bigger then column size 
        {
            printWholeHeader(globrootP,headerLen, descrpLen);
        }
        else if(headerLen < 36 && descrpLen > 77) // if descrp len bigger then column size
        {
            int i;
            for(i = 0; i < (int)headerLen; i++) {printf("%c", globrootP->headerOfNode[i]);}
            for(; i < 35; i++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
            printWholeDescription(globrootP, descrpLen);
        } 
        else if(headerLen > 35 && descrpLen > 77) // if both data bigger then their column sizes
        {
            display_owersize_header_descrp(globrootP, headerLen, descrpLen);
        }
        else {display_header_descrp(globrootP, headerLen, descrpLen);} // if enough place
        printf(C_MAGENTA "  |");
        for(int i = 0; i < 170; i++) {printf("-");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
        ++task_number;
        globTreeprint(globrootP->rightnode);
    }
}


/* functions that works with flags from command line, print already allocated data! */
void displayAllGlobData(struct globalDataNode *globP)
{
    int flag = 0;
    system("clear");
    printf(C_CYAN "\t\t\t\t\t\t\t\t\t\tGLOBAL TASKS\n"); printf(C_MAGENTA "   __");
	for(int i = 0; i < 56; i++) {printf(C_MAGENTA " __");}; printf("\n");
	for(int i = 0; i <= 2; i++)
	{
        if(i < 2) {printtopOfTable(flag, i);} // some problems, not correct print of the last column sometimes
        else if(i == 2) {task_number = 1; globTreeprint(globP); task_number = 1;} /* this logic must be stored in separate functions */
	}
    printbottomOfTable();
}

struct globalDataNode *addGlobData(struct globalDataNode *globPtr, char *header)
{
    struct universalDate sdateP;
    struct universalDate fdateP;
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

        dateParser(&sdateP, startDate, sdateLen);
        dateParser(&fdateP, finishDate, fdateLen);

        globPtr = createGlobalTree(globPtr, &sdateP, &fdateP, description, (addHeaderflag  == 0) ? header : header_, DEF_STATUS);
        printf(C_RED_SLIM "Add more data?" RESET_TO_DEF); // there after input we have two symbols 'y' and '\n'
        scanf("%c", &addmoreData);
        scanf("%c", &garbich); // we need it, because our next getchar() in mygetline() func will read '\n' symbol and jump return
        ++addHeaderflag;
    }
    system("clear");
    //displayAllGlobData(globPtr);
    return globPtr;
}

/* string date convert to a real int date maybe strdate[] we can changge on char * strdate */
void dateParser(struct universalDate *dateP, char str_date[], int date_len) 
{
    int countDots = 0, index = 0;
    char tempDate[5];

    for(int i = 0; i < date_len; i++) 
    {
        if(*(str_date + i) != '.') {tempDate[index] = *(str_date + i); ++index;}
        else
        {
            ++countDots;
            if(countDots == 1) {tempDate[index] = '\0'; dateP->day = myatoi(tempDate); index = 0; continue;}
            if(countDots == 2) 
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
    int i;
    unsigned short n;

    if(date[0] == '0') {i = 1;}
    else {i = 0;}
    for(i; isspace(date[i]); i++);
    for(n = 0; isdigit(date[i]); i++) {n = 10 * n + (date[i] - '0');}
    return n;
}

struct globalDataNode *changeGlobStatus(struct globalDataNode *globPtr, char *date_to_change) // receive begin date
{
    struct universalDate convertDate;
    struct globalDataNode *reftoNode;
    char *dateP = date_to_change;
    int date_len = strlen(dateP);
    //printf("(%c)", *(date_to_change + date_len - 1));
    //printf("(%c)", *(date_to_change + date_len));
    
    *(date_to_change + date_len) = '\0';
    dateParser(&convertDate, date_to_change, date_len);
    reftoNode = findstatusinTree(globPtr, &convertDate);
    if(NULL == reftoNode)
    {
        printf(C_RED "date (%d %d %d) wasn't found.\n" RESET_TO_DEF, convertDate.day, convertDate.month, convertDate.year);
    }
    showGlobDataBy(globPtr, date_to_change);
    return globPtr;
}

struct globalDataNode *findstatusinTree(struct globalDataNode *globrootP, struct universalDate *dateP)
{
    int resultdate;
    if(NULL == globrootP) {return NULL;}
    else if((resultdate = compareDates(globrootP->beginDate, dateP)) > 0)
    {
        findstatusinTree(globrootP->leftnode, dateP);
    }
    else if(resultdate < 0)
    {
        findstatusinTree(globrootP->rightnode, dateP);
    }
    else // found match 
    {
        char status[12];
        printf(C_GREEN "status: " RESET_TO_DEF);
        int status_len = mygetLine(status, 12);
        *(status + status_len - 1) = '\0';
        strcpy(globrootP->statusOfTask, status);
        return globrootP; 
    }
}

struct globalDataNode *showGlobDataBy(struct globalDataNode *globPtr, char *date_to_show)
{
    struct universalDate tempdate;
    struct globalDataNode *tempP;
    char *dateP = date_to_show;
    int date_len = strlen(dateP);
    *(date_to_show + date_len) = '\0';
    dateParser(&tempdate, date_to_show, date_len);
    tempP = finddateinTree(globPtr, &tempdate);
    if(NULL == tempP)
    {
        printf(C_RED "date (%d %d %d) wasn't found.\n" RESET_TO_DEF, tempdate.day, tempdate.month, tempdate.year);// not enough
    }
    return globPtr;
}

struct globalDataNode *finddateinTree(struct globalDataNode *globrootP, struct universalDate *dateP)
{
    int resultdate;
    if(NULL == globrootP) {return NULL;}
    else if((resultdate = compareDates(globrootP->beginDate, dateP)) > 0) {finddateinTree(globrootP->leftnode, dateP);}
    else if(resultdate < 0) {finddateinTree(globrootP->rightnode, dateP);}
    else // such date was found 
    {
        int flag = 0;
        system("clear");
        printf(C_MAGENTA "   __");
        for(int i = 0; i < 56; i++) {printf(" __");} printf("\n");
        for(int i = 0; i <= 2; i++)
        {
            if( i < 2) {printtopOfTable(flag, i);}
            else if(i == 2)
            {
                printfirstFivecolumn(globrootP, 1); 
                unsigned int headerLen = strlen(globrootP->headerOfNode), descrpLen = strlen(globrootP->description);
                if(headerLen > 35 && descrpLen < 78)
                {
                    printWholeHeader(globrootP, headerLen, descrpLen);
                }
                else if(headerLen < 36 && descrpLen > 77)
                {
                    int i;
                    for(i = 0; i < (int)headerLen; i++) {printf("%c", globrootP->headerOfNode[i]);}
                    for(; i < 35; i++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
                    printWholeDescription(globrootP, descrpLen);
                }
                else if(headerLen > 35 && descrpLen > 77)
                {
                    display_owersize_header_descrp(globrootP, headerLen, descrpLen);
                }
                else {display_header_descrp(globrootP, headerLen, descrpLen);} // if enough place for both (header and description)
            }
        }printbottomOfTable();
        return globrootP;
    }
}

/* recursive function to properly print header if not enough space in column 
this func helps me to know how much words can be stored in one line */
void printWholeHeader(struct globalDataNode *globP, unsigned int h_len, unsigned int d_len) 
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
            printHeader(globP, h_len, &nSymbolsinLine, &i, &k); /* k = i in first call */
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

void printHeader(struct globalDataNode *globP, unsigned int h_len, unsigned int *nSymbols, int *i, int *k)
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
            printHeader(globP, h_len, nSymbols, i, k);
            break;
        }
    }
} // i think it's done!

void printWholeDescription(struct globalDataNode *globP, unsigned int d_len)
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
            printDescription(globP, d_len, &nSymbolsinLine, &i, &k);
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

void printDescription(struct globalDataNode *globP, unsigned int d_len, unsigned int *nSymbols, int *i, int *k)
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
            printDescription(globP, d_len, nSymbols, i, k);
            break;
        }
    }
}


void display_owersize_header_descrp(struct globalDataNode *globP, unsigned int h_len, unsigned int d_len)
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


int display_owersize_header(struct globalDataNode *globP, unsigned int h_len, int *h_i)
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
            printHeader(globP, h_len, &nSymbolsinLine, h_i, &k); /* k = i in first call */
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

int display_owersize_descrp(struct globalDataNode *globP, unsigned int d_len, int *d_i)
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
            printDescription(globP, d_len, &nSymbolsinLine, d_i, &k);
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


void printfirstFivecolumn(struct globalDataNode *globP, unsigned int task_number)
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


void printtopOfTable(int flag, int i)
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

void printbottomOfTable(void)
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

void display_header_descrp(struct globalDataNode *globP, unsigned int headerLen, unsigned int descrpLen)
{
    int i, j;
    for(i = 0; i < (int)headerLen; ++i) {printf("%c", globP->headerOfNode[i]);}
    for(; i < 35; i++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
    for(j = 0; j < (int)descrpLen; j++) {printf("%c", globP->description[j]);}
    for(; j < 77; j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF); 
}

/* function that delete one node from tree, it's complicated func because we need rebuild 
all tree to save tree properties */
struct globalDataNode *deleteGlobDataBy(struct globalDataNode *globPtr, char *str_date)
{
    struct universalDate date_to_del;
    //dateParser(&date_to_del, str_date, date_len);
}

// which date == 0 (begin date), 1(finish date)
struct globalDataNode *change_begin_date(struct globalDataNode *globP, char *date_to_change) 
{
    ;
}

struct globalDataNode *change_finish_date(struct globalDataNode *globP, char *date_to_change)
{
    ;
}

struct globalDataNode *change_header(struct globalDataNode *globP, char *header_to_change)
{
    ;
}

struct globalDataNode *change_description(struct globalDataNode *globP, char *descrp_to_change)
{
    ;
}


struct tasksOnDay *readDayStructFromFile(FILE *filePtr)
{
    return ;
}

void displayAllDayData(struct tasksOnDay *dayTasksP)
{
    return;
}

struct tasksOnDay *addDayData(struct tasksOnDay *daydataPtr, char *header)
{
    return;
}

struct tasksOnDay *changeDayStatus(struct tasksOnDay *daydataPtr, char *dateToChange)
{
    /*......................*/
    showDayDataBy(daydataPtr, dateToChange);
    return;
}

struct tasksOnDay *showDayDataBy(struct tasksOnDay *daydataPtr, char *dateToShow)
{
    return;
}

struct tasksOnDay *deleteDayDataBy(struct tasksOnDay *daydataPtr, char *dateTodDelete)
{
    return;
}

struct globalDataNode *globmainArgParser(struct globalDataNode *globRootP, FILE *globFP, int argc, const char *argv[], int *mainflag)
{
    /* built tree and allocate memory for all data in file, and return pointer on root 
    if data exist in file of course */
    globRootP = readGlobStructFromFile(globRootP, globFP); 
    if(argc == 2 && (mystrcmp(argv[1], "-g") == 0)) /* -g */
    {
        displayAllGlobData(globRootP);
        (*mainflag)++;
    }
    // work with errors
    else if(argc > 2)
    {
        if(argc == 3)
        {
            for(int i = 0; i < GLOB_FLAGSARRAY_LEN; i++)
            {
                if(mystrcmp(argv[1], flagsArrayGlob[i].flag) == 0)
                {
                    if(*(*(argv + 1) + 1) == 'g')
                    {
                        globRootP = flagsArrayGlob[i].flagFunc(globRootP, argv[2]);
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
                if(mystrcmp(argv[1], "-g") == 0) /* -g */
                {
                    if(mystrcmp(argv[2], flagsArrayGlob[i].flag) == 0) {globRootP = flagsArrayGlob[i].flagFunc(globRootP, argv[3]);}
                    else; // work with errors
                }
                else; // work with errors
            }
        }
        else; // work with errors
    }
    else
    {
        /* there may be something more complicated */
        printf(C_RED "%s\t%s\n", *(argv + 1), "error: incorrect comand line argument!" RESET_TO_DEF);
    }
    return globRootP;
}

struct tasksOnDay *daymainArgParser(struct tasksOnDay *daytasksP, FILE *dayFP, int argc, const char *argv[], int *mainflag)
{
    readDayStructFromFile(dayFP); /* reading data from file and allocate array of structs to store that date, realloc if not enough space */ 
    /* read function will be sort data with qsort algorithm so in future we can easily use binary search */
    if(argc == 2 && (mystrcmp(argv[1], "-l") == 0)) /* -l */
    {
        displayAllGlobData(daytasksP);
        *mainflag++;
    }
    //work with errors
    else if(argc > 2)
    {
        if(argc == 3)
        {
            for(int i = 0; i < DAY_FLAGSARRAY_LEN; i++)
            {
                if((mystrcmp(argv[1], flagsArrayGlob[i].flag) == 0) || (mystrcmp(argv[1], flagsArrayDay[i].flag) == 0))
                {
                    if(*(*(argv + 1) + 1) == 'l') 
                    {
                        daytasksP = flagsArrayDay[i].flagFunc(daytasksP, argv[2]);
                        ++mainflag;
                        break;
                    }
                    else;/* work with error!, not importatnt for now, maybe it will be a function */
                }
                else; /* work with error */
            }
        }
        else if(argc == 4) // change
        {
            for(int i = 0; i < DAY_FLAGSARRAY_LEN; i++)
            {
                if(mystrcmp(argv[1], "-l") == 0) /* -l */
                {
                    if(mystrcmp(argv[2], flagsArrayDay[i].flag) == 0) {daytasksP = flagsArrayDay[i].flagFunc(daytasksP, argv[3]);}
                    else; // work with errors
                }
                else; // work with errors
            }
        }
        else; //work with errors
    }
    else
    {
        /* there may be something more complicated */
        printf(C_RED "%s\t%s\n", *(argv + 1), "error: incorrect comand line argument!" RESET_TO_DEF);
    }
    return daytasksP;
}


struct globalDataNode *makeTreeBalanced(struct globalDataNode *globP) // to make tree balanced 
{
    ;
}

void showAllDocumentation(void)
{
    ;
    /*
    Read file that contains all documentation and display all text on the screen
    all available flags, all combinations of them, and what this programm can do.
    All documentation is located in one .txt file called 'appDoc'.
    */
}

/* we must debug this func because now it's not very clean */
void delete_whole_tree(struct globalDataNode *rootP)
{
    if(NULL ==rootP) return;
    delete_whole_tree(rootP->leftnode);
    delete_whole_tree(rootP->rightnode);
    free(rootP->headerOfNode);
    free(rootP->amountDays);
    free(rootP->statusOfTask);
    free(rootP->description);
    free(rootP->beginDate);
    free(rootP->finishDate);
    free(rootP);
}