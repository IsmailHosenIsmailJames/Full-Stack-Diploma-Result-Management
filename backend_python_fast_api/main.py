import os
from fastapi import FastAPI
from pydantic import BaseModel

from get_result import getResult

app = FastAPI()

class Individual(BaseModel):
    examType:str
    regulation: int
    heldOn:str
    semester:int
    roll: int

class Inistitution(BaseModel):
    examType:str
    regulation: int
    heldOn:str
    semester:int
    eiin: int

@app.get("/files-list")
async def getExitsData():
    return {"files-list": os.listdir("data")}

@app.get("/individual/")
async def get_individual_data(individual: Individual):
    return getResult(
        examType=individual.examType, 
        regulation= individual.regulation,
        heldOn= individual.heldOn,
        semester= individual.semester,
        roll= individual.roll,
        isIndividual= True,
    )

@app.get("/inistitution/")
async def get_inistitution_data(inistitution: Inistitution):
    return getResult(
        examType=inistitution.examType, 
        regulation= inistitution.regulation,
        heldOn= inistitution.heldOn,
        semester= inistitution.semester,
        isIndividual= False,
        eiin=inistitution.eiin
    )
