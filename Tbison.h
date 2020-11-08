#include "ListeDataStructure/words.h"
#include "ListeDataStructure/liste.h"
#define NBRF  7
#define MALE '0'
#define FEMALE '1'
#define MALE_FEMALE '2'
#define USELESS  'M' // 'M'++ becomes 'N'
extern  int yylineno;
int     yylex();
void    yyerror(char *s);
char*   concat2Strs(char *str1, char *str2);
char*   afficheVerb(char, char, char);
void    addToBeFree(char* chunk);
void    toBeFree();
void    fetchWords(Liste*,FILE*);
void    displayVerb(char*,char*,char ,char ,char ,char ,char*);
void    displayAdjectif(char *value,char *translation,char gender,char *negation);
void    displaySubject(char *value,char *translation,char gender,char number,char direction);
void    displayComplement(char *value,char *translation,char gender,char number,char direction);
int     isGendersOk(char gender1,char gender2);
int     isDirectionsOk(char direction1,char direction2);
int     isNumbersOk(char number1,char number2);
int     isTimesOk(char,char);
void    drawLine();
char    drapeau=0;
char    thereIsError=0;
const   char *labels[NBRF]={"verbs","nounsM","nounsF","nomPM","nomPF","adverbs","adjectives"};
Liste*  dictio[NBRF]={};
char*   pointersToFree[100];