#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "words.h"

Mot* cree_mot (char* key,char* value){
    Mot* p=(Mot*)malloc(sizeof(Mot));
    strcpy(p->key,key);
    strcpy(p->value,value);
    return p;
}
char* ecrire_mot (Objet* objet){
    Mot* p=(Mot*)objet;
    char* out=(char*)malloc(sizeof(Mot)+2*sizeof(char));
    snprintf(out,sizeof(Mot)+6*sizeof(char),"%s => %s \n",p->key,p->value);
    return out;
}
int comparer_mot (Objet* objet1,Objet* objet2){
    Mot* p1=(Mot*)objet1;
    Mot* p2=(Mot*)objet2;
    return strcmp(p1->key,p2->key);
}

