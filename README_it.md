# parametri di lancio
Ricordarsi di mettere nelle opzioni di lancio:
-	Run &rarr; Debug Configurations...
-	(Left Tab) Java Application &rarr; LoadAssMainApp 
-	(Right Tab)  Arguments &rarr; VM Arguments

	--module-path "c:\Program Files\Java\javafx-sdk-21.0.1\lib" --add-modules javafx.swing,javafx.graphics,javafx.fxml,javafx.media,javafx.web 

# loadaass
Programma che viene utilizzato per caricare le bollette di luce, acqua e gas dalle fatture emesse dalla società di servizi sammarinese AASS (Azienda Autonoma di Stato per i Servizi di San Marino)

Le fatture **devono** essere in formato PDF, inoltre **non e' supportato** il formato PDF di fatture scannerizzate.
Assunto che le fatture siano quelle emesse dalla AASS, questo programma le traduce prima in HTML e poi analizza il risultato HTML per scoprire tutti i campi.

Le regole per la scoperta dei campi sono memorizzate nel file delle proprietà chiamato:
1.  FattEE_HTML.properties
2.  FattGAS_HTML.properties
3.  FattH2O_HTML.properties

where:

 - EE sta' per  (Energia Elettrica)
 - GAS sta' per GAS
 - H2O sta' per acqua

Qui un estratto come esempio di questi files di *properties*
  
		# Tipologia di documento, frase identificativa del doc corretto
		IdDoc=Servizio Energia Elettrica
		FileNameId=DataEmiss
		FilePrefix=EE
		# - - - - - - - - - - - X - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		#                                         Fattura n.   2023/1044418
		#                                       Data Emissione   02/08/2023
		tag01=FattNr:Fattura n:br:e:1
		tag02=DataEmiss:Data Emissione:d:-:-
		# - - - - - - - - - - - X - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
		# E-MAIL       info@aass.sm        Totale da Pagare         73,82 \u20ac
		# SITO WEB     www.aass.sm            Data Scadenza    17/08/2023
		tag03=TotPagare:Totale da Pagare:cy:b:2
		tag04=dtScad:Data Scadenza:d:-:-
		etc ...

# Prima maschera

![First page of application LoadAASS](https://i.imgur.com/3tily36.png "Prima pagina")



