darijaF: tanya.l tanya.y
		bison -d tanya.y
		flex tanya.l
		gcc ./ListeDataStructure/liste.c ./ListeDataStructure/words.c tanya.tab.c lex.yy.c -o darijaF -g
		rm lex.yy.c tanya.tab.c tanya.tab.h