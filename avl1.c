#include "avl1.h"





int max(int a,int b){		// fonction qui renvoie le max, prend 2 paramètres
	if(a>b){
		return a;
	}
	else{
		return b;
	}
}
int min(int a,int b,int c){	// fonction qui renvoie le min, prend 3 paramètres
	if(a>c && b>c){
		return c;
	}
	else if(a>b && c>b){
		return b;
	}
	else if(b>a && c>a){
		return a;
	}
}

int min1(int a,int b){		// fonction qui renvoie le min, prend 2 paramètres
	if(a>b){
		return b;
	}
	else{
		return a;
	}
}

int max1(int a,int b,int c){	// fonction qui renvoie le max, prend 3 paramètres
	if(a>b && a>c){
		return a;
	}
	else if(b>a && b>c){
		return b;
	}
	else if(c>a && c>b){
		return c;
	}
}

PArbre creerArbre(int x){
				//fonction qui créer et renvoie un noeud
	PArbre element = malloc(sizeof(Arbre));
	if(element==NULL){
		exit(1);
	}
	element->elmt = x;
	element->valeur = 0;
	element->fg = NULL;
	element->fd = NULL;
	element->suivant = NULL;
	element->equilibre = 0;
	return element;
}

 PArbre rotationGauche(PArbre A) {			//permet de faire une rotation gauche pour équilibrer l'arbre
	PArbre B = A->fd;
	int a = A->equilibre;
	int b = B->equilibre;
	A->fd = B->fg;			
	B->fg = A;
	A->equilibre = a - max(b, 0) - 1;
	B->equilibre = min(a - 2, a + b -2, b - 1);
	return B;
}


PArbre rotationDroite(PArbre A) {			//permet de faire une rotation droite pour équilibrer l'arbre
	PArbre B = A->fg;
	int a = A->equilibre;
	int b = B->equilibre;
	A->fg = B->fd;			
	B->fd = A;
	A->equilibre = a - min1(b, 0) + 1;
	B->equilibre = max1(a + 2, a + b + 2, b + 1);
	return B;
}


PArbre doubleRotationGauche(PArbre A) {			//permet de faire une double rotation gauche pour équilibrer l'arbre
	A->fd = rotationDroite(A->fd);
	return rotationGauche(A);
}


PArbre doubleRotationDroite(PArbre A) {				//permet de faire une double rotation droite pour équilibrer l'arbre
	A->fg = rotationGauche(A->fg);
	return rotationDroite(A);
}

PArbre equilibrerAVL(PArbre A) {				//permet d'equilibrer L'avl
	if (A->equilibre == 2)
		if (A->fd->equilibre >= 0)
			return rotationGauche(A);
		else
			return doubleRotationGauche(A);
	else
		if (A->equilibre == -2)
			if (A->fg->equilibre <= 0)
				return rotationDroite(A);
			else
				return doubleRotationDroite(A);
	return A;
}


PArbre ajoutAVL(PArbre A, int x, int *h) {
	if (A == NULL) {
		*h = 1;
		return creerArbre(x);
	}
	if (x > A->elmt)							
		A->fd = ajoutAVL(A->fd, x, h);
	else if (x < A->elmt) {
		A->fg = ajoutAVL(A->fg, x, h);
		*h = -*h;
	} else { 
		*h = 0;
		return A;
	}
	if (*h != 0) { 
		A->equilibre = A->equilibre + *h;
		A = equilibrerAVL(A);
		if (A->equilibre == 0)
			*h = 0;
		else
			*h = 1;
	}
	return A;
}

PArbre ajouterAVL(PArbre A, int x) {				
	int h = 0;		
	return ajoutAVL(A, x, &h);
}


PArbre suppMinAVL(PArbre A, int *h, int *pe) {
	PArbre tmp;
	if (A->fg == NULL) {
		*pe = A->elmt;
		*h = -1;
		tmp = A->fd;
		free(A);
		return tmp;
	} else {
		A->fg = suppMinAVL(A->fg, h, pe);
		*h = -*h;
	}
	if (*h != 0) { 
		A->equilibre = A->equilibre + *h;
		A = equilibrerAVL(A);
		if (A->equilibre == 0)
			*h = -1;
		else
			*h = 0;
	}
	return A;
}

PArbre creer_chainon(PArbre A, int b){                   // creation de la liste chainée
	PArbre element = malloc(sizeof(Arbre));
	if(element==NULL){
		exit(1);				
	}
	element->suivant = NULL;
	element->valeur = b;
	return element;
}


	
PArbre ajout_deuxieme_valeur(PArbre A,int a,int b){	// creer la liste chainee à l'aide de la fonction creer_chainon
	if(A==NULL){		
		return creer_chainon(A, b);
	}
	
	if( A->valeur == 0){
		A->valeur =b;
		
		return A;
	}
	else{
		A->suivant = ajout_deuxieme_valeur(A->suivant,a,b);  
		
	}
} 

PArbre suppAVL(PArbre A, int x, int *h) {
	PArbre tmp;
	
	int e = 0;
	if (A == NULL) {
		*h = 1;
		return A;
	}
	if (x > A->elmt)
		A->fd = suppAVL(A->fd, x, h);
	else if (x < A->elmt) {
		A->fg = suppAVL(A->fg, x, h);
		*h = -*h;
	} else if (A->fg == NULL) {
		tmp = A->fd;
		free(A);
		*h = -1;
		return tmp;
	} else if (A->fd == NULL) {
		tmp = A->fg;
		free(A);
		*h = -1;
		return tmp;
	} else {
		A->fd = suppMinAVL(A->fd, h, &e);
		A->elmt = e;
	}
	if (*h != 0) { 
		A->equilibre = A->equilibre + *h;
		A = equilibrerAVL(A);
		if (A->equilibre == 0)
			*h = -1;
		else
			*h = 0;
	}
	return A;
}

PArbre supprimerAVL(PArbre A, int x) {
	int h = 0;				// permet de supprimer les noeuds de l'avl grace a la fonction suppAVL ET suppMinAVL
	return suppAVL(A, x, &h);
}

void traiter(PArbre A){
	if(A!=NULL){
		printf("%d" ,A->elmt);		// permet de voir la valeur  de voir la valeur de l'arbre
		while(A->suivant!=NULL){	
			printf("%d",A->valeur);  //permet de voir les valeurs de la liste chainée
			A=A->suivant;
			
		}
		
	}
}	

void parcours_infixe(PArbre A){
	if(A!=NULL){
		parcours_infixe(A->fg);			//Grâce au parcours infixe, je pensais pouvoir mettre sur différents fichiers les différentes valeurs triés 
		traiter(A);
		parcours_infixe(A->fd);
	}
}


int recherche(PArbre a, int e){
	if (a == NULL){				// fonction qui permet de savoir si un element est present dans l'avl, renvoie 1 si oui 0 sinon
		return 0;
	}
	else if(a->elmt == e){
		return 1;
	}
	else if(e< a->elmt){
		return recherche(a->fg,e);
	}
	else{
		return recherche(a->fd,e);
	}
}


PArbre recherche2(PArbre A,int a,int b){                        //cette fonction permet de se placer au noeud où on souhaite insérer un élement à la liste  chainée
	if(A->elmt!=a){
	
		while(A->elmt!=a){
			if(a< A->elmt){
				return ajout_deuxieme_valeur(A->fg,a,b);
			}
			else{
				 return ajout_deuxieme_valeur(A->fd,a,b);
			}
			
		}
	
	}
	
	if(A->elmt == a){
		return A;
	}
}
