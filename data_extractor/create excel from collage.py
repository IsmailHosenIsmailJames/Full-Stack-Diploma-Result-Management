import json

def getFileName(extension:str) -> str:
    import os

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
    
    
def create_excel_file(data:dict, code:int, semester:int) -> bool:
    """create a excel file and save it on the same path

    Args:
        data (dict): data as dict of result
        code (int): ENNI code of collage

    Returns:
        bool: if successful it will return true else false
    """
    ourCollage = data[f'{code}']
    collageResult = ourCollage['result']
    referedStudentNumber = ourCollage['refeared']
    passedStudentNumber = ourCollage['passed']
    dropedStudentsNumber = ourCollage['droped']
    
    # csv file name

    # importing the csv module
    import csv

    # field names
    fields = ['No','Roll', 'Semeset', 'CGPA']
    rows = [[]]
    number = 0
    for roll, result in collageResult.items():
        number += 1
        if(result['pass']):
            cgpa = result['result']
            rows.append([f'{number}', f'{roll}', '7', f'{cgpa}'])
        else:
            refeard = result['failed']
            refeardStr = ""
            for i in refeard:
                refeardStr += " " + i
            rows.append([f'{number}', f'{roll}', '7', f'{refeardStr}'])
        
    filename = f"{code}_{semester}.csv"
    # writing to csv file
    with open(filename, 'w') as csvfile:
        # creating a csv writer object
        csvwriter = csv.writer(csvfile)
        
        # writing the fields
        csvwriter.writerow(fields)
        
        # writing the data rows
        csvwriter.writerows(rows)
    print("All oparation have done successfully")


# Call and get selected file name
fileName = getFileName("json")

# Opening JSON file
f = open(fileName)
data = json.load(f)
f.close()

# Iterating through the json
# list
semester = int(input("Please enter your semetser : "))

create_excel_file(data, 54049, semester)

