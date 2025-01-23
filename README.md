# Sommaire
- [Sommaire](#sommaire)
- [Introduction](#introduction)
- [Pré-requis](#pré-requis)
  - [Pour lancer le backend en local](#pour-lancer-le-backend-en-local)
  - [Pour faire un docker Image](#pour-faire-un-docker-image)
- [Lancement](#lancement)
  - [Sans Docker](#sans-docker)
  - [Avec Docker](#avec-docker)

# Introduction
Backend pour le projet Morningnews

La commande pour bien avoir un fichier `.env`:  
- `cp .env.example .env` 

Il est important d'avoir une valeur attribuée à `NEWS_API_KEY` ainsi que `CONNECTION_STRING` dans le fichier .env avant de commencer.

# Pré-requis 
- Un token API de [NewsAPI.org](https://newsapi.org/)
- Le Connection String d'une base de donnée MongoDB (par exemple, [MongoDB Atlas](https://www.mongodb.com/atlas))
## Pour lancer le backend en local
- [Nodejs](https://nodejs.org/en/download) v16 minimum

## Pour faire un docker Image
- [Docker Engine](https://docs.docker.com/engine/install/)

# Lancement
## Sans Docker
```
npm install
npm start &
```
Le backend est disponible sur le lien suivant : http://localhost:3000

## Avec Docker
```
docker build -t *tagname* --no-cache --build-arg url=*CONNECTION_STRING* --build-arg token=*NEWSTOKEN* .
docker run --name morningnews_backend *tagname* -p 3000:3000 
```
Le backend est disponible sur le lien suivant : http://localhost:3000
