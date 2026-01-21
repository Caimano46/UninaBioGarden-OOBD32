
---
title: "Documentazione BDD"
header-includes:
   - \usepackage{float}
   - \makeatletter
   - \setkeys{Gin}{width=\linewidth,height=\textheight,keepaspectratio}
   - \floatplacement{figure}{H}
   - \makeatother
---
# Documentazione Progetto: Sistema Gestione Agricola
**Data:** 21 Gennaio 2026  
**Autori:** [Tuo Nome] & [Nome Collega]

---

## 1. Analisi del Dominio
*Descrizione sintetica del contesto: gestione di orti, lotti e cicli colturali con tracciamento delle attività e sistema di notifiche.*

## 2. Modellazione Dati
todo

\newpage
### 2.1 Schema Concettuale (EER)
Versione EER dello schema concettuale.


![Schema EER](../asset/eer-bdd.svg){ width=100% }

\newpage
### 2.2 Schema Concettuale (UML)
Questa è la versione UML del precedente schema.


![Schema UML](../asset/uml-bdd.svg){ width=100% }


\newpage
### 2.3 Schema Ristrutturato (UML)
*Descrizione delle scelte di ristrutturazione (es. accorpamento gerarchie, eliminazione attributi composti).*



![Schema UML](../asset/uml-ristrutturato-bdd.svg){ width=100% }


\newpage
### 2.3 Schema Logico
*Convenzione: Tutte le PK sono `id`, le FK seguono il formato `id_entita`.*

![Schema UML](../asset/logico-bdd.svg){ width=100% }


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

##### Nota
Quando una coltivazione entra in uno dei suoi stati finali **tutte** le sue attività sono ***congelate***: lo stato di tutte le attività associate alla coltivazione, che non sono in uno stato terminale, diventa **ANNULLATO** e, per definizione dello stato finale di una attività, queste diventano immutabili. Inoltre alla coltivazione stessa non sarà più possibile associare nuove attività. 
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
##### Nota
Lo stato `COMPROMESSO` è un _sink state_ (stato pozzo) per la salute: una volta raggiunto, la transizione verso `FALLITA` è immediata e irreversibile. Si nota inoltre che una coltivazione può *fallire* solo se lo stato della coltivazione è **IN_CORSO** e il suo stato di salute diventa **COMPROMESSO**. Se una coltivazione può essere *annullata* se non è ancora *in corso*.

## 4. Dizionario degli Attributi

DA FARE

| Entità | Attributo | Tipo | Descrizione |
| :--- | :--- | :--- | :--- |
| **Progetto** | `stato` | ENUM | {PIANIFICATO, ATTIVO, CONCLUSO} |
| **Attività** | `tipo` | VARCHAR | Es: 'Semina', 'Irrigazione', 'Raccolta' |
| **Lettura** | `is_letta` | BOOLEAN | Flag di visualizzazione notifica |

---