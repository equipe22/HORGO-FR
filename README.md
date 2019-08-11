# HORGO-FR
Hospital organizational structure in France - an ontology-based temporal database

## Folder description
This code is organized as follows:
* exploration: contains R script and SQL queries for data analysis.
* mapping: contains SQL/PLGSQL scripts used to extract data from data sources and feed the ontology-based temporal schema (OTS).
* ontology: contains the ontology of Hospital organizational structure in France.
* ots: scripts to build the ontology-based temporal schema and OntoRelDic the schema dictionary in JSON format.

The organizational structure data are not available for confidentialiy reasons.
However, you can import our own data by replacing the files in extraction and mapping folders.
Please don't hesitate to contact us for more information.

## Tools
The tools:
* Protégé for the ontology visualization.
* PostgreSQL database for SQL scripts exectuion.
* RStudio for data analysis.

## User Guide
Create a database in your PostgreSQL database.
Bash scripts are created to automate OTS creation and mapping execution.
Replace the database= parameter by your database name in all Bash scripts.

1. Run the OTS creation process ots/build.sh
2. Run the mapping process mapping/build.sh
3. Run mapping tests mapping/test.sh

If needed use ots/clean.sh or mapping/clean.sh to drop database elements

# Authors
* Christina Khnaisser: Christina.Khnaisser@etu.parisdescartes.fr <br>
* Vincent Looten: Vincent.Looten@aphp.fr

# Links
* The Organization Ontology: https://www.w3.org/TR/vocab-org/
* Agence technique de l’information sur l’hospitalisation. Autorisations des unités médicales: https://www.atih.sante.fr/nomenclatures-de-recueil-de-l-information/autorisations-des-unites-medicales
* Ministère du travail, de l’emploi et de la santé. Guide méthodologique de comptabilité analytique hospitalière: https://solidarites-sante.gouv.fr/IMG/pdf/GUIDE_CAH___BOS_2011-3.pdf

# License
...
