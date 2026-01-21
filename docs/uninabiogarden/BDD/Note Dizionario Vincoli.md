
## Dizionario dei Vincoli
### Vincoli Attività

#### Stato Iniziale e Finale
- **Stato Iniziale**: un attività appena creata deve essere nello stato PIANIFICATA
- **Stato Finale**: se lo stato diventa COMPLETATA o ANNULLATA ogni attributo non può essere più modificato. 
#### Regole di Transizione
| Stato Originale | Stato Destinazione |
| :-------------- | :----------------- |
| **-**           | PIANIFICATA        |
| PIANIFICATA     | IN_CORSO           |
| PIANIFICATA     | ANNULLATA          |
| IN_CORSO        | COMPLETATA         |
| IN_CORSO        | ANNULLATA          |
| COMPLETATA      | **-**              |
| ANNULLATA       | **-**              |

#### Coerenza Temporale delle Date
- `data_pianificazione`: non può essere modificata dopo la creazione dell'attività.
- `data_inizio_prevista`: non può essere modificata se la data di inizio è diversa da NULL. Deve valere che `data_inizio_prevista >= data_pianificazione`.
- `data_inizio`: `NULL` finché l'attività non viene spostata nello stato IN_CORSO, dopodiché diventa immutabile. Deve valere che: `data_inizio >= data_pianificazione`.
- `data_fine`: `NULL` finché l'attività non viene spostata nello stato `COMPLETATA`, dopodiché diventa immutabile. Deve valere che: `data_fine >= data_inizio`
### Vincoli Coltivazione
#### Stato Iniziale e Finale
- **Stato Iniziale**: una coltivazione appena creata deve avere `stato_salute = OTTIMO` e `stato_coltivazione = PIANIFICATA`.
- **Stato Finale**:  se lo stato diventa **TERMINATA** o **FALLITA**  o **ANNULLATA**:
	- **Congelamento Attributi**: ogni attributo della coltivazione non può essere più modificato. 
	- **Annullamento Attività Rimanenti**: lo stato di tutte le attività che sono in uno stato diverso da **COMPLETATA** e **ANNULLATA** deve essere impostato ad **ANNULLATA**.
	- **Fine Attività**: non è possibile pianificare ulteriori attività sulla coltivazione.

	**Nota x.1.1**: Quando una coltivazione entra in uno dei suoi stati finali **tutte** le sue attività sono ***congelate***: lo stato di tutte le attività associate alla coltivazione, che non sono in uno stato terminale, diventa **ANNULLATO** e, per definizione dello stato finale di una attività, queste diventano immutabili. Inoltre alla coltivazione stessa non sarà più possibile associare nuove attività. 
#### Regole di Transizione: `stato_coltivazione` 

| Stato Originale | Stato Destinazione | Condizione                                                                |
| --------------- | ------------------ | ------------------------------------------------------------------------- |
| -               | PIANIFICATA        |                                                                           |
| PIANIFICATA     | IN_CORSO           | Ha almeno un'attività associata che è nello stato **IN_CORSO**            |
| PIANIFICATA     | ANNULLATA          |                                                                           |
| IN_CORSO        | TERMINATA          | solo se esiste una attività **Raccolta** che è nello stato **COMPLETATA** |
| IN_CORSO        | FALLITA            | lo stato di salute della coltivazione è **COMPROMESSO**                   |
| ANNULLATA       | **-**              |                                                                           |
| TERMINATA       | **-**              |                                                                           |
| FALLITA         | **-**              |                                                                           |

#### Regole di Transizione: `stato_salute` 

| Stato Originale                      | Stato Destinazione                                | Condizione                                                                                             |
| ------------------------------------ | ------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| -                                    | OTTIMO                                            |                                                                                                        |
| OTTIMO, STABILE, SOFFERENTE, CRITICO | OTTIMO, STABILE, SOFFERENTE, CRITICO, COMPROMESSO | La coltivazione deve trovarsi nello stato **IN_CORSO** per poter modificare il proprio stato di salute |
| COMPROMESSO                          | **-**                                             |                                                                                                        |
**Nota x.2.1**: Lo stato `COMPROMESSO` è uno stato pozzo per la salute: una volta raggiunto, la transizione verso `FALLITA` è immediata e irreversibile. Si nota inoltre che una coltivazione può *fallire* solo se lo stato della coltivazione è **IN_CORSO** e il suo stato di salute diventa **COMPROMESSO**. Una coltivazione può essere *annullata* se non è ancora *in corso*.

### Vincoli del Progetto
#### Stato Iniziale e Finale
- **Stato Iniziale**: 
- **Stato Finale**:

#### Regole di Transizione
#### Coerenza Temporale delle Date


- **Attivazione Automatica:** Se lo stato del progetto è **PIANIFICATO** e almeno una delle sue coltivazioni passa allo stato **IN_CORSO** (ovvero la prima semina è stata completata), allora lo stato del progetto deve passare automaticamente a **ATTIVO**.
    
- **Chiusura Vincolata:** Un progetto può passare allo stato **CONCLUSO** solo se tutte le coltivazioni associate sono in stato **TERMINATA** o **FALLITA**.
    
- **Irreversibilità:** 
	- Un progetto **ATTIVO** non può passare allo stato **PIANIFICATO**.
    - Un progetto **CONCLUSO** non può passare allo stato **ATTIVO** o **PIANIFICATO**.
        
- **Inibizione Inserimento Attività:** Una volta che un progetto termina (stato = **CONCLUSO** o **FALLITO**), non deve essere più possibile associare delle coltivazioni.

- **Immutabilità della data di creazione**: La data di creazione di un progetto non può essere modificata successivamente alla creazione del progetto.
- **Immutabilità della data di inizio**: La data di inizio del progetto non può essere modificata una volta che il progetto passa allo stato ATTIVO. La data di inizio deve essere successiva alla data di creazione.
- **Vincolo della data di fine progetto**: La data di fine di un progetto deve essere inserita soltanto durante il passaggio di stato del progetto da ATTIVO a CONCLUSO. Deve essere successiva alla data di inizio.





#### 4. Vincoli di Unicità e Sequenza Coltivazione - Attività

- **Post-Terminazione della Coltivazione:** Una coltivazione in stato **TERMINATA** o **FALLITA** non può avere nuove attività pianificate.
    
- **Immutabilità Attività:** Un'attività nello stato **ANNULLATA** o **COMPLETATA** non può più modificare il suo stato.
    
- **Vincolo di Unicità Semina/Raccolta:** Data una coltivazione, non può essere inserita un'attività di semina (raccolta) se già esiste un'attività di semina (raccolta) in uno stato diverso da **ANNULLATA**.
    
- **Vincolo di Sequenza:** Non si può iniziare l'attività di **Raccolta** se l'attività di **Semina** non è in stato **COMPLETATA**.

- **Vincolo Quantità Effettiva a Raccolta ANNULLATA**: se una Raccolta è ANNULLATA allora la quantità effettiva deve essere 0.

#### 5. Vincoli sulle date delle attività
Devono valere i seguenti vincoli sulle date di inizio e fine delle attività.

1. `Data Creazione Progetto < Data Inizio Progetto < Data Fine Progetto`
2. `Data Inizio Semina < Data Fine Semina < Data Inizio Raccolta < Data Fine Raccolta`
3. data una coltivazione Y e un attività X che è associata a Y:
`Data Fine Semina Y​ <= Data Inizio Attività XY​ < Data Fine Attività XY​ <= Data Inizio RaccoltaY​`
4. la data di inizio del progetto deve essere >= alla data di terminazione della prima semina che passa allo stato COMPLETATA
5. la data di fine del progetto deve essere >= alla data di terminazione dell'ultima raccolta che passa allo stato COMPLETATA

data di registrazione di un orto, di un lotto, la data di pianificazione di una attività e la data di creazione di una coltivazione possono essere inseriti solo durante l'inserimento di tali entità e non possono essere successivamente modificate

(vincolo): il progetto può occupare solo uno dei lotti del proprietario che lo ha pianificato.   
Tra questi lotti, solo i lotti che attualmente (nella data odierna) non ospitano nessun progetto in corso:  stato_progetto == PIANIFICATO o ATTIVO.

#### Ricezione Notifiche
- **Vincolo di Coerenza Stato-Data:**
    - Se `is_letta` è **FALSE**, allora `data_presa_visione` deve essere **NULL**.
    - Se `is_letta` è **TRUE**, allora `data_presa_visione` deve essere **NOT NULL**.
- **Vincolo di Ordine Temporale:**
    - `data_presa_visione` >= `data_invio_notifica`.
Questo impedisce paradossi temporali dove una notifica risulta letta prima ancora di essere stata inviata.
- **Vincolo di Integrità (Update):**
    - Una volta che `is_letta` passa a **TRUE**, non può più tornare a **FALSE** (il coltivatore non può "non leggere" qualcosa che ha già visto).

#### Vincoli ristrutturato

**Utente -- Proprietario**
Un utente può possedere un lotto solo se Utente.tipo == PROPRIETARIO
Un utente può gestire un orto solo se Utente.tipo == PROPRIETARIO
Un utente può inviare una notifica solo se Utente.tipo == PROPRIETARIO
Un utente può pianificare un progetto solo se Utente.tipo == PROPRIETARIO

**Utente -- Coltivatore**
Un utente può svolgere un attività solo se Utente.tipo == COLTIVATORE
Un utente può ricevere una notifica solo se Utente.tipo == COLTIVATORE

ALTRI VINCOLI DEL RISTRUTTURATO DA FARE DOPO LA RISTRUTTURAZIONE