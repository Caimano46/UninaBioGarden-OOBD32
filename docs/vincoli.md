#### Tipologia Terreno

- **ARGILLOSO**: Terreno pesante, trattiene molta acqua ma è difficile da lavorare quando è secco.
- **SABBIOSO**: Terreno leggero, drena molto velocemente e richiede irrigazioni frequenti.
- **LIMOSO**: Una via di mezzo, fertile ma tende a compattarsi facilmente.
- **MEDIO_IMPASTO**: Il terreno ideale, un equilibrio bilanciato tra sabbia, limo e argilla.
- **GESSOSO**: Terreno con alto contenuto di calcio, tipico di alcune zone collinari.
- **TORBOSO**: Ricco di sostanza organica, tipico di zone umide o ex-palustri.

#### Stato Progetto

Preparazione, attivo, concluso, fallito
(precisazione): un progetto puo essere considerato

- IN_CORSO se stato_progetto = PREPARAZIONE OR ATTIVO
- TERMINATO se stato_progetto = CONCLUSO OR FALLITO
  (vincolo): un progetto terminato non puo puo tornare ad essere in corso
  (vincolo): un progetto concluso o fallito deve avere una data di fine
  (vincolo): data_fine non puo essere cambiata una volta settata
  (vincolo): data_inizio e data_scadenza non possono essere modificate in seguito

#### Stato Salute

- **OTTIMO**: La pianta è rigogliosa e non presenta alcun segno di stress.
- **BUONO**: Sviluppo normale, senza problemi evidenti ma con margini di miglioramento.
- **SOFFERENTE**: Presenza di stress idrico o carenza di nutrienti (es. foglie ingiallite).
- **MALATO**: Presenza di infezioni fungine, batteriche o virali.
- **INFESTATO**: Presenza attiva di parassiti o insetti (collegabile all'entità "Anomalia" della traccia)
- **MORTO**: La coltivazione è persa e deve essere rimossa dal progetto.

#### Why lotto e orto

Per il lotto ho deciso di isolare l'orto come un entita a se stante
Questo per due motivi:

- permettere ad un proprietario di possedere un orto oltre che a un singolo lotto
- ridurre la duplicazione dei dati: se ci sono 100 lotti allo stesso indirizzo e allo stesso orto per ogni lotto si duplicano indirizzo e nome orto

Alcuni vincoli:

- (precisazione) un proprietario puo possedere un lotto in un orto che non possiede
- (molteplicita) un lotto deve essere localizzato in un orto registrato. Se l orto in cui si desidera registrare il lotto non e registrato allora si deve prima registrare l orto e poi aggiungere il lotto
  vincolo (raccolta): la quantita effettiva puo essere settata soltanto quando lo stato della attivita e concluso o fallito. Se lo stato e fallito, la quantita effettiva deve essere 0

#### Why Coltivazione

la coltivazione come entita era diventata troppo grande, aveva troppi atributi. Cosi l ho resa un entita a se stante che viene identificata dal

progetto e dalla coltura. Questo porta e una migliore divisione delle responsabilita: un attivita non e piu associata ad una coltura generale ma direttamente con la coltivazione. Intolre se un progetto ha piu di una coltura, si possono distingure le attitivita in base alla coltivazione perche ce una relazione diretta
