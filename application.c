#include "application.h"

int main(int argc, const char *argv[])
{
    int firstArgLen, mainflag = 0;
    char *p;
    if((p = allocMemory(firstArgLen = mystrlen(*argv) + 1)) != NULL) {strcpy(p, *argv); *(p + firstArgLen) = '\0'; inArgsPtr[0] = p;}
    system("clear");

    FILE* dayFP = createFile(dayFP, "dayData.bin");
    FILE* globFP = createFile(globFP, "globData.bin");

    struct tasksOnDay *dayRootP = NULL; // maybe it unnecessary */
    struct globalDataNode *globRootP = NULL; // poiner to array of such structs

    if(argc > 1)
    {
        if(*(*(argv + 1) + 1) == 'g') {globRootP = globmainArgParser(globRootP, globFP, argc, argv, &mainflag);}
        else if(*(*(argv + 1) + 1) == 'l') {dayRootP = daymainArgParser(dayRootP, dayFP, argc, argv, &mainflag);}
        else; /*  work with errors */
    }
    else; /* maybe display all data or work with errors */

    while(mainflag)  /* main circle, runs when we inside programm */
    {
        printf(C_YELLOW "~:" RESET_TO_DEF); // sign that we can write all allowed commands here
        int countArgs = insideProgArgParser(inArgsPtr);
        if(countArgs > 1)
        {
            if(*(*(inArgsPtr + 1) + 1) == 'g') {globRootP = globmainArgParser(globRootP, globFP, countArgs, inArgsPtr, &mainflag);}
            else if(*(*(inArgsPtr + 1) + 1) == 'l') {dayRootP = daymainArgParser(dayRootP, dayFP, countArgs, inArgsPtr, &mainflag);}
            else; /* work with errors */
        }
        else; /* work with errors or display all data */
        //system("clear");// clean console
        //mainflag = 0;
    }
    //globTreeprint(globRootP, ...);
    // rewrite all data to fils if something was changed */

    //writeGlobStructToFile(globRootP, globFP);
    //writeDayStructToFile(dayRootPtr, dayfileP);

    //fclose(dayFP);
    //fclose(globFP);

    // free all allocated memory, don't forget Alex! S
    return 0;
}

FILE *createFile(FILE *fileP, char *fileName)
{
    char data_folder_path[60] = "/home/nastish/MyProjects/To-do-app/database/";
    void strconcat(char *, const char *);

    strconcat(data_folder_path, fileName);
    fileP = fopen(data_folder_path, "ab+"); // open file for read and write, don't rewrite the file 
    
    if(NULL == fileP)
    {
        printf("error: while openning file!\n");
        exit(1);
    }
    return fileP;
}


/* concatenation func */
void strconcat(char *destination, const char *source)
{
    while(*destination)
        destination++;
    while((*destination++ = *source++) != '\0')
        ;
}

/* allocation for structure of type struct globalDataNode */
struct globalDataNode *tallocGlobalTask(void)
{
    struct globalDataNode *globptr;
    globptr = (struct globalDataNode *) malloc(sizeof(struct globalDataNode));

    if(NULL == globptr)
    {
        //do something? now i don't know what 
    }
    return globptr;

}

/* allocation for structure of type dayTasksNode */
struct tasksOnDay *tallocDayTask(void)
{
    struct tasksOnDay *dayptr;
    dayptr = (struct tasksOnDay *) malloc(sizeof(struct tasksOnDay));

    if(NULL == dayptr)
    {
        // do somthing to avoid crash
    }
    return dayptr;
}

/* allocate date */
struct universalDate *tallocDate(struct universalDate *ptrD)
{
    struct universalDate *p;
    p = (struct universalDate *) malloc(sizeof(struct universalDate));

    if(NULL == p)
    {
        //..........................
    }
    p->day = ptrD->day, p->month = ptrD->month, p->year = ptrD->year;
    return p;
}

/* allocation any kind of description */
char *allocateDescription(char *dscrp)
{
    char *descriptionP;
    descriptionP = (char *) malloc(mystrlen(dscrp) + 1); // 1 for symbol '\0' 

    if(NULL == descriptionP)
    {
        // do somthing to deal with error
    }
    strcpy(descriptionP, dscrp);
    return descriptionP;
}

char *allocMemory(int amount)
{
    if(allocatedBuffer + ALLOCSIZE - allocBufP >= amount)
    {
        allocBufP += amount;
        return allocBufP - amount; // return pointer at the begging of recently allocated word
    }
    else {printf("allocMemory error: not enough space in buffer!\n");} // work with errors
}

void freeAllocMem(char *freeP) 
{
    if(freeP >= allocatedBuffer && freeP < allocatedBuffer + ALLOCSIZE) {allocBufP = freeP;}
}

int mygetLine(char args[], int lim) // type missmatvh
{
    char symbol;
    int i;
    for(i = 0; i < lim && (symbol = getchar()) != EOF && symbol != '\n'; i++) 
    {
        args[i] = symbol;
    }
    if(symbol == '\n') 
    {
        args[i++] = symbol;
    }
    args[i] = '\0';
    return i; // as a lenght of line
}

int insideProgArgParser(char *inArgsPtr[])
{
    int i, lenLine, ptrCount = 1, argLen = 0;
    char *p, argsline[BUFSIZE], arg[BUFSIZE / 2]; // we need size not limited, we need pointers, very important error FIX
    lenLine = mygetLine(argsline, BUFSIZE);
    
    for(i = 0; i < lenLine; i++)
    {
        if(!isspace(argsline[i])) {arg[argLen] = argsline[i]; ++argLen; continue;}
        else
        {
            if((p = allocMemory(argLen + 1)) == NULL) {/* some work with errors */;} // plus 1 for '\0'
            else {arg[argLen] = '\0';strcpy(p, arg); inArgsPtr[ptrCount++] = p; argLen = 0;}
            if(argsline[i  + 1] != '-' && argsline[i] != '\n')
            {
                for(i += 1, argLen = 0; i < lenLine; i++, argLen++) {arg[argLen] = argsline[i];}
                if((p = allocMemory(argLen)) == NULL) {/* work with error */;}
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
    {/* if 1 - leap, 0 - not leap */
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
    //printf("%s\n", descrp);
    //printf("%s\n", header);
    //printf("%s\n", status);
    //printf("start date : %d %d %d\n", beginDateptr->day, beginDateptr->month, beginDateptr->year);
    //printf("finish : %d %d %d\n", finishDateptr->day, finishDateptr->month, finishDateptr->year);

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

/* writing whole binary tree to file and reading from here */
struct globalDataNode *readGlobStructFromFile(struct globalDataNode *globP, FILE * filePtr)
{
    int n_read, localFlag = 0;
    struct globalDataNode tempP;
    while((n_read = fread(&tempP, sizeof(tempP), 1, filePtr)) != 0)
    {
        tempP.leftnode = tempP.rightnode = NULL;
        if(!localFlag)
        {
            globP = createGlobalTree(NULL, tempP.beginDate, tempP.finishDate, tempP.description, tempP.headerOfNode, tempP.amountDays);
            localFlag = 1;
        }
        else
        {
            globP = createGlobalTree(globP, tempP.beginDate, tempP.finishDate, tempP.description, tempP.headerOfNode, tempP.statusOfTask);
        }
        
    }
    return globP;
} // done


void writeGlobStructToFile(struct globalDataNode *structPtr, FILE * filePtr) /* receive pointer on root */
{
    if(structPtr != NULL)
    {
        fwrite(structPtr, sizeof(*structPtr), 1, filePtr);
        writeGlobStructToFile(structPtr->leftnode, filePtr);
        writeGlobStructToFile(structPtr->rightnode, filePtr);
    }
}

void globTreeprint(struct globalDataNode *globrootP, unsigned int taskNumber)
{
    if(globrootP != NULL)
    {
        unsigned short flagCaret = 0;
        globTreeprint(globrootP->leftnode, taskNumber);
    
        ++taskNumber;
        printfirstFivecolumn(globrootP, taskNumber);
        
        unsigned int headerLen = strlen(globrootP->headerOfNode), descrpLen = strlen(globrootP->description);
        if(headerLen > 35 && descrpLen < 77) 
        {
            ;
        }
        else if(headerLen < 35 && descrpLen > 77) 
        {
            ;
        }
        else if(headerLen > 35 && descrpLen > 77) 
        {
            ;
        }
        else {printHeaderandDescrp(globrootP, headerLen, descrpLen); flagCaret = 1;} /* if enough place */
        if(NULL != globrootP->leftnode || NULL != globrootP->rightnode) /* don't draw the last '-' line */
        {
            printf(C_MAGENTA "  |");
            for(int i = 0; i < 170; i++) {printf("-");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
            flagCaret = 1;
        }
        else if(!flagCaret) {printf(C_MAGENTA "|\n" RESET_TO_DEF);}
        /*
         printing header of task and description 
        */
        globTreeprint(globrootP->rightnode, taskNumber);
        ++taskNumber;
    }
}


/* functions that works with flags from command line, print already allocated data! */
void displayAllGlobData(struct globalDataNode *globP)
{
    system("clear");
    unsigned int taskNumber = 0; /* tasks counter */
    int flag = 0;
    printf(C_CYAN "\t\t\t\t\t\t\t\t\t\tGLOBAL TASKS\n"); printf(C_MAGENTA "   __");
	for(int i = 0; i < 56; i++) {printf(C_MAGENTA " __");}; printf("\n");
	for(int i = 0; i <= 2; i++)
	{
        if(i < 2) {printtopOfTable(flag, i);}
        else if(i == 2) {globTreeprint(globP, taskNumber);} /* this logic must be stored in separate functions */
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
        char startDate[11], finishDate[11], header_[250], description[10000];
        printf(C_GREEN "start date: " RESET_TO_DEF);
        sdateLen = mygetLine(startDate, 11);
        *(startDate + sdateLen - 1) = '\0'; // replace '\n' with '\0'

        printf(C_GREEN "finish date: " RESET_TO_DEF);
        fdateLen = mygetLine(finishDate, 11);
        *(finishDate + fdateLen - 1) = '\0';

        printf(C_GREEN "description: " RESET_TO_DEF);
        descrpLen = mygetLine(description, 10000);
        *(description + descrpLen - 1) = '\0';
        if(addHeaderflag > 0)
        {
            printf(C_GREEN "header: " RESET_TO_DEF);
            headerLen = mygetLine(header_, 250);
            *(header_ + headerLen - 1) = '\0';
        }

        dateParser(&sdateP, startDate, sdateLen);
        dateParser(&fdateP, finishDate, fdateLen);

        globPtr = createGlobalTree(globPtr, &sdateP, &fdateP, description, (addHeaderflag  == 0) ? header : header_, DEF_STATUS);
        printf(C_RED_SLIM "Add more data?" RESET_TO_DEF); // there after input we have two symbols 'y' and '\n'
        scanf("%c", &addmoreData);
        scanf("%c", &garbich); // we need it, because or next getchar() will read '\n' symbol and jump return
        ++addHeaderflag;
    }
    system("clear");
    displayAllGlobData(globPtr);
    return globPtr;
}

void dateParser(struct universalDate *dateP, char strdate[], int dateLen) // string date convert to a real int date maybe strdate[] we can changge on char * strdate
{
    int countDots = 0, index = 0;
    char tempDate[5];

    for(int i = 0; i < dateLen; i++) 
    {
        if(strdate[i] != '.') {tempDate[index] = strdate[i]; ++index;}
        else
        {
            ++countDots;
            if(countDots == 1) {tempDate[index] = '\0'; dateP->day = myatoi(tempDate); index = 0; continue;}
            if(countDots == 2) 
            {
                tempDate[index] = '\0';
                dateP->month = myatoi(tempDate), index = 0;
                for(i += 1; i < dateLen; i++) {tempDate[index] = strdate[i]; ++index;}
                tempDate[index] = '\0';
                dateP->year = myatoi(tempDate);
                return;
            }
        }
    }
}

unsigned short myatoi(char date[]) /* convert day, month, tear into number */
{
    int i;
    unsigned short n;

    if(date[0] == '0') {i = 1;}
    else {i = 0;}
    for(i; isspace(date[i]); i++);
    for(n = 0; isdigit(date[i]); i++) {n = 10 * n + (date[i] - '0');}
    return n;
}

struct globalDataNode *changeGlobStatus(struct globalDataNode *globPtr, char *dateToChange) // receive begin date
{
    struct universalDate convertDate;
    struct globalDataNode *reftoNode;
    dateParser(&convertDate, dateToChange, 11);
    reftoNode = findstatusinTree(globPtr, &convertDate);
    if(NULL == reftoNode)
    {
        printf(C_RED "date (%d %d %d) wasn't found.\n" RESET_TO_DEF, convertDate.day, convertDate.month, convertDate.year);
    }
    showGlobDataBy(globPtr, dateToChange);
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
    else /* found match */
    {
        char status[12];
        printf(C_GREEN "status: " RESET_TO_DEF);
        int status_len = mygetLine(status, 12);
        *(status + status_len - 1) = '\0';
        strcpy(globrootP->statusOfTask, status);
        return globrootP; 
    }
}

struct globalDataNode *showGlobDataBy(struct globalDataNode *globPtr, char *dateToShow)
{
    struct universalDate tempdate;
    struct globalDataNode *tempP;
    dateParser(&tempdate, dateToShow, 11);
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
    else // if found - print info
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
                printfirstFivecolumn(globrootP, 1); /* filling  columns */
                unsigned int headerLen = strlen(globrootP->headerOfNode), descrpLen = strlen(globrootP->description);
                if(headerLen > 35 && descrpLen < 77)
                {
                    unsigned int countsymbols, printemptyColumn, descrpPrint;
                    countsymbols = printemptyColumn = descrpPrint = 0;

                    printHeader(globrootP, headerLen, descrpLen, &countsymbols, &printemptyColumn, &descrpPrint);
                }
                else if(headerLen < 35 && descrpLen > 77) /* to realize in separate func */
                {
                    ;
                }
                else if(headerLen > 35 && descrpLen > 77) /* to realize in separate func */
                {
                    ;
                }
                else {printHeaderandDescrp(globrootP, headerLen, descrpLen);} /* if enough place for both (header and description) */
            }
        }printbottomOfTable();
        return globrootP;
    }
}

/* recursive function to properlt print header if not enough space in column */
int printHeader(struct globalDataNode *globP, unsigned int hLen, unsigned int dLen, 
    unsigned int *nSymbols, unsigned int *emptyColumn, unsigned int *printdescrp) /* this func helps me to know how much words can be stored in one line */
{
    for(int i = 0; i < hLen; i++)
    {
       if(i == hLen - 1) /* means that now we will print the last symbol */
       {
           printf("%c", globP->headerOfNode[i]);
           for(int k = 0; k < (35 - *nSymbols - 1); k++) {printf(" ");}; printf(C_MAGENTA "|");
           for(int g = 0; g < 77; g++) {printf(" ");}; printf("|\n" RESET_TO_DEF);
           break;
        }
        else if(globP->headerOfNode[i] == ' ' || globP->headerOfNode[i] == ',' || globP->headerOfNode[i] == '.' || 
            globP->headerOfNode[i] == '!' || globP->headerOfNode[i] == '?' || globP->headerOfNode[i] == '-')
        {
            int k = i;
            printHeader(globP, hLen, nSymbols, emptyColumn, printdescrp); /* main problem */
            if(!*printdescrp) /* if description hasn't been printed, we print it, and increase descrpPrint flag on 1 */
            {
                int x; printdescrp = 1;
                for(int j = 0; j < (35 - *nSymbols); j++) {printf(" ");}; printf(C_MAGENTA "|" RESET_TO_DEF);
                for(x = 0; x < dLen; x++) {printf(C_YELLOW "%c", globP->description[x]);}
                for(; x < 77; x++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
            }
            else /* if was printed, we print empty line */
            {
                for(int j = 0; j < (35 - *nSymbols); j++) {printf(" ");}; printf(C_MAGENTA "|");
                for(int g = 0; g < 77; g++) {printf(" ");}; printf("|\n" RESET_TO_DEF);
            }
            *emptyColumn = 1;
            *nSymbols = 0;
            continue;
        }
        else if(*emptyColumn) /* print all empty column before header column */
        {
            printf(C_MAGENTA "  |  ");
            for(int z = 0; z < 56; z++)
            {
                if(z == 1 || z == 6 || z == 11 || z == 13) {printf("|  ");}
                else if(z == 18) {printf("|" RESET_TO_DEF); break;} /* break when we reach the last "|" before header column */
                else             {printf("   ");}
            }
            *emptyColumn = 0;
        }
        printf("%c", globP->headerOfNode[i]);
        ++(*nSymbols);
    }
}

void printfirstFivecolumn(struct globalDataNode *globP, unsigned int taskNum)
{
    printf(C_MAGENTA "  |");
    printf(C_CYAN "%5d" RESET_TO_DEF, taskNum);
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

    if((mystrcmp(globP->statusOfTask, "in progress")) == 0) {printf(C_YELLOW " %s  ", globP->statusOfTask, RESET_TO_DEF);}
    else if((mystrcmp(globP->statusOfTask, "done")) == 0) {printf(C_GREEN "     %s     ", globP->statusOfTask, RESET_TO_DEF);}
    else if((mystrcmp(globP->statusOfTask, "denied")) == 0) {printf(C_RED_SLIM "    %s    ", globP->statusOfTask, RESET_TO_DEF);}
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
        else if(j == 56) {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE "\t\t task name\t       "); j = 91;}}
        else if(j == 92) {printf(C_MAGENTA "|"); if(i == 0) {printf(C_BLUE "\t\t\t\tdescription\t\t\t\t    "); j = 168;}}
        else             {printf(C_MAGENTA " ");}
        // 35 spaces beforelast column, 76 spaces last column
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

void printHeaderandDescrp(struct globalDataNode *globP, unsigned int headerLen, unsigned int descrpLen)
{
    int i, j;
    for(i = 0; i < headerLen; i++) {printf("%c", globP->headerOfNode[i]);}
    for(; i < 35; i++) {printf(" ");}; printf(C_MAGENTA "|");
    for(j = 0; j < descrpLen; j++) {printf(C_YELLOW "%c", globP->description[j]);}
    for(; j < 77; j++) {printf(" ");}; printf(C_MAGENTA "|\n" RESET_TO_DEF);
}

/* i don't know now how to do it */
struct globalDataNode *deleteGlobDataBy(struct globalDataNode *globPtr, char *dateToDelete)
{
    return;
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
    globRootP = readGlobStructFromFile(globRootP, globFP);/* built tree and allocate memory for all data in file, and return pointer on root */
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
            for(int i = 0; i < FLAGSARRAY_LEN; i++)
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
            for(int i = 0; i < FLAGSARRAY_LEN; i++)
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
            for(int i = 0; i < FLAGSARRAY_LEN; i++)
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
            for(int i = 0; i < FLAGSARRAY_LEN; i++)
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
