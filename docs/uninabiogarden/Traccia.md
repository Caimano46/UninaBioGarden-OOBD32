2.1.1 Descrizione del dominio
UninaBioGarden è una piattaforma per la gestione collaborativa di orti urbani. Gli utenti possono
registrarsi come proprietari di lotti di terreno coltivabile o come coltivatori. Ogni lotto può ospitare una
o più colture (es. pomodori, insalata, erbe aromatiche), ciascuna con un tempo di maturazione
specifico. Al termine del periodo di maturazione, è necessario pianificare una raccolta, specificando la
quantità prevista. Gli utenti coltivatori possono essere assegnati a uno o più lotti nell’ambito di progetti
di coltivazione stagionali, svolgendo diverse attività come semina, irrigazione o raccolta. Ogni attività è
assegnata a uno specifico coltivatore e viene monitorata nel tempo in base al suo stato di esecuzione.
Il sistema tiene traccia dell’andamento delle colture e delle attività svolte. Si utilizzino le proprie
conoscenze del dominio per definire eventuali dettagli non specificati nella traccia.
(Extra) Per i soli gruppi da 3 membri: Il sistema prevede la possibilità di notifica agli utenti in caso di
attività pianificate imminenti o anomalie registrate (es. infestazioni, siccità).
2.1.2 Specifica delle funzionalità per l’insegnamento di Programmazione Object-
Oriented
Si sviluppi un applicativo Java con interfaccia grafica (Swing o JavaFX) per la gestione delle coltivazioni
e delle attività nella piattaforma UninaBioGarden. Il sistema dovrà essere collegato a un database
relazionale pre-popolato contenente informazioni su utenti (proprietari di lotti e coltivatori), lotti e
culture. Il sistema deve permettere l’autenticazione dei proprietari di lotti tramite credenziali
(username e password). Una volta autenticati, i proprietari potranno creare progetti stagionali,
selezionando uno dei propri lotti, una o più colture da associare e definendo le attività da svolgere. Per
ogni attività, sarà necessario specificare i coltivatori coinvolti e, nel caso di attività di raccolta, anche la
quantità prevista. I proprietari avranno inoltre la possibilità di visualizzare i progetti stagionali esistenti,
applicando filtri per lotto. Dopo aver selezionato un progetto, sarà possibile aggiornare lo stato delle
attività collegate (ad esempio: pianificata, in corso, completata).
Infine, il sistema deve fornire un report che, per ogni lotto, riassuma per ciascuna coltura: il numero
totale di raccolte effettuate, la quantità media, minima e massima raccolta. Il report deve fornire una
rappresentazione grafica, chiara e intuitiva dei dati, realizzata utilizzando una libreria come JFreeChart.
Per i soli gruppi da 3 membri:
Il sistema deve consentire ai proprietari di lotti di inserire notifiche relative ai propri progetti stagionali.
Le notifiche possono riguardare eventi importanti, come attività imminenti da svolgere entro “X” giorni,
oppure anomalie (es. infestazioni, siccità). Durante la creazione della notifica, il proprietario specifica
se è destinata ad un singolo coltivatore oppure se è risolva a tutti. Tutte le notifiche sono consultabili
in un’apposita sezione dell’interfaccia.

