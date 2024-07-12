#################### get data from pdf file ##################################
#################### get data from pdf file ##################################
import json
import sys
import re
import os

# ------------------- pattern for diffrent data -------------------------------
# 74042 - Chakria Polytechnic Institute ,Cox's Bazar
instituteNamePattern = r'\d{5} - .+'
# 668779 (3.67)
# 401069 ( 3.39 )
# 601342 (3.55)
passedrollPattern = r'\b\d{6}\s?\(\s?\d\.\d{2}\s?\)'
# 688999 { 25722(T), 25912(T),25913(T), 25921(T), 26711(T),26911(T) }
refaredRollPattern = r'\d{6} \{[^}]+\}'
# ------------------- pattern for diffrent data -------------------------------

def extractIndividualResult(fileName:str) -> dict:
    """It will take the name of the path of PDFfile and return extracted dict with all individual results.

    Args:
        fileName (str): the name of the path of pdf file

    Returns:
        dict: It conatins the Rolls as key and data as value.
    """
    textFile = open(fileName, 'r')
    text = textFile.read()
    individualResultJson = {}
    
    passedStudents = re.findall(passedrollPattern, text)
    refearedStudents = re.findall(refaredRollPattern, text)
    for student in passedStudents:
        roll, result = str(student).split("(")
        roll = roll.replace(" ", "")
        result = result.replace(")", "").replace(" ", "")
        individualResultJson[roll] = {"pass": True, "result": result}

    for student in refearedStudents:
        data = str(student).replace("{", ",").replace("}", "").replace(" ", "").replace("\n", "").split(",")
        individualResultJson[data[0]] = {"pass" : False, "failed" : data[1:]}
        
    with open(f"{fileName}_individual.json", "w") as file:
        json.dump(individualResultJson, file, indent= 2,sort_keys= True)
    
    return individualResultJson


def extractInstituteResult(fileName:str) -> tuple:
    """It will take input the name of the path of PDF file and extract all results from that and then it will return two dict object.
    One dict is contain all the institution results and another dict contain the code of institution as key and value is institution name.

    Args:
        fileName (str): The path name of PDF file

    Returns:
        tuple: (dict, dict)
    """
    textFile = open(fileName, 'r')
    text = textFile.read()
    instituteResultJson = {}
    temJson = {}
    listOfLinesInText = text.splitlines()
    lenOfListOfLinesInText = len(listOfLinesInText)
    passedStudents = []
    refaredStudents = []
    instituteStudents = []
    isPendingInstitute = False
    pendingInstituteName = ""
    for i in range(lenOfListOfLinesInText):
        progress = i / lenOfListOfLinesInText
        sys.stdout.write("\rProgress: [{:<50}] {:.2f}%".format("=" * int(progress * 50), progress * 100))
        sys.stdout.flush()

        if i == lenOfListOfLinesInText - 1:
            sys.stdout.write("\n")
            sys.stdout.flush()
            print("Successful... All progress.")

        line = listOfLinesInText[i]
        instituteName = re.findall(instituteNamePattern, line)
        if(len(instituteName) == 0) :
            try:
                passed = re.findall(passedrollPattern, line, re.DOTALL)
                refered = re.findall(refaredRollPattern, line, re.DOTALL)
            except:
                continue
            passedStudents += passed
            refaredStudents += refered
        else:
            if(isPendingInstitute):
                for student in passedStudents:
                    roll, result = str(student).split("(")
                    roll = roll.replace(" ", "")
                    result = result.replace(")", "").replace(" ", "")
                    temJson[roll] = {"pass": True, "result": result}
                
                numberOfStudentThatDroped = 0
                numberOfStudentThatRefeared = 0
                for student in refaredStudents:
                    data = str(student).replace("{", ",").replace("}", "").replace(" ", "").replace("\n", "").split(",")
                    if(len(data[1:]) > 3): numberOfStudentThatDroped += 1
                    else : numberOfStudentThatRefeared += 1
                    
                    temJson[data[0]] = {"pass" : False, "failed" : data[1:]}
                code, name = str(pendingInstituteName).split(' - ')
                numberOfStudentThatPassed = len(passedStudents)
                
                
                    
                pendingInstituteName = instituteName[0]
                instituteResultJson[code] = {"name": name, "result":temJson, "passed": numberOfStudentThatPassed, "refeared": numberOfStudentThatRefeared, "droped":numberOfStudentThatDroped}
                temJson = {}
                passedStudents = []
                refaredStudents = []
                
            else:
                isPendingInstitute = True
                pendingInstituteName = instituteName[0]
            
    return instituteResultJson


# function for select a PDF file
def getFileName(extension:str) -> str:
    print("\nLooking for PDF files...")
    
    listOfAllFiles =  os.listdir()
    pdfNameFiles = []
    for fileName in listOfAllFiles:
        if(fileName.endswith(f".{extension.lower()}") or fileName.endswith(f".{extension.upper()}")):
            pdfNameFiles.append(fileName)
            
    print(f'We found {len(pdfNameFiles)} pdf files.')
    print("---------------------------\n")
    print("Index\t- File Name")
    
    for i in range(len(pdfNameFiles)):
        print(f"{i}\t- {pdfNameFiles[i]}")
    
    indexOfFile = int(input("\nSelect a File by Enter Indexing : "))
    selectedPdfFileName = ""
    if(indexOfFile >= len(pdfNameFiles)):
        print("Out of range...")
        return
    
    selectedPdfFileName = pdfNameFiles[indexOfFile]
    print(f'You have selected this file :\t{selectedPdfFileName}')
    return selectedPdfFileName
    
        
# Call and get selected file name
fileName = getFileName("txt")

indivisul = extractIndividualResult(fileName)
institute = extractInstituteResult(fileName)

with open(f"{fileName}_indiviual.json", "w") as file:
    json.dump(institute, file, sort_keys=True, indent= 2)


with open(f"{fileName}_institute.json", "w") as file:
    json.dump(institute, file, sort_keys=True, indent= 2)
        


#################### get data from pdf file ##################################


#################### Firebase database #######################################
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Fetch the service account key JSON file contents
cred = credentials.Certificate('C:/Users/mdism/Extract Diploma Result/developersunited-firebase-adminsdk-jx3em-551c3052db.json')
# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {'databaseURL': "https://developersunited-default-rtdb.asia-southeast1.firebasedatabase.app/"})


import sys
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QLabel, QFileDialog, QLineEdit, QMessageBox
class FilePicker(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('File Picker')
        self.setGeometry(300, 300, 400, 250)

        self.file_label = QLabel(self)
        self.file_label.setGeometry(20, 20, 360, 40)

        self.text_input = QLineEdit(self)
        self.text_input.setGeometry(20, 80, 360, 40)

        pick_button = QPushButton('Pick a PDF File', self)
        pick_button.setGeometry(20, 140, 360, 40)
        pick_button.clicked.connect(self.pickFile)

        ok_button = QPushButton('Ok', self)
        ok_button.setGeometry(20, 200, 360, 40)
        ok_button.clicked.connect(self.okClicked)

    def pickFile(self):
        file_dialog = QFileDialog()
        file_dialog.setFileMode(QFileDialog.ExistingFile)
        file_dialog.setNameFilter('PDF files (*.pdf)')
        file_dialog.exec_()
        file_paths = file_dialog.selectedFiles()

        if file_paths:
            file_path = file_paths[0]
            self.file_label.setText(file_path)


    def okClicked(self):
        text = self.text_input.text()
        file = self.file_label.text()

        try:
            individualRef = db.reference(f'individual/{text}/')
            institutionRef = db.reference(f'institutuin/{text}/')
        
            individualRef.set(extractIndividualResult(fileName=file))
            institutionRef.set(extractInstituteResult(fileName=file))
            QMessageBox.information(self, 'Success', 'Operation successful!')
        except:
            QMessageBox.critical(self, 'Error', 'Operation failed!')
            


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = FilePicker()
    window.show()
    sys.exit(app.exec_())