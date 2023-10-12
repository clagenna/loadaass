# loadaass
upload electricity, water and gas bills from invoices issued by the service company of San Marino AASS (Azienda Autonoma dei Servizi di San Marino)

Invoices are in PDF format so this program first translate them in HTML and then parses the HTML result to discover all fields.

Rule for discovering fields are store in properties file called:

1.  FattEE_HTML.properties
2.  FattGAS_HTML.properties
3.  FattH2O_HTML.properties

where:

 - EE stands for (Energia Elettrica)
 - GAS stands for it self
 - H2O stands for water

Here is an excerpt from those files: 
  
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

# First aspect

![First page of application LoadAASS](https://imgur.com/a/S7ZB7Se "Prima pagina")



