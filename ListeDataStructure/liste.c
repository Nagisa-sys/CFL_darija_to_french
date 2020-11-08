#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "liste.h"
#define NBRF  3

Liste*  creerListe (int type, char* (*afficher) (Objet*), int (*comparer) (Objet*, Objet*) ){
    Liste* li=(Liste*)malloc(sizeof(Liste));
    initListe (li,0, afficher, comparer);
    return li;
}
void initListe (Liste* li, int type, char* (*afficher) (Objet*), int (*comparer) (Objet*, Objet*) ){
    li->type=type;
    li->afficher=afficher;
    li->comparer=comparer;
    li->courant=NULL;
    li->premier=NULL;
    li->dernier=NULL;
    li->nbElt=0;
}
int nbElement (Liste* li){
    return (li->nbElt);
}
int  listeVide (Liste* li){
    return ( (li->nbElt) ==0);
}
Element* creeElement(){
    Element* el=(Element*)malloc(sizeof(Element));
    return el;
}
void insererEnTeteDeListe  (Liste* li, Objet* objet){
    Element* el=creeElement();
    el->reference=objet;
    el->suivant=li->premier;
    li->premier=el;
    if(listeVide(li))
        li->dernier=el;
    li->nbElt++;
}
void insererEnFinDeListe (Liste* li, Objet* objet){
    if(listeVide(li)){
        insererEnTeteDeListe  (li,objet);
        return;
    }
    Element* el=creeElement();
    el->reference=objet;
    el->suivant=NULL;
    li->dernier->suivant=el;
    li->dernier=el;
    li->nbElt++;
}
static void extraire_apres(Liste* li,Element* precedent)
{
    if(precedent==NULL)
    {
        extraireEnTeteDeListe(li);
        return;
    }
    precedent->suivant=precedent->suivant->suivant;
    li->nbElt--;
    if(precedent->suivant==NULL)
        li->dernier=precedent;
}
Objet*  extraireEnTeteDeListe  (Liste* li){
    Element* retirer=li->premier;
    if( retirer != NULL ){
        li->premier=li->premier->suivant;
        if(retirer == li->dernier)
            li->dernier=NULL;
        (li->nbElt) -- ;
    }
    return retirer != NULL ? retirer->reference : NULL;
}
Objet* extraireEnFinDeListe (Liste* li){
    Element* a_retirer=li->dernier;
    Element* temp=li->premier;
    if(listeVide(li))
        return NULL;
    if(li->premier==li->dernier)
        return extraireEnTeteDeListe(li);
    while(temp->suivant->suivant!=NULL)
        temp=temp->suivant;
    extraire_apres(li,temp);
    return a_retirer->reference;
}
int  extraireUnObjet (Liste* li, Objet* objet){
    if(listeVide(li))
        return 0;
    int total=li->nbElt;
    Element* temp=li->premier;
    while(temp->suivant!=NULL){
        if(!li->comparer(temp->suivant->reference,objet))
            extraire_apres(li,temp);
        else
            temp=temp->suivant;
    }
    if(!li->comparer(li->premier->reference,objet))
        extraireEnTeteDeListe(li);
    return (total - (li->nbElt));
}
void listerListe (Liste* li){
    Element* tempo=li->premier;
    while(tempo != NULL){
        printf("%s ",li->afficher(tempo->reference));
        tempo = tempo -> suivant;
    }
}
Objet* chercherUnObjet (Liste* li, Objet* objetCherche){
    Element* tempo=li->premier;
    while(tempo != NULL){
        if((li->comparer(objetCherche,tempo->reference)) == 0)
                return tempo->reference;
        tempo=tempo->suivant;
    }
    return NULL;
}
void detruireListe (Liste* li){
    if(!listeVide(li)){
        Element* temp=li->premier;
        Element* tempp=temp->suivant;
        while(temp->suivant!=NULL){
            free(temp);
            temp=tempp;
            tempp=temp->suivant;
        }
        free(temp);
        initListe (li,li->type,li->afficher,li->comparer);
    }
}
