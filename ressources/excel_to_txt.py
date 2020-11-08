import xlrd,os,re
directory = ("/home/T1945/lex/liste/ressources/rawdata")

def remove_emoji(string):
    emoji_pattern = re.compile("["
                           u"\U0001F600-\U0001F64F"  # emoticons
                           u"\U0001F300-\U0001F5FF"  # symbols & pictographs
                           u"\U0001F680-\U0001F6FF"  # transport & map symbols
                           u"\U0001F1E0-\U0001F1FF"  # flags (iOS)
                           u"\U00002702-\U000027B0"
                           u"\U000024C2-\U0001F251"
                           "]+", flags=re.UNICODE)
    return emoji_pattern.sub(r'', string)

for filename in os.listdir(directory):
    if filename.endswith(".xlsx"): 
        with xlrd.open_workbook(directory+os.sep+filename,'r') as wb:
            sheet = wb.sheet_by_index(0)
            myText = open('/home/T1945/lex/liste/ressources/data/'+filename+'.txt','w',encoding='utf-8')
            for i in range(6,sheet.nrows): 
                myText.write(remove_emoji(str(sheet.cell_value(i, 6))))
                myText.write("\n")