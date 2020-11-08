typedef char ch60 [61] ;
typedef char ch30 [31] ;
typedef void Objet;

typedef struct{
    ch30 key;
    ch30 value;
}Mot;

Mot* cree_mot (char* key,char* value);
char* ecrire_mot (Objet* objet);
int comparer_mot (Objet* objet1, Objet* objet2);
