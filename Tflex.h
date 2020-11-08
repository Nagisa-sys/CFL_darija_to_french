#include "ListeDataStructure/words.h"
#include "ListeDataStructure/liste.h"
#define NBRF  7
#define PRESENT '0'
#define PAST '1'
#define MALE '0'
#define FEMALE '1'
#define MALE_FEMALE '2'
#define SINGULAR '1'
#define PLURAL '2'
#define PREMIEREP '0'
#define DEUXIEMEP '1'
#define TROISIEMEP '2'
void* exist(char* ,Liste* );
void nonExistance(char* );
char* lowerString(char* );
extern char drapeau;
extern const char *labels[NBRF];
extern Liste* dictio[NBRF];
extern char* pointersToFree[100];
void sendVerbe(char* value,char* translation,char time,char gender,char number,char direction);
void sendName(char* ,char* ,char ,char );
void sendPronoun(char* value,char* translation,char* translation2,char gender,char number,char direction);
void sendNameP(char* value,char gender);
void sendAdv(char* value,char* translation);
void sendAdj(char* value,char* translation,char gender);
void sendQuestion(char* value,char* translation);
extern void addToBeFree(char* );