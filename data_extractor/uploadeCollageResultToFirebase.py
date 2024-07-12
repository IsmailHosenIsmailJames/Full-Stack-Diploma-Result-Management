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


def openJsonFileCollageResult(fileName: str) -> dict:
    print("We need Important Information about this file. Provide this information...")
    # Collect the required information and cheak is the infomation validated
    providan = int(input("Enter Providan : "))
    if (providan != 2016 and providan != 2022):
        print("Providan sould be 2016 or 2022")
        return None
    semester = int(input("Enter Semester : "))
    if (semester > 8 or semester < 1):
        print("Semester must between 1-8")
        return None
    examYear = int(input("Enter year when exam was held : "))
    if (examYear < 2016 and examYear > 2023):
        print("Cheak the code again  : ")
        return None

    # init the data
    resultFinal = dict()

    with open(fileName, "r") as jsonFile:
        data = json.load(jsonFile)

        for collage in data:
            collageResult = data[collage]
            totalStudent = len(collageResult)
            totalPoint = 0
            passed = 0
            refered = 0
            drop = 0
            for roll in collageResult:

                if (collageResult[roll]['pass'] == True):
                    totalPoint += float(collageResult[roll]['result'])
                    passed += 1
                else:
                    failed = collageResult[roll]['failed']
                    if (len(failed) < 4):
                        refered += 1
                    else:
                        drop += 1

            if (passed != 0):
                avaragePoint = totalPoint/passed
            else:
                avaragePoint = 0
            passRate = passed/totalStudent
            collageFinalData = {
                f'{semester}':
                    {
                        "resultData": collageResult,
                        'data': {
                            "providan": providan,
                            "semester": semester,
                            "avaragePoint": avaragePoint,
                            "passRate": passRate,
                            "totalStudent": totalStudent,
                            "passed": passed,
                            "refered": refered,
                            "droped": drop,
                            "passRate": passRate,
                            "examYear": examYear,
                        }
                    }
            }
            resultFinal[collage] = collageFinalData
            resultFinal['info'] = {
                "providan": providan,
                "semester": semester,
                "held": examYear
            }

        return resultFinal


def uploadeOnFirebaseCollageResult(data: dict) -> dict:
    """It will downloade data from firebase and then mearge together with provided data and then again will upload in firebase again.

    Args:
        data (dict): The result of collage that will uploaded

    Returns:
        dict: if successfull function will return Dict that is uploaded. Else None.
    """
    info = data['info']
    providan = info['providan']
    semester = info['semester']
    held = info['held']
    ref = db.reference(f'/result/collage/{providan}/')
    previousData = ref.get()
    if (previousData != None):
        for collage in previousData:
            try:
                singleCollage = data[collage]
                previousData[collage][f'{semester}'] = singleCollage[f'{semester}']
                data.pop(collage)
            except:
                print("Do not present previous collage list!")
        for collage in data:
            previousData[collage] = data[collage]
            print("New Collage...")
    else:
        previousData = data

    try:
        print("Uploading Data on firebase...")
        ref.set(previousData)
        print("Successfull...")
        return previousData

    except Exception as error:
        print(error)
        return None


data = openJsonFileCollageResult('result_2nd (1).pdf_institute.json')
uploadedData =  uploadeOnFirebaseCollageResult(data)
with open('Uploade Collage Result.json', 'w') as file:
    json.dump(uploadedData, file, indent=2, sort_keys=True)
