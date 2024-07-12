#################### Firebase database #######################################
import json
import os
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Fetch the service account key JSON file contents
cred = credentials.Certificate(
    'C:/Users/mdism/Extract Diploma Result/developersunited-firebase-adminsdk-jx3em-1a9f478b00.json')
# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(
    cred, {'databaseURL': "https://developersunited-default-rtdb.asia-southeast1.firebasedatabase.app/"})

# get json file name
def getFileName(extension: str) -> tuple:
    print("/nLooking for PDF files...")
    # Get all files name
    listOfAllFiles = os.listdir()
    pdfNameFiles = []
    for fileName in listOfAllFiles:
        # filter with extenson of file
        if (fileName.endswith(f".{extension.lower()}")):
            pdfNameFiles.append(fileName)

    print(f'We found {len(pdfNameFiles)} pdf files.')
    print("---------------------------\n")
    print("Index\t- File Name")
    # print all matches file that have extensions as given
    for i in range(len(pdfNameFiles)):
        print(f"{i}\t- {pdfNameFiles[i]}")
        
    # get the index for select a file
    indexOfFile = int(
        input("\nSelect a File by Enter Indexing For  Result : "))
    selectedPdfFileName = ""
    # if user give wrong index error will appear
    if (indexOfFile >= len(pdfNameFiles)):
        print("Out of range...")
        return
    selectedPdfFileName = pdfNameFiles[indexOfFile]
    
    print(f'You have selected this file :\t{pdfNameFiles[indexOfFile]}')
    # return the selected file name
    return selectedPdfFileName


def openJsonFileResult(fileName: str) -> dict:
    """This function will open the json file with the file name as given. The will modify as required. After modify properly it will return the modified json file as dict

    Args:
        fileName (str): The file name of json file.

    Returns:
        dict: This will be modified json file as dict
    """
    # collceting required data from user ...
    print("We need Important Information about this file. Provide this information...")
    providan = int(input("Enter Providan : "))
    # Cheak the providan is correct  or not 
    if (providan != 2016 and providan != 2022):
        print("Providan sould be 2016 or 2022")
        return None
    semester = int(input("Enter Semester : "))
    # Cheak the semester is correct or not ...
    if (semester > 8 or semester < 1):
        print("Semester must between 1-8")
        return None
    # get when the exam was held
    examYear = int(input("Enter year when exam was held : "))
    # cheak is the year is correct or not
    if (examYear < 2016 and examYear > 2023):
        print("Cheak the code again  : ")
        return None
    
    # init dict
    resultFinal = dict()
    
    # Open the json file
    with open(fileName, "r") as jsonFile:
        data = json.load(jsonFile)
        # init the required data from json
        totalStudent = len(data)
        totalPoint = 0
        passed = 0
        refered = 0
        drop = 0
        # modify the json file and calculate all required information
        for roll in data:
            # get the single person result
            resultFinal[roll] = {f"{semester}": data[roll]}
            # calculate which student was passed and the CGPA
            if (data[roll]['pass'] == True):
                totalPoint += float(data[roll]['result'])
                passed += 1
            else:
                # calculate the droped student and student which was refered
                failed = data[roll]['failed']
                # if fail more than 3, then he is Droped
                if (len(failed) >= 4):
                    drop += 1
                else:
                    # else he is refered
                    refered += 1
        # calculate the avarage point of result
        if(passed != 0):
            avaragePoint = totalPoint/passed
        else:
            avaragePoint = 0
        # Calculate the pass rate
        passRate = passed/totalStudent

        return {
            "resultData": resultFinal,
            "data": {
                "providan": providan,
                "semester": semester,
                "avaragePoint": avaragePoint,
                "passRate": passRate,
                "totalStudent": totalStudent,
                "passed": passed,
                "refered": refered,
                "droped": drop,
                "passRate": passRate,
                "examYear": examYear
            }
        }


# Uloade on firebase
def uploadeOnFirebase(dataDict: dict) -> dict:
    """It will uploade json files on firebase

    Args:
        data (dict): result data with aditional information

    Returns:
        dict: if uploade succfull, return the dict that is uploaded. Else None
    """
    semester = dataDict["data"]['semester']
    totalStudent = dataDict["data"]['totalStudent']
    counter = 0
    print("Getting the data from Realtime database...")
    probidan = dataDict['data']['providan']
    refResult = db.reference(f'/result/personal/{probidan}/')
    mainData = dict(refResult.get())
        
    print("Inserting data...")
    if(mainData != None):
        for roll in dataDict['resultData']:
            try:
                singleData = mainData[roll]
                singleData[f"{semester}"] = dataDict['resultData'][roll]
                mainData[roll] = singleData
            except:
                singleData = dict()
                singleData[f'{semester}'] = dataDict['resultData'][roll]
                mainData[roll] = singleData
    else:
        mainData = dataDict["resultData"]

    try:
        print("Uploading modified data...")
        refResult.set(mainData)
        print("Uploding some info of result of semester ...")
        refInfo = db.reference(f'/result/info/{probidan}/{semester}')
        refInfo.set(dataDict['data'])
        print("Done all process")
        return mainData
    except:
        return None
        

fileName = getFileName("json")
print(fileName)

dataDictResult = openJsonFileResult(
    fileName=fileName)

if (dataDictResult != None):
    
    uploadedData = uploadeOnFirebase(dataDictResult)
    if(uploadedData != None):
        with open("Uploaded Json file.json", 'w') as file:
            json.dump(uploadedData, file, indent= 2,sort_keys= True)

        print("Successfully Done all the task....")
    else:
        print("There have some error in process...")
        