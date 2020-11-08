%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include <errno.h>
    #include "Tbison.h"
%}
%union{
    struct{ char* _Tvalue;
            char* _Ttranslation;
            char _Tgender;
            char _Tnumber;
            char _Tdirection;
            char _Ttime;
    }_Sverbe;
    struct{ char* _Tvalue;
            char* _Ttranslation;
            char _Tgender;
            char _Tnumber;
    }_Snoun;
    struct{ char* _Tvalue;
            char _Tgender;
    }_SnounP;
    struct{ char* _Tvalue;
            char* _Ttranslation;
    }_Sadv;
    struct{ char* _Tvalue;
            char* _Ttranslation;
            char _Tgender;
    }_Sadj;
    struct{ char* _Tvalue;
            char* _Ttranslation;
    }_Squestion;
    struct{ char* _Tvalue;
            char* _Ttranslation;
            char* _Ttranslation2;
            char _Tgender;
            char _Tnumber;
            char _Tdirection;
    }_Spronoun;
    struct{ char* _Tvalue;
            char* _Ttranslation;
            char _Tgender;
            char _Tnumber;
            char _Tdirection;
    }_Ssujet;
    struct{ char* _Tvalue;
            char* _Ttranslation;
            char _Tgender;
            char _Tnumber;
            char _Tdirection;
            char _Ttime;
    }_Scomplement;
    char* obj;
}
%token <_Sverbe> VERBE
%token <_Snoun> NOUN
%token <_SnounP> NOUNP
%token <_Sadv> ADV
%token <_Sadj> ADJ
%token <_Spronoun> PRONOUN
%token <_Squestion>  QUESTION
%token NEGATION

%type <_Sverbe>      verb
%type <_Ssujet>      sujet
%type <_Sadj>        description
%type <_Scomplement> complement

%%

listPhrase : phrase {  
                        drawLine();
                        thereIsError=0;
                    } 
        |   listPhrase phrase {    
                        toBeFree(); 
                        drawLine();
                        thereIsError=0;
                    }
        ;

phrase	:   sujet description EOL {
                            displaySubject($1._Tvalue,$1._Ttranslation,$1._Tgender,$1._Tnumber,$1._Tdirection);
                            if( isGendersOk($1._Tgender , $2._Tgender) )
                                    yyerror("le Sujet et la description doivent avoir le meme genre");
                            !thereIsError && printf("%s %s\n",$1._Ttranslation,$2._Ttranslation);
                            }
        |   verb EOL {
                            !thereIsError && printf("%s (%s)\n",$1._Ttranslation, afficheVerb($1._Ttime, $1._Tdirection, $1._Tnumber));
                            }
        |   verb complement EOL {
                            displayComplement($2._Tvalue,$2._Ttranslation,$2._Tgender,$2._Tnumber,$2._Tdirection);
                            if( isGendersOk($1._Tgender , $2._Tgender) )
                                    yyerror("le verbe et le complement doivent avoir le meme genre");
                            if( isDirectionsOk($1._Tdirection,$2._Tdirection) )
                                    yyerror("le verbe et le complement n'ont pas la meme structure des relations de personne");
                            if( isNumbersOk($1._Tnumber,$2._Tnumber) )
                                    yyerror("le verbe et le complement doivent de refairer au meme nombre");
                            !thereIsError && printf("%s %s(%s)\n",$2._Ttranslation,$1._Ttranslation,afficheVerb($1._Ttime, $1._Tdirection, $1._Tnumber));
                            }
        |   sujet verb complement EOL {
                            displaySubject($1._Tvalue,$1._Ttranslation,$1._Tgender,$1._Tnumber,$1._Tdirection);
                            displayComplement($3._Tvalue,$3._Ttranslation,$3._Tgender,$3._Tnumber,$3._Tdirection);
                            if($3._Tgender!=USELESS && $3._Ttime!=USELESS)
                                if( isGendersOk($2._Tgender , $3._Tgender) )
                                    yyerror("le verbe et le complement doivent avoir le meme genre");
                            if( isGendersOk($1._Tgender , $2._Tgender) )
                                    yyerror("le Sujet et le verbe doivent avoir le meme genre");
                            if( isDirectionsOk($1._Tdirection,$2._Tdirection) )
                                    yyerror("le Sujet et le verbe n'ont pas la meme structure des relations de personne");
                            if( isNumbersOk($1._Tnumber,$2._Tnumber) )
                                    yyerror("le Sujet et le verbe doivent de refairer au meme nombre");
                            !thereIsError && printf("%s %s(%s) %s\n", $1._Ttranslation, $2._Ttranslation, afficheVerb($2._Ttime, $2._Tdirection, $2._Tnumber), $3._Ttranslation);
                            }
        |   QUESTION SPACE verb '?' {
                            !thereIsError && printf("%s %s(%s) ?\n",$1._Ttranslation,$3._Ttranslation, afficheVerb($3._Ttime, $3._Tdirection, $3._Tnumber));
                            }
        |   QUESTION SPACE verb complement '?' {
                            displayComplement($4._Tvalue,$4._Ttranslation,$4._Tgender,$4._Tnumber,$4._Tdirection);
                            if( isGendersOk($3._Tgender , $4._Tgender) )
                                yyerror("le verbe et le complement doivent avoir le meme genre");
                                if( isDirectionsOk($3._Tdirection,$4._Tdirection) )
                                    yyerror("le sujet et le verbe n'ont pas la meme structure des relations de personne");
                            if( isNumbersOk($3._Tnumber,$4._Tnumber) )
                                    yyerror("le sujet et le verbe doivent de refairer au meme nombre");
                            !thereIsError && printf("%s %s(%s) %s ?\n",$1._Ttranslation,$3._Ttranslation, afficheVerb($3._Ttime, $3._Tdirection, $3._Tnumber),$4._Ttranslation);
                            }
       ;

sujet	:   PRONOUN SPACE {
                            $$._Ttranslation=$1._Ttranslation;
                            $$._Tvalue=$1._Tvalue;
                            $$._Tgender=$1._Tgender;
                            $$._Tnumber=$1._Tnumber;
                            $$._Tdirection=$1._Tdirection;
                            }
        |   PRONOUN SPACE 'w' SPACE NOUNP SPACE {
                            $$._Ttranslation = concat2Strs(concat2Strs($5._Tvalue," et "),$1._Ttranslation2);
                            $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue," w "),$5._Tvalue);
                    
                            if(!strcmp($1._Tvalue,"ana") || !strcmp($1._Tvalue,"7na") )
                                {$$._Tgender='2';$$._Tnumber='2';$$._Tdirection='0';}
                            else if(!strcmp($1._Tvalue,"nta")  ||  !strcmp($1._Tvalue,"nti")  ||  !strcmp($1._Tvalue,"ntuma"))
                                {$$._Tgender='2'; $$._Tnumber='2';$$._Tdirection='1';}
                            else
                                {$$._Tgender='2';$$._Tnumber='2';$$._Tdirection='2';}

                            }
        |   NOUNP SPACE {
                            $$._Ttranslation=$1._Tvalue;
                            $$._Tvalue=$1._Tvalue;
                            $$._Tgender=$1._Tgender;
                            $$._Tnumber='1';
                            $$._Tdirection='2';
                            }
        |   NOUNP SPACE 'w' SPACE NOUNP SPACE {
                            $$._Ttranslation = concat2Strs(concat2Strs($1._Tvalue," et "),$5._Tvalue);
                            $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue," w "),$5._Tvalue);
                            $$._Tgender='2';
                            $$._Tnumber='2';
                            $$._Tdirection='2';
                            }
        |   NOUN SPACE {
                            $$._Ttranslation=$1._Ttranslation;
                            $$._Tvalue=$1._Tvalue;
                            $$._Tgender=$1._Tgender;
                            $$._Tnumber='1';
                            $$._Tdirection='2';
                            }
        |   NOUN SPACE 'w' SPACE NOUN SPACE {
                            $$._Ttranslation = concat2Strs(concat2Strs($1._Ttranslation," et "),$5._Ttranslation);
                            $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue," w "),$5._Tvalue);
                            $$._Tgender='2';
                            $$._Tnumber='2';
                            $$._Tdirection='2';
                            }
        ;
verb:       VERBE SPACE VERBE SPACE {
                            displayVerb($1._Tvalue,$1._Ttranslation,$1._Tgender,$1._Tdirection,$1._Tnumber,$1._Ttime,"Non");
                            displayVerb($3._Tvalue,$3._Ttranslation,$3._Tgender,$3._Tdirection,$3._Tnumber,$3._Ttime,"Non");
                            if(!(!isGendersOk($1._Tgender,$3._Tgender) && !isNumbersOk($1._Tnumber,$3._Tnumber) && !isDirectionsOk($1._Tdirection,$3._Tdirection) && !isTimesOk($1._Ttime,$3._Ttime))){
                                if(isGendersOk($1._Tgender,$3._Tgender))
                                    yyerror("les deux verbes doivent avoir le meme genre");
                                if(isTimesOk($1._Ttime,$3._Ttime))
                                    yyerror("les deux verbes doivent avoir le meme temps");
                                if(isDirectionsOk($1._Tdirection,$3._Tdirection))
                                    yyerror("les deux verbes n'ont pas la meme structure des relations de personne");
                                if(isNumbersOk($1._Tnumber,$3._Tnumber))
                                    yyerror("les deux verbes doivent de refairer au meme nombre");
                            }else{
                                $$._Ttranslation = concat2Strs(concat2Strs($1._Ttranslation," "),$3._Ttranslation);
                                $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue," "),$3._Tvalue);
                                $$._Tgender=$1._Tgender;
                                $$._Tnumber=$1._Tnumber;
                                $$._Tdirection=$1._Tdirection;
                                $$._Ttime=$1._Ttime;
                            }
                               

                            }
        |   NEGATION VERBE SPACE VERBE SPACE {
                            displayVerb($2._Tvalue,$2._Ttranslation,$2._Tgender,$2._Tdirection,$2._Tnumber,$2._Ttime,"Oui");
                            displayVerb($4._Tvalue,$4._Ttranslation,$4._Tgender,$4._Tdirection,$4._Tnumber,$4._Ttime,"Non");
                            if(!(!isGendersOk($2._Tgender,$4._Tgender) && !isNumbersOk($2._Tnumber,$4._Tnumber) && !isDirectionsOk($2._Tdirection,$4._Tdirection) && !isTimesOk($2._Ttime,$4._Ttime))){
                                if(isGendersOk($2._Tgender,$4._Tgender))
                                    yyerror("les deux verbes doivent avoir le meme genre");
                                if(isTimesOk($2._Ttime,$4._Ttime))
                                    yyerror("les deux verbes doivent avoir le meme temps");
                                if(isDirectionsOk($2._Tdirection,$4._Tdirection))
                                    yyerror("les deux verbes n'ont pas la meme structure des relations de personne");
                                if(isNumbersOk($2._Tnumber,$4._Tnumber))
                                    yyerror("les deux verbes doivent de refairer au meme nombre");
                            }else{
                                $$._Ttranslation = concat2Strs(concat2Strs($2._Ttranslation," "),$4._Ttranslation);
                                $$._Ttranslation = concat2Strs("n'est pas ",$$._Ttranslation);
                                $$._Tvalue = concat2Strs(concat2Strs($2._Tvalue," "),$4._Tvalue);
                                $$._Tgender=$2._Tgender;
                                $$._Tnumber=$2._Tnumber;
                                $$._Tdirection=$2._Tdirection;
                                $$._Ttime=$2._Ttime;
                            }
                               

                            }
        |   VERBE SPACE {
                            displayVerb($$._Tvalue,$$._Ttranslation,$$._Tgender,$$._Tdirection,$$._Tnumber,$$._Ttime,"Non");
                            $$._Ttranslation=$1._Ttranslation;
                            $$._Tvalue=$1._Tvalue;
                            $$._Tgender=$1._Tgender;
                            $$._Tnumber=$1._Tnumber;
                            $$._Tdirection=$1._Tdirection;
                            $$._Ttime=$1._Ttime;
                            }
        |   NEGATION VERBE SPACE {
                            displayVerb($2._Tvalue,$2._Ttranslation,$2._Tgender,$2._Tdirection,$2._Tnumber,$2._Ttime,"Oui");
                            $$._Ttranslation = concat2Strs("ne pas ",$2._Ttranslation);
                            $$._Tvalue=$2._Tvalue;
                            $$._Tgender=$2._Tgender;
                            $$._Tnumber=$2._Tnumber;
                            $$._Tdirection=$2._Tdirection;
                            $$._Ttime=$2._Ttime;
                            }
	    ;
description:    ADJ SPACE{
                            displayAdjectif($1._Tvalue,$1._Ttranslation,$1._Tgender,"Non");
                            $$._Ttranslation = concat2Strs("(etre) ",$1._Ttranslation);
                            $$._Tvalue=$1._Tvalue;
                            $$._Tgender=$1._Tgender;
                            }
        |   NEGATION ADJ SPACE{
                            displayAdjectif($2._Tvalue,$2._Ttranslation,$2._Tgender,"Oui");
                            $$._Ttranslation = concat2Strs("ne (etre) pas ",$2._Ttranslation);
                            $$._Tvalue=$2._Tvalue;
                            $$._Tgender=$2._Tgender;
                            }
        ;
complement: sujet {$$._Ttime=USELESS;}
        |   sujet ADJ SPACE {
                            displaySubject($1._Tvalue,$1._Ttranslation,$1._Tgender,$1._Tnumber,$1._Tdirection);
                            if( isGendersOk($1._Tgender , $2._Tgender) )
                                yyerror("le Sujet et la description dans le complement doivent avoir le meme genre");
                            $$._Ttranslation = concat2Strs(concat2Strs($1._Ttranslation, " "),$2._Ttranslation);
                            $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue, " "),$2._Tvalue);
                            $$._Tgender=USELESS;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime=USELESS;
                            }
        |sujet ADV SPACE {
                            displaySubject($1._Tvalue,$1._Ttranslation,$1._Tgender,$1._Tnumber,$1._Tdirection);
                            $$._Ttranslation = concat2Strs(concat2Strs($1._Ttranslation, " "),$2._Ttranslation);
                            $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue, " "),$2._Tvalue);
                            $$._Tgender=USELESS;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime=USELESS;
                            }
        |   ADV SPACE {
                            $$._Ttranslation = $1._Ttranslation;
                            $$._Tvalue = $1._Tvalue;
                            $$._Tgender=USELESS;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime=USELESS;
                        }
        |   ADV SPACE ADV SPACE {
                            $$._Ttranslation = concat2Strs(concat2Strs($1._Ttranslation," "),$3._Ttranslation);
                            $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue," "),$3._Tvalue);
                            $$._Tgender=USELESS;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime=USELESS;
                            }
        |   description ADV SPACE {
                            $$._Ttranslation = concat2Strs(concat2Strs($1._Ttranslation," "),$2._Ttranslation);
                            $$._Tvalue = concat2Strs(concat2Strs($1._Tvalue," "),$2._Tvalue);
                            $$._Tgender=$1._Tgender;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime='0';
                            }
        |   'l' SPACE NOUN SPACE {
                            $$._Ttranslation = concat2Strs("a ",$3._Ttranslation);
                            $$._Tvalue = concat2Strs("avec ",$3._Tvalue);
                            $$._Tgender=USELESS;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime=USELESS;
                            }
        |   'f' SPACE NOUN SPACE {
                            $$._Ttranslation = concat2Strs("dans ",$3._Ttranslation);
                            $$._Tvalue = concat2Strs("avec ",$3._Tvalue);
                            $$._Tgender=USELESS;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime=USELESS;
                            }
        |   'm' '3' 'a' SPACE NOUNP SPACE{
                            $$._Ttranslation = concat2Strs("avec ",$5._Tvalue);
                            $$._Tvalue = concat2Strs("avec ",$5._Tvalue);
                            $$._Tgender=USELESS;
                            $$._Tnumber=USELESS;
                            $$._Tdirection=USELESS;
                            $$._Ttime=USELESS;
                            }
        ;

EOL   :   '.'
        | '?';
SPACE :  ' ' | '\t' ;
%%
void yyerror(char *s){
    fprintf(stderr, "\t\x1B[31mError | Line: %d\n\t\t%s\x1B[0m\n",yylineno,s);
    thereIsError=1;
}
int isGendersOk(char gender1,char gender2){
    if ((gender1==FEMALE && gender2==MALE) || (gender1==MALE && gender2==FEMALE))
        return 1;
    else
        return 0;
}
int isDirectionsOk(char direction1,char direction2){
    if (direction1 != direction2)
        return 1;
    else
        return 0;
}
int isNumbersOk(char number1,char number2){
    if (number1 != number2)
        return 1;
    else
        return 0;
}
int isTimesOk(char time1,char time2){
    if (time1 != time2)
        return 1;
    else
        return 0;
}
void displayVerb(char *value,char *translation,char gender,char direction,char number,char time,char *negation){
    number=(number=='2')? 'P' : 'S';
    direction++;
    drapeau && printf("\t\x1B[34mVerb:\x1B[0m AR>>>%s   FR>>>%s   Genre(0:M|1:F|2:U)>%c   personne(1|2|3)>>>%c\n\t\tNombre(S:singulier|P:pluriel)>>>%c   Temps(Present:0|Past:1|Future:2)>>>%c   Negatif>>>%s\n\n",value,translation,gender,direction,number,time,negation);
}
void displayAdjectif(char *value,char *translation,char gender,char *negation){
    drapeau && printf("\t\x1B[34mAdjectif:\x1B[0m AR>>>%s   FR>>>%s   Genre(0:M|1:F)>%c   Negatif>>>%s\n\n",value,translation,gender,negation);
}
void displaySubject(char *value,char *translation,char gender,char number,char direction){
    number=(number=='2')? 'P' : 'S';
    direction++;
    drapeau && printf("\t\x1B[34mSubject:\x1B[0m AR>>>%s   FR>>>%s   Genre(0:M|1:F|2:U)>%c   \n\t\tNombre(S:singulier|P:pluriel)>>>%c   personne(1|2|3)>>>%c\n\n",value,translation,gender,number,direction);
}
void displayComplement(char *value,char *translation,char gender,char number,char direction){
    number=(number=='2')? 'P' : 'S';
    direction++;
    drapeau && printf("\t\x1B[34mComplement:\x1B[0m AR>>>%s   FR>>>%s   Genre(0:M|1:F|2:U)>%c   \n\t\tNombre(S:singulier|P:pluriel)>>>%c   personne(1|2|3)>>>%c\n\n",value,translation,gender,number,direction);
}
void toBeFree(){
    for(int i=1;i<=(int)pointersToFree[0];i++)
        free(pointersToFree[i]);
    pointersToFree[0]=0;
}
void fetchWords(Liste* head,FILE* fp){
    ch60 element;
    char *pos;
    while(fgets(element, sizeof(element), fp) != NULL){
        if ((pos=strchr(element, '\n')) != NULL)
            *pos = '\0';
        int index = (int)(strchr(element, ':') - element);
        element[index]='\0';
        insererEnTeteDeListe(head,cree_mot(element,&(element[index+1])));
    }
}
char * concat2Strs(char *str1,char *str2){
    char* buffer=malloc(sizeof(char)*(strlen(str1)+strlen(str2))+1);
    sprintf(buffer,"%s%s",str1,str2);
    addToBeFree(buffer);
    return buffer;
}
char* afficheVerb(char temps, char direction, char number){
    char* buffer;
    if(temps=='1')          buffer=concat2Strs("","Present|");
    else                    buffer=concat2Strs("","Past|");

    if(direction=='0')      buffer=concat2Strs(buffer,"1Personne|");
    else{
        if(direction=='1')  buffer=concat2Strs(buffer,"2Personne|");
        else                buffer=concat2Strs(buffer,"3Personne|");
    }

    if(number=='1')         buffer=concat2Strs(buffer,"Singulier");
    else                    buffer=concat2Strs(buffer,"Pluriel");

    return buffer;
}
void addToBeFree(char* chunk){
    pointersToFree[(int)(pointersToFree[0])+1]=chunk;
    pointersToFree[0]+=1;
}
void drawLine(){
    printf("\n\x1B[33m");
    printf("\n");
    for(int i=0;i<100;i++)
        printf("*");
    printf("\n");
    printf("\x1B[0m\n");
}
int main(int argc,char* argv[]){
    extern FILE* yyin;
    if(argc<2){
        printf("Vous devez passer au moin le fichier a traduire !!!\n");
        return -1;
    }
    if(argc>3){
        printf("vous avez passee des parametres inconnu :%d\n",argc);
        return -1;
    }
    if(argc==3){
        if(strcmp(argv[2],"-d")==0){
            drapeau=1;
        }else{
            printf("parametre inconnu '%s'.\n",argv[2]);
            return -1;
        }
    }
    yyin=fopen(argv[1],"r");
    if(yyin==NULL){
        printf("le fichier en question est inexistant !!!\n");
        return -1;
    }
    pointersToFree[0]=0;
    char* fresources[NBRF]={"./ressources/dictionary/verbs.txt",
            "./ressources/dictionary/nounsM.txt",
            "./ressources/dictionary/nounsF.txt",
            "./ressources/dictionary/nomPM.txt",
            "./ressources/dictionary/nomPF.txt",
            "./ressources/dictionary/adverbes.txt",
            "./ressources/dictionary/adjectives.txt"
            };

    for(int i=0;i<NBRF;i++){
        FILE* resource=fopen(fresources[i],"r");
        if(!resource){
            printf("WHERE ARE MY FILES!!!\n");
            printf("Error %d \n", errno);
            return -1;
        }
        dictio[i]=(Liste*)malloc(sizeof(Liste));
        dictio[i]=creerListe(0,ecrire_mot,comparer_mot);
        fetchWords(dictio[i],resource);
        fclose(resource);
    }
    drawLine();
    yyparse();
    return 0;
}