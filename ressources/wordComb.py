from itertools import product

wordToTest="ghaykhrbech"
p=[["ch","x"],["kh","5"],["gh","4"]]
combinations=[wordToTest]
cost=[0]

def filler(word, from_char, to_char):
    options = [(c,) if c != from_char else (from_char, to_char) for c in word]
    return (''.join(o) for o in product(*options))

for word in combinations :
    for one in p :
        i=word.count(one[0])
        for j in range(i):
            temp=list(filler(word.replace(one[0],'X'),'X',one[1]))
            for element in temp:
                element=element.replace('X',one[1])
                if(word!=element and element not in combinations):
                    combinations.append(element)
                    cost.append(len(wordToTest)-len(element))

print(combinations)
print(cost)