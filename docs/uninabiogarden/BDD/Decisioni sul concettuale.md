
#### Why lotto e orto
Per il lotto ho deciso di isolare l'orto come un entita a se stante
Questo per due motivi: 
- permettere ad un proprietario di possedere un orto oltre che a un singolo lotto
- ridurre la duplicazione dei dati: se ci sono 100 lotti allo stesso indirizzo e allo stesso orto per ogni lotto si duplicano indirizzo e nome orto
#### Why Coltivazione
la coltivazione come entita era diventata troppo grande, aveva troppi atributi. Cosi l ho resa un entita a se stante che viene identificata dal

progetto e dalla coltura. Questo porta e una migliore divisione delle responsabilita: un attivita non e piu associata ad una coltura generale ma direttamente con la coltivazione. Intolre se un progetto ha piu di una coltura, si possono distingure le attitivita in base alla coltivazione perche ce una relazione diretta

#### Decisione: Attivita identificata da coltivazione
"L'attività è debole rispetto alla coltivazione; poiché la coltivazione è a sua volta debole rispetto al progetto, il legame con quest'ultimo è implicitamente garantito dalla transitività e non richiede un'associazione esplicita che sporcherebbe il modello."

Nel nostro modello concettuale non abbiamo ritenuto necessario modellare delle attivita generiche. Questo rende un attività dipendente dalla coltivazione e anzi un attività verrebbe identificata dalla coltivazione a cui si riferisce e in modo transitivo da un progetto. 



