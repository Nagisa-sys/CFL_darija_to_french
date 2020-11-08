import os,re
from unidecode import unidecode

sourceData="data"
directory="dictionary"
words=[]
verbs= open(directory+os.sep+"verbs.txt","a+")
nounsM= open(directory+os.sep+"nounsM.txt","a+")
nounsF= open(directory+os.sep+"nounsF.txt","a+")
adjectives= open(directory+os.sep+"adjectives.txt","a+")
adverbes= open(directory+os.sep+"adverbes.txt","a+")
dictionary = {"ا":"a","أ":"a","إ":"i","ة":"a","ش":"x","غ":"4","ق":"9","ح":"7","ع":"3","خ":"5","ظ":"d"}
print("n => noun || v => verbe || a => adjective || d => adverbe")

for filename in os.listdir(sourceData):
    if filename.endswith(".txt"): 
        with open(sourceData+os.sep+filename,'r') as f:
            for line in f:
                line=re.sub("[ ,.]", " ", line)
                for word in  line.split():
                    for key in dictionary.keys():
                        word=word.replace(key, dictionary[key])
                    words.append(unidecode(word).lower())
    #os.remove(directory+os.sep+filename)

for word in words :
    print("\n" + word)
    c = input()
    if c == "v":
        print("Radical => ",end="")
        temp=input()
        if(temp!=''):
            word=temp
        print("Translation of the verbe => ",end="")
        translation=input()
        verbs.write(word+":"+translation+"\n")
    if c == "n":
        print("after verification of our syntax => ",end="")
        temp=input()
        if(temp!='p'):
            word=temp
        print("m or f => ",end="")
        c = input()
        if c == "m":
            print("Translation of the masculain noun => ",end="")
            translation=input()
            if(translation=='p'):
                translation=word
            nounsM.write(word+":"+translation+"\n")
        if c == "f":
            print("Translation of the feminine noun => ",end="")
            translation=input()
            if(translation=='p'):
                translation=word
            nounsF.write(word+":"+translation+"\n")
    if c == "a":
        print("after verification of our syntax => ",end="")
        temp=input()
        if(temp!='p'):
            word=temp
        print("Translation of the adjective => ",end="")
        translation=input()
        adjectives.write(word+":"+translation+"\n")
    if c == "d":
        print("after verification of our syntax => ",end="")
        temp=input()
        if(temp!='p'):
            word=temp
        print("Translation of the adverbe => ",end="")
        translation=input()
        adverbes.write(word+":"+translation+"\n")
    if c == "7":
        break

verbs.close()
nounsM.close()
nounsF.close()
adjectives.close()
adverbes.close()
#gawk -i inplace '!a[$0]++' file