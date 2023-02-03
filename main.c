#include "avl1.h"


int main(int argc, char **argv){
	PArbre p1 = NULL;
	PArbre p2 = NULL;
	PArbre p3 = NULL;
	FILE* fichier = NULL;
	
	fichier = fopen(argv[1],"r");
	char c1[200];
	
	while(fgets(c1, 199, fichier) != NULL ){
		 if(c1[0]== '\n'){
		 	;						//permet de savoir si une liste est vide liste est vide
		}
		else{
			if(recherche(p1,atoi(c1))==1){
				;					//permet de remplir l'avl avec des valeurs uniques
			}
			else{
				
				p1 = ajouterAVL(p1,atoi(c1));		// on remplit l'avl avec des valeurs uniques
			}
		}
	}
	
	rewind(fichier);
	
	
	p3 = p1;
	FILE* fichier1 = NULL;
	fichier1 = fopen(argv[1],"r");
	char c2[200];
	
	FILE* fichier2 = NULL;
	fichier2 = fopen(argv[2],"r");
	char c3[200];	
	while(fgets(c2,199,fichier1)!=NULL && fgets(c3,199,fichier2)!=NULL){	//dans cette partie, on va remplir la liste chainée 
		if(c2[0] == '\n'){
			;							//permet de savoir si une liste est vide ou non
		}
		else{
			p2 = recherche2(p1,atoi(c2),atoi(c3));			// p2 recoit 
			p3 = ajout_deuxieme_valeur(p2,atoi(c2),atoi(c3));
		}
	
	}
	parcours_infixe(p1);

	return 0;
}

