#include <stdio.h>
#include <stdlib.h>


typedef struct Arbre{		// structure pour creer un noeud de l'avl
	int elmt;		// valeur du noeud de l'avl
	int valeur;		// valeur de la liste chainée
	int equilibre;
	struct Arbre* suivant;	// pointeur qui pointe vers l'élément suivant de la liste chainéé
	struct Arbre* fg;	// le pointeur qui pointe vers le  fils gauche de l'avl
	struct Arbre* fd;	//le  pointeur qui pointe vers fils droit del'avl

}Arbre;

typedef Arbre* PArbre;	

PArbre rotationGauche(PArbre A );
PArbre rotationDroite(PArbre A );
PArbre doubleRotationGauche(PArbre A );
PArbre doubleRotationDroite(PArbre A );
PArbre equilibrerAVL(PArbre A );
PArbre ajoutAVL(PArbre A , int x , int *h);
PArbre ajouterAVL(PArbre A, int x);
PArbre suppMinAVL(PArbre A, int *h, int *pe);
PArbre suppAVL(PArbre A , int x , int *h);
PArbre supprimerAVL(PArbre A , int x );
PArbre recherche2(PArbre A,int a,int b);
PArbre ajout_deuxieme_valeur(PArbre A,int a,int b);
void parcours_infixe(PArbre a);	
int recherche(PArbre A,int e);
PArbre creer_chainon(PArbre A, int b);
