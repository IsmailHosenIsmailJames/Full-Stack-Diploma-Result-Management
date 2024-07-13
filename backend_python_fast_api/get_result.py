import json
import os


def getResult(examType:str ,regulation: int, heldOn:str, semester:int, isIndividual:bool, roll:int = None, eiin:int = None)-> dict:
    if(roll == None and eiin == None):
        assert "roll and eiin cant be None at the same time"
    if(isIndividual == True and roll == None):
        assert "if isIndividual True then roll cann't be None"
    if(isIndividual == False and eiin == None):
        assert "if isIndividual False then eiin cann't be None"
    
    dataFolder = "data"
    filesData = os.listdir("data")
    if(isIndividual == True):
        try:
            for files in filesData:
                if(files.find(f"{examType}_{regulation}_{heldOn}_{semester}")) != -1:
                    with open(f"{dataFolder}/{examType}_{regulation}_{heldOn}_{semester}_individual.json", 'r') as f :
                        requiredDataIndividual = json.load(f)
                        return requiredDataIndividual[f"{roll}"]
                    break
        except:
            return None
    else:
        try:
            for files in filesData:
                if(files.find(f"{examType}_{regulation}_{heldOn}_{semester}")) != -1:
                    with open(f"{dataFolder}/{examType}_{regulation}_{heldOn}_{semester}_institute.json", 'r') as f :
                        requiredDataInstitute = json.load(f)
                        return requiredDataInstitute[f"{eiin}"]
                    break
        except:
            return None