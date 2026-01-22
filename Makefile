bdd-docs: 
	cd docs/uninabiogarden/BDD && pandoc "Documentazione-BDD.md" \
    -o Documentazione-BDD.pdf \
    --pdf-engine=xelatex \
    --toc \
    -N \
    -V geometry:margin=2cm \
    -V colorlinks=true \
    -V lang=it-IT
 