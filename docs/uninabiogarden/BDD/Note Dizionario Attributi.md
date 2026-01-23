#### Tipologia Terreno
- **ARGILLOSO**: Terreno pesante, trattiene molta acqua ma è difficile da lavorare quando è secco.
- **SABBIOSO**: Terreno leggero, drena molto velocemente e richiede irrigazioni frequenti.
- **LIMOSO**: Una via di mezzo, fertile ma tende a compattarsi facilmente.
- **MEDIO_IMPASTO**: Il terreno ideale, un equilibrio bilanciato tra sabbia, limo e argilla.
- **GESSOSO**: Terreno con alto contenuto di calcio, tipico di alcune zone collinari.
- **TORBOSO**: Ricco di sostanza organica, tipico di zone umide o ex-palustri.

#### Stato Salute (da aggiornare)
- **OTTIMO**: La pianta è rigogliosa e non presenta alcun segno di stress.
- **BUONO**: Sviluppo normale, senza problemi evidenti ma con margini di miglioramento.
- **SOFFERENTE**: Presenza di stress idrico o carenza di nutrienti (es. foglie ingiallite).
- **MALATO**: Presenza di infezioni fungine, batteriche o virali.
- **INFESTATO**: Presenza attiva di parassiti o insetti (collegabile all'entità "Anomalia" della traccia)
- **MORTO**: La coltivazione è persa e deve essere rimossa dal progetto.



#### 1. Stati del Progetto

- **PIANIFICATO** (Invece di PREPARAZIONE): Indica che il progetto esiste ma è ancora in fase di definizione.
    
- **ATTIVO**: Il progetto è ufficialmente aperto. Si possono iniziare le coltivazioni.
    
- **CONCLUSO**: Terminato con successo.
    
- **FALLITO**: Terminato negativamente (es. abbandono del progetto).
    

#### 2. Stati della Coltivazione

- **PIANIFICATA**: La pianta è assegnata a un lotto, ma non è ancora stato fatto nulla.
    
- **ATTIVA** (Invece di IN_CORSO): La coltivazione è iniziata (es. è stata seminata o preparata).
    
- **CONCLUSA**: Ciclo biologico concluso con la raccolta.
    
- **FALLITA**: La pianta è morta o compromessa.
    
- **ANNULLATA**: Rimossa per scelta gestionale.
    

#### 3. Stati dell'Attività

- **PIANIFICATA**: L'attività è nel calendario.
    
- **IN_CORSO** (Unica eccezione): Qui "In Corso" è più preciso di "Attiva" perché descrive un'azione fisica puntuale che si sta svolgendo _ora_. Tuttavia, se vuoi la simmetria totale, puoi usare **ATTIVA**, ma "In Corso" è lo standard de facto per i task.
    
- **COMPLETATA**: Lavoro eseguito con successo.
    
- **ANNULLATA**: Lavoro non più necessario.


## Orto
- `nome_orto` deve essere almeno lungo due caratteri per evitare nomi vuoti
- `id_proprietario` deve essere inserito durante la creazione dell'orto e non deve essere più modificato.