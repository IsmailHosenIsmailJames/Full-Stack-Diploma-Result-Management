import os
import json

def getResult(examType:str ,regulation: str, heldOn:str, semester:str, isIndividual:str )-> dict:
    dataFolder = "data"
    filesData = os.listdir("data")
    if(isIndividual == 'y'):
        roll = input("Your roll : ")
        try:
            for files in filesData:
                if(files.find(f"{examType}_{regulation}_{heldOn}_{semester}")) != -1:
                    with open(f"{dataFolder}/{examType}_{regulation}_{heldOn}_{semester}_individual.json", 'r') as f :
                        requiredDataIndividual = json.load(f)
                        return requiredDataIndividual[roll]
                    break
        except:
            None

    else:
        enei = input("ENEI number : ")
        try:
            for files in filesData:
                if(files.find(f"{examType}_{regulation}_{heldOn}_{semester}")) != -1:
                    with open(f"{dataFolder}/{examType}_{regulation}_{heldOn}_{semester}_institute.json", 'r') as f :
                        requiredDataInstitute = json.load(f)
                        return requiredDataInstitute[enei]
                    break
        except:
            return None

print("We need more information about these data. Note : These information is important.\nYou can collect thse info from PDF!")
examType = (input("Exam Type : "))
regulation = input("Regulation : ")
heldOn = input("Held On : ")
semester = input("Semester : ")
isIndividual = input("is individual result : [y/n] : ")


print(getResult(semester=semester, examType= examType, heldOn=heldOn, isIndividual= isIndividual, regulation=regulation))