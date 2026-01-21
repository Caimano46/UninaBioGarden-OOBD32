#### Gerarchia delle attività
**Approccio scelto**: Table per Entity
I vantaggi di questa ristrutturazione è che favorisce la ricerca di attività in maniera globale e solo nel caso in cui si debbano recuperare informazioni specifiche vi è bisogno di una JOIN. 
Gli altri approcci avevo i seguenti svantaggi:
- Table per Hierarchy: troppi sottotipi con troppi attributi, si finiva con l'avere una mega tabella dove la maggior parte degli attributi sarebbe stata NULL. Aveva tuttavia il vantaggio di una ricerca globale veloce e rendeva inutile usare le join perché tutti i dati erano nella singola tabella. Questa potrebbe essere l'alternativa più opportuna all'approccio scelto se si sceglie di sporcare le righe della tabella con tanti NULL. 
- Table per Sub-Entity: Quest'approccio è semplicemente sconveniente siccome rende difficili le ricerche globali delle attività e inoltre duplica per ogni sottotipo tutti gli attributi della superclasse Attività che sono tanti.

#### Gerarchia Notifica
**Approccio scelto**: Table per Hierarchy
Siccome Notifica ha solo un sottotipo e per di più questo ha soltanto un attributo, si è ritenuto non necessario aggiungere complessità inutile e avere un unica entità con un discriminante `TipoNotifica`.

#### Relazioni ridondanti
- **prevede** tra progetto e attività: `progetto (comprende)--> coltivazione (eseguita_su) --> attivita`
- **lavora_su** tra lotto e coltivatore: `coltivatore (lavora_per)--> progetto (occupa)--> lotto`
- **si_svolge_su** tra coltivazione e lotto: `coltivazione (comprende)--> progetto (occupa)--> lotto`

#### Introduzione Chiavi Surrogate

**Entità deboli**:
- **`id_lotto`**: essendo una entità debole si ripresenta il problema di avere una chiave primaria composta, troppo lunga e pesante. 
- **`id_coltivazione`**: per alleggerire la chiave primaria di coltivazione che, essendo un entità debole, sarebbe composta da `id_progetto + id_coltura`. 
- **`id_attivita`**:  siccome attività è debole ed identificata da coltivazione, la sua chiave primaria risulterebbe essere troppo pesante e scomoda quando un'attività è in relazione con altre entità come con coltivatore o con la notifica: `id_coltivazione + titolo + data_inizio`. Il numero di attività memorizzate potrebbe essere elevato e un attività è un target comune per le query. 
- **`id_notifica`**: PK senza id sarebbe `id_progetto + data_invio`. Come per l'attività il problema principale risiede nel numero di entità che si prevedono esistere per una Notifica. La chiave primaria deve essere leggera.


- **`id_progetto`**: Si prevede che il sistema potrebbe memorizzare un grande numero di progetti tra quelli attualmente pianificati e attivi e quelli già completati. Pertanto non ci si può basare su una stringa potenzialmente lunga per l'identificazione univoca.
- **`id_utente`**: come per `id_progetto` si ritiene necessario l'introduzione di una chiave surrogata per l'utente in previsione del numero di utenti che il sistema potrebbe memorizzare. Un utente inoltre può essere il target di numerose query.  

Per coltura rimane `nome_comune` la chiave primaria, siccome nel database la tabella delle colture non dovrebbe crescere notevolmente come le altre e rimanere relativamente piccola. Quindi anche se la chiave primaria è una stringa e può essere relativamente lunga, per il basso numero di entità previsto, si decide di non introdurre un id. 
Lo stesso ragionamento lo si applica a orto: non si prevede un grande numero di orti e inoltre orto non dovrebbe essere un entità di cui si richiedono spesso le informazioni. Una semplice chiave primaria come `nome_orto` continuerebbe a funzionare senza evidenti problemi di performance. 