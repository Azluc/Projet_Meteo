#!/bin/bash

gcc avl1.o main.o -o myExec




Help() {
	echo '-f nom_du_fichier pour récuperer le nom du fichier à traiter'
	echo '-d min:max pour déterminer l intervalle des dates dans lequel le tri est effectué en format YYYY-MM-DD'
	echo '-p 1 ou 2 ou 3 en fonction de l option souhaiter pour le tri. L option 1 tri les données minimales, maximales et moyennes en fonctionde du numéro de la station. L option 2 tri les pressions moyennes en fonctions de la date et de l heure. L option 3 permet le tri pour une valeur unique de chaque station par heure.'
	echo '-t 1 ou 2 ou 3 en fonction de l option souhaiter pour le tri. L option 1 tri les données minimales, maximales et moyennes en fonctionde du numéro de la station. L option 2 tri les températures moyennes en fonctions de la date et de l heure. L option 3 permet le tri pour une valeur unique de chaque station par heure.'
	echo '-w correspond au tri et l affichage d une carte avec les vecteurs en flèches.'
	echo '-h est un tri et affiche en fonction de la longitude et latitude les stations et utilise des couleurs pour les différencier par rapport à leur hauteur.'
	echo '-m fait le le tri et l affichage sur une carte avec la longitude et latitude de l humidité.'
	echo '-F(G,A,S,O,Q) est une option unique on ne peut pas en utiliser 2 simultanement. Elles spécifient la zone géographique étudiée.'
	
}




sed -i 1d meteo_filtered_data_v1.csv #retire les entetes



while getopts "f:ht:wp:mFGSAOQd:" option #recherche d'option
do
	case $option in

		d) # On vérifie l'option pour le temps et on récupère l'intervalle
		  minmax=(${OPTARG//:/}); min=${minmax[o]}; max=${minmax[1]} ;; 
		  #on récupère les dates encadrantes

		f) #On récupère le nom du fichier 
	  	  fich=$OPTARG ;;

		p) #Vérification si l'option pour la pression et on récupère quel mode
	  	  p_mode=$OPTARG ;;

		t) #Vérification si l'option pour la température et on récupère quel mode
	  	  t_mode=$OPTARG ;;

		w) #Vérification si l'option pour le vent
	  	  w=1 ;;

		h) #Vérification si l'option pour l'altitude
	  	  h=1 ;;

		m) #Vérification si l'option pour l'humidité
	  	  m=1 ;;

		#Vérification si l'option pour la localisation

		F) 
	  	  F=1 ;;

		G)
	  	  G=1 ;;

		S)
	  	  S=1 ;;

		A)
	  	  A=1 ;;

		O)
	  	  O=1 ;;

		Q)
	  	  Q=1 ;;
	       
	       \?) 
	          Help 
	          exit ;;
	esac
done



if [ F -eq 1 ] && [ G -eq 1 ] 
#chaque if est une vérification si on utilise une seule localisation
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ F -eq 1 ] && [ S -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ F -eq 1 ] && [ A -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ F -eq 1 ] && [ Q -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ F -eq 1 ] && [ O -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit

elif [ F -eq 1 ]
then 
	awk -F\; '$15 >= 0 && $15 <= 96000'fich>meteoF.csv 
	#on cherche les lignes correspondantes en comparant les codes de communes
	fich=meteoF.csv 
	#on associe le nom du nouveau fichier à traiter
fi





if [ F -eq 1 ] && [ G -eq 1 ] 
#chaque if est une vérification si on utilise une seule localisation
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ G -eq 1 ] && [ S -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ G -eq 1 ] && [ A -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ G -eq 1 ] && [ Q -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ G -eq 1 ] && [ O -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit

elif [ G -eq 1 ]
then 
	awk -F\; '$15 >= 97300 && $15 < 97400'fich>meteoG.csv 
	#on cherche les lignes correspondantes en comparant les codes de communes
	fich=meteoG.csv 
	#on associe le nom du nouveau fichier à traiter
fi





if [ S -eq 1 ] && [ F -eq 1 ] 
#chaque if est une vérification si on utilise une seule localisation
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ S -eq 1 ] && [ F -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ S -eq 1 ] && [ A -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ S -eq 1 ] && [ Q -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ S -eq 1 ] && [ O -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit

elif [ S -eq 1 ]
then 
	awk -F\; '$15 >= 97500 && $15 <= 97600'fich>meteoS.csv 
	#on cherche les lignes correspondantes en comparant les codes de communes
	fich=meteoS.csv 
	#on associe le nom du nouveau fichier à traiter
fi





if [ A -eq 1 ] && [ G -eq 1 ] 
#chaque if est une vérification si on utilise une seule localisation
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ A -eq 1 ] && [ S -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ A -eq 1 ] && [ F -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ A -eq 1 ] && [ Q -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ A -eq 1 ] && [ O -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit

elif [ A -eq 1 ]
then 
	awk -F\; '$15 >= 97100 && $15 <= 97300'fich>meteoA.csv 
	#on cherche les lignes correspondantes en comparant les codes de communes
	fich=meteoA.csv 
	#on associe le nom du nouveau fichier à traiter
fi





if [ O -eq 1 ] && [ G -eq 1 ] 
#chaque if est une vérification si on utilise une seule localisation
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ O -eq 1 ] && [ S -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ O -eq 1 ] && [ A -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ O -eq 1 ] && [ Q -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ O -eq 1 ] && [ F -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit

elif [ O -eq 1 ]
then 
	awk -F\; '$15 >= 97400 && $15 <= 97500'fich>meteoO.csv 
	awk -F\; '$15 >= 97600 && $15 <= 97700'fich>>meteoO.csv
	#on cherche les lignes correspondantes en comparant les codes de communes
	fich=meteoO.csv 
	#on associe le nom du nouveau fichier à traiter
fi





if [ Q -eq 1 ] && [ G -eq 1 ] 
#chaque if est une vérification si on utilise une seule localisation
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ Q -eq 1 ] && [ S -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ Q -eq 1 ] && [ F -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ Q -eq 1 ] && [ A -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit
	
elif [ Q -eq 1 ] && [ O -eq 1 ]
then 
	echo "Vous ne pouvez pas utilier deux localisations différentes"
	Help
	exit

elif [ Q -eq 1 ]
then 
	awk -F\; '$15 == "" {print}'fich>meteoQ.csv 
	#on cherche les lignes correspondantes en comparant les codes de communes
	fich=meteoQ.csv 
	#on associe le nom du nouveau fichier à traiter
fi



#On récupère l'année, le mois et le jour du min et du max pour vérifier la validité
yearmin=${min:0:4} 
yearmax=${max:0:4}
monthmin=${min:5:2}
monthmax=${max:5:2}
daymin=${min:8:2}
daymax=${max:8:2}



if ! [[ $min =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] || [[ $max =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]
# Vérifie si la date comporte une année en 4 chiffres, un mois en 2 chiffres et un jour en 2 chiffres
then 
	echo "Utilisation du mauvais format; utiliser le format suivant YYYY-MM-DD"
	Help
	exit
	
	
elif [[ $monthmin -lt 1 || $monthmax -lt 1 || $monthmin -gt 12 || $monthmax -gt 12 || $daymin -lt 1 || $daymax -lt 1 || $daymin -gt 31 || $daymax -gt 31 ]] # Vérifie la validité du mois et des jours
then
	echo "La date n'est pas valide. Veuillez réessayer"
	Help
	exit
	
	
elif [[ $monthmin == 2 && $daymin -gt 29 ]] 
#Vérifie la validité au mois de février
then
	echo "La date n'est pas valide. Veuillez réessayer"
	Help
	exit


elif [[ $monthmmax == 2 && $daymax -gt 29 ]] 
#Vérifie la validité au mois de février
then
	echo "La date n'est pas valide. Veuillez réessayer"
	Help
	exit


elif [[ $monthmin == 4 || $monthmin == 6 || $monthmin == 9 || monthmin == 11 ]] && [[ $daymin -gt 30 ]]
# Vérifie pour les mois en 30 jours
then
	echo "La date n'est pas valide. Veuillez réessayer"
	Help
	exit


elif [[ $monthmax == 4 || $monthmax == 6 || $monthmax == 9 || monthmin == 11 ]] && [[ $daymax -gt 30 ]]
then
	echo "La date n'est pas valide. Veuillez réessayer"
	Help
	exit
	
else 
	awk -F\; '$2 >= min && $2 <= max'fich>fich2.csv 
	# On regarde si la date se situe dans l'intervalle donné
	fich=fich2.csv
fi





if [ $p_mode -eq 1 ] #1er mode pour la pression
then 
	cut -f1,2,3,7,8 -d";" fich>press.txt 
	./myExec -fpress.txt 
elif [ $p_mode -eq 2 ] #2eme mode pour la pression
then
	cut -f1,2,3,7 -d";" fich>press.txt
	./myExec -fpress.txt 
elif [ $p_mode -eq 3 ] #3eme mode pour la pression
then
	cut -f1,2,7 -d";" fich>press.txt
	./myExec -fpress.txt 
fi






if [ $t_mode -eq 1 ] #1er mode pour la température
then 
	cut -f1,2,11,12,13 -d";" fich>temp.txt 
	 #température minimales, moyennes et maximales
	./myExec -ftemp.txt 
	
elif [ $t_mode -eq 2 ] #2eme mode pour la température
then
	cut -f1,2,12,13 -d";" fich>temp.txt
	./myExec -ftemp.txt 
	
elif [ $t_mode -eq 3 ] #3eme mode pour la température
then
	cut -f1,2,11 -d";" fich>temp.txt
	./myExec -ftemp.txt 
fi



		
		
if [ w -eq 1 ] #Effectue le tri pour le vent 
then 
	cut -f1,2,4,5 -d";" fich>vent.txt
	./myExec -fvent.txt
fi




if [ h -eq 1 ] #Effectue le tri pour l'altitude
then 
	cut -f1,2,14 -d";" fich>alt.txt
	./myExec -falt.txt
fi
	
	
	
	
	
if [ m -eq 1 ] #Effectue le tri pour l'humidité
then 
	cut -f1,2,14 -d";" fich>humi.txt
	./myExec -fhumi.txt
fi







