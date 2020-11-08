%option noyywrap
%option yylineno

%array
%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <ctype.h>
    #include "tanya.tab.h"
    #include "Tflex.h"
%}
%%
((ma).*(x)) {  char dest[strlen(yytext)-2];
            strcpy(dest, &(yytext[2]));
            dest[strlen(dest)-1]='\0';
            for(int i=(strlen(dest)-1);i>=0;--i){
                unput(dest[i]);
            }return NEGATION;
            }

kan[^ \t\n.]+ {     Mot* verbe=verbe=exist(&(lowerString(yytext)[3]),dictio[0]);
                    if(verbe){
                        sendVerbe(verbe->key,verbe->value,PRESENT,MALE_FEMALE,SINGULAR,PREMIEREP);
                        return VERBE;
                    }else    REJECT;
                }

kat[^ \t\n.]+ {     Mot* verbe=exist(&(lowerString(yytext)[3]),dictio[0]);
                        if(verbe){
                            sendVerbe(verbe->key,verbe->value,PRESENT,MALE_FEMALE,SINGULAR,DEUXIEMEP);
                            return VERBE;
                        }else    REJECT;
                }

kat[^ \t\n.]+i {    char dest[strlen(yytext)+1];
                        strcpy(dest, yytext);
                        dest[strlen(dest)-1]='\0';
                        Mot* verbe=exist(&(lowerString(dest)[3]),dictio[0]);
                        if(verbe){
                            sendVerbe(verbe->key,verbe->value,PRESENT,FEMALE,SINGULAR,DEUXIEMEP);
                            return VERBE;
                        }else    REJECT;
                }

kan[^ \t\n.]+u { char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* verbe=exist(&(lowerString(dest)[3]),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PRESENT,MALE_FEMALE,PLURAL,PREMIEREP);
                    return VERBE;
                }else    REJECT;}
kat[^ \t\n.]+u { char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* verbe=exist(&(lowerString(dest)[3]),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PRESENT,MALE_FEMALE,PLURAL,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
kay[^ \t\n.]+u { 
            char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* verbe=exist(&(lowerString(dest)[3]),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PRESENT,MALE_FEMALE,PLURAL,TROISIEMEP);
                    return VERBE;
                }else    REJECT;}
kay[^ \t\n.]+ {     Mot* verbe=exist(&(lowerString(yytext)[3]),dictio[0]);
                        if(verbe){
                            sendVerbe(verbe->key,verbe->value,PRESENT,MALE_FEMALE,SINGULAR,TROISIEMEP);
                            return VERBE;
                        }else    REJECT;
                }
[^ \t\n.]+ti {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+at {   
            char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,FEMALE,SINGULAR,TROISIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+na {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,PREMIEREP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+tu {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+t {    char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
            if(verbe){
                for(int i=1;i<strlen(dest);i++){
                    if(dest[i]=='a'){
                        sendVerbe(verbe->key,verbe->value,PAST,FEMALE,SINGULAR,TROISIEMEP);
                        return VERBE;
                    }
                }
                sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR,PREMIEREP);
                return VERBE;
            }
            else    REJECT;}
[^ \t\n.]+u {    char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,TROISIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}it {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR,PREMIEREP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}iti {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-3]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}at {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,FEMALE,SINGULAR,TROISIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}ina {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-3]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,PREMIEREP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}itu {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-3]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}u {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,TROISIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+it {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            dest[strlen(yytext)-2]='a';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR,PREMIEREP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+iti {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            dest[strlen(yytext)-3]='a';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+ina {   
    char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            dest[strlen(yytext)-3]='a';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL, PREMIEREP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+itu {   char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-2]='\0';
            dest[strlen(yytext)-3]='a';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+w {    char dest[strlen(yytext)+1];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,TROISIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}t {    char dest[strlen(yytext)+1];
            dest[0]=yytext[0];
            dest[1]='a';
            dest[2]=yytext[1];
            dest[3]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR,PREMIEREP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}ti {    char dest[strlen(yytext)+1];
            dest[0]=yytext[0];
            dest[1]='a';
            dest[2]=yytext[1];
            dest[3]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,SINGULAR, DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}na {    char dest[strlen(yytext)+1];
            dest[0]=yytext[0];
            dest[1]='a';
            dest[2]=yytext[1];
            dest[3]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,PREMIEREP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]{2}tu {    char dest[strlen(yytext)+1];
            dest[0]=yytext[0];
            dest[1]='a';
            dest[2]=yytext[1];
            dest[3]='\0';
            Mot* verbe=exist(lowerString(dest),dictio[0]);
                if(verbe){
                    sendVerbe(verbe->key,verbe->value,PAST,MALE_FEMALE,PLURAL,DEUXIEMEP);
                    return VERBE;
                }else    REJECT;}
[^ \t\n.]+  {
            for(int i=0;i<NBRF;i++){
                Mot* what=exist(lowerString(yytext),dictio[i]);
                if(what){
                    switch(i) {
                        case 0 :{
                            sendVerbe(what->key,what->value,PAST,MALE,SINGULAR,TROISIEMEP);
                            return VERBE;
                        }case 1 :{
                            sendName(what->key,what->value,'0','5');
                            return NOUN;
                        }case 2 :{
                            sendName(what->key,what->value,'1','5');
                            return NOUN;
                        }case 3 :{
                            sendNameP(what->key,'0');
                            return NOUNP;
                        }case 4 :{
                            sendNameP(what->key,'1');
                            return NOUNP;
                        }case 5 :{
                            sendAdv(what->key,what->value);
                            return ADV;
                        }case 6 :{
                            sendAdj(what->key,what->value,'0');
                            return ADJ;
                        }
                    }
                }
            }REJECT;
        }
[^ \t\n.]+a {    char dest[strlen(yytext)];
            strcpy(dest, yytext);
            dest[strlen(dest)-1]='\0';
            Mot* adj=exist(lowerString(dest),dictio[6]);
                if(adj){
                    sendAdj(adj->key,adj->value,'1');
                    return ADJ;
                }else    REJECT;}

"ana"   {sendPronoun(yytext,"je","moi",MALE_FEMALE,SINGULAR,PREMIEREP);          return PRONOUN;}
"nta"   {sendPronoun(yytext,"tu","toi",MALE,SINGULAR,DEUXIEMEP);          return PRONOUN;}
"nti"   {sendPronoun(yytext,"tu","toi",FEMALE,SINGULAR,DEUXIEMEP);          return PRONOUN;}
"huwa"  {sendPronoun(yytext,"il","lui",MALE,SINGULAR,TROISIEMEP);          return PRONOUN;}
"hiya"  {sendPronoun(yytext,"elle","elle",FEMALE,SINGULAR,TROISIEMEP);        return PRONOUN;}
"7na"   {sendPronoun(yytext,"nous","nous",MALE_FEMALE,PLURAL,PREMIEREP);        return PRONOUN;}
"ntuma" {sendPronoun(yytext,"vous","vous",MALE_FEMALE,PLURAL,DEUXIEMEP);        return PRONOUN;}
"huma"  {sendPronoun(yytext,"ils/elles","eux",MALE_FEMALE,PLURAL,TROISIEMEP);    return PRONOUN;}
"wax"   {sendQuestion(yytext,"est-ce-que");       return QUESTION;}
"fin"   {sendQuestion(yytext,"ou-est-ce-que");    return QUESTION;}
"fu9ax" {sendQuestion(yytext,"quand-est-ce-que"); return QUESTION;}
"\r"    {}
"\n"    {}
.       {return yytext[0];}
%%
char* lowerString(char* str){
    for(int i = 0; str[i]; i++)
        str[i] = tolower(str[i]);
    return str;
}
void* exist(char* id,Liste* head){
    return chercherUnObjet(head,cree_mot(id,"XXX"));
}
void sendVerbe(char* value,char* translation,char time,char gender,char number,char direction){
    yylval._Sverbe._Tvalue=strdup(value);
    addToBeFree(yylval._Sverbe._Tvalue);
    yylval._Sverbe._Ttranslation=translation;
    yylval._Sverbe._Tgender=gender;
    yylval._Sverbe._Tnumber=number;
    yylval._Sverbe._Tdirection=direction;
    yylval._Sverbe._Ttime=time;
    drapeau && printf("verbe sent %s\n",yylval._Sverbe._Tvalue);
}
void sendName(char* value,char* translation,char gender,char number){
    yylval._Snoun._Tvalue=strdup(value);
    addToBeFree(yylval._Snoun._Tvalue);
    yylval._Snoun._Ttranslation=translation;
    yylval._Snoun._Tgender=gender;
    yylval._Snoun._Tnumber=number;
   drapeau && printf("noun sent %s\n",yylval._Snoun._Tvalue);
}
void sendNameP(char* value,char gender){
    yylval._SnounP._Tvalue=strdup(value);
    addToBeFree(yylval._SnounP._Tvalue);
    yylval._SnounP._Tgender=gender;
   drapeau && printf("nounP sent %s\n",yylval._SnounP._Tvalue);
}
void sendAdv(char* value,char* translation){
    yylval._Sadv._Tvalue=strdup(value);
    addToBeFree(yylval._Sadv._Tvalue);
    yylval._Sadv._Ttranslation=translation;
  drapeau &&  printf("adverbe sent %s\n",yylval._Sadv._Tvalue);
}
void sendAdj(char* value,char* translation,char gender){
    yylval._Sadj._Tvalue=strdup(value);
    addToBeFree(yylval._Sadj._Tvalue);
    yylval._Sadj._Ttranslation=translation;
    yylval._Sadj._Tgender=gender;
  drapeau && printf("adjective sent %s\n",yylval._Sadj._Tvalue);
}
void sendPronoun(char* value,char* translation,char* translation2,char gender,char number,char direction){
    yylval._Spronoun._Tvalue=strdup(value);
    addToBeFree(yylval._Spronoun._Tvalue);
    yylval._Spronoun._Ttranslation=translation;
    yylval._Spronoun._Ttranslation2=translation2;
    yylval._Spronoun._Tgender=gender;
    yylval._Spronoun._Tnumber=number;
    yylval._Spronoun._Tdirection=direction;
    drapeau && printf("pronoun sent %s\n",yylval._Spronoun._Tvalue);
}
void sendQuestion(char* value,char* translation){
    yylval._Squestion._Tvalue=strdup(value);
    addToBeFree(yylval._Squestion._Tvalue);
    yylval._Squestion._Ttranslation=translation;
    drapeau && printf("question sent %s\n",yylval._Squestion._Tvalue);
}