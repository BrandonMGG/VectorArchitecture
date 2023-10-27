# Registers ID's
registersIdentifiers = {
    
    "R0":  "0000",
    "R1":  "0001",
    "R2":  "0010",
    "R3":  "0011",
    "R4":  "0100",
    "R5":  "0101",
    "R6":  "0110",
    "R7":  "0111",
    "R8":  "1000",
    "R9":  "1001",
    "R10": "1010",
    "R11": "1011",
    "R12": "1100",
    "R13": "1101",
    "R14": "1110",
    "R15": "1111"
}

# Operation Code
opCode = {

    # Data-Reg:
    "ADDR": "00000",
    "SUBR": "00001",
    "MULR": "00010",
    "DIVR": "00011",
    "XOR":  "00100",
    "TEST":  "00110",

    # Data-Imm:
    "ADDI": "11000",
    "SUBI": "11001",
    "MULI": "11010",
    "DIVI": "11011",
    "CMP": "11101",

    # Memory:
    "SOM": "0",
    "LFM": "1",

    # Control:
    "JU": "00",
    "JT": "10",
    "JNT": "11",
}

type = {

    # Data-Reg:
    "ADDR": "10",
    "SUBR": "10",
    "MULR": "10",
    "DIVR": "10",
    "XOR":  "10",
    "TEST":  "10",

    # Data-Imm:
    "ADDI": "10",
    "SUBI": "10",
    "MULI": "10",
    "DIVI": "10",
    "CMP": "10",

    # Memory:
    "SOM": "01",
    "LFM": "01",

    # Control:
    "JT": "00",
    "JNT": "00",
    "JU": "00"
}

# Function to read and obtain instruction from a file.txt
def getInstructions(file):

    # Special characters list
    characters = [" ", ",", "]", "["]
    # Variable to store the instructions from the file
    instructionsList = []

    data = open(file, 'r')
    lines = data.readlines()

    # Iterating lines
    for line in lines:

        isMemory = False
        aux = ""
        instruction = []

        # To check if there's a label
        last = line[-2]

        # Is label
        if(last == ":"):

            instructionsList.append([line[:-2]])

        # Is instruction
        else:

            for char in line:

                if(char in characters):
                    
                    if(char == "["):
                        isMemory = True

                    if(aux != ""):
                        instruction.append(aux)
                    
                    aux = ""

                else:

                    aux += char
            
            aux = aux[:-1]
            instruction.append(aux)

            if(isMemory == True):
                instruction.pop()

            instructionsList.append(instruction)

    return instructionsList

# Stalls Manager
def riskManagement(instructionsList, typeInstruction, opCode):
    
    controlCase = controlRiskStall(instructionsList, typeInstruction)
    firstCase = insertFirstStall(controlCase, typeInstruction, opCode)
    secondCase = insertSecondStall(firstCase, typeInstruction, opCode)
    thirdCase = insertThirdStall(secondCase, typeInstruction, opCode)
    return thirdCase

# Control Risks
def controlRiskStall(instructionsList, typeInstruction):

    instructionsListAux = instructionsList.copy()
    instructionsListAux.append("+")
    
    stall = ['ADDR', 'R0', 'R0', 'R0', "********************"]
    index = 0

    for instruction in instructionsListAux:

        if(len(instruction) > 1):

            # Get name of instruction
            currentInstruction = instruction[0]
            currentInstructionType = typeInstruction[currentInstruction]

            # Is a Control instruction
            if(currentInstructionType == "00"):

                instructionsListAux.insert(index + 1, stall)
                instructionsListAux.insert(index + 2, stall)
                instructionsListAux.insert(index + 3, stall)
                instructionsListAux.insert(index + 4, stall)

        index += 1

    return instructionsListAux

# 0 instructions between them
# Case 1
def insertFirstStall(instructionsList, typeInstruction, opCode):

    instructionsListAux = instructionsList.copy()
    instructionsListAux.append("+")
    
    stall = ['ADDR', 'R0', 'R0', 'R0', "********************"]
    index = 0

    for instruction in instructionsListAux:

        if(len(instruction) > 1):

            if(instructionsListAux[index + 1] == "+"):
                break

            # Get name of instruction
            currentInstructionName = instruction[0]
            currentInstructionType = typeInstruction[currentInstructionName]

            # Obtain RD
            rDestiny = instruction[1]

            if(rDestiny != "R0"):

                # Next is instruction
                if(len(instructionsListAux[index + 1]) > 1):
                    nextInstructionAux = instructionsListAux[index + 1]

                # Next is Label
                else:
                    nextInstructionAux = instructionsListAux[index + 2]

                nextInstructionName = nextInstructionAux[0]

                nextInstructionType = typeInstruction[nextInstructionName]

                # Current is Memory
                if(currentInstructionType == "01" and currentInstructionName == "LFM"):

                    # Next is Control
                    if(nextInstructionType == "00"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Conditional or Inconditional
                        nextCondition = nextInstructionOpCode[0]

                        # Conditional
                        if(nextCondition == "1"):

                            nextFirstRegister = nextInstructionAux[1]
                            nextSecondRegister = nextInstructionAux[2]

                            if(rDestiny == nextFirstRegister or rDestiny == nextSecondRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
                                instructionsListAux.insert(index + 3, stall)

                    # Next is Memory
                    elif(nextInstructionType == "01"):

                        nextInstructionOpCode = opCode[nextInstructionName]
                        # Load or Store
                        nextLoadorStore = nextInstructionOpCode[0]

                        # Store
                        if(nextLoadorStore == "0"):

                            nextSourceRegister = nextInstructionAux[1]
                            nextDestinyRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister or rDestiny == nextDestinyRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
                                instructionsListAux.insert(index + 3, stall)

                        # Load
                        else:
                            nextSourceRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
                                instructionsListAux.insert(index + 3, stall)
            
                    # Next is Data "10"
                    else:
                        nextSourceRegister1 = nextInstructionAux[2]
                        nextSourceRegister2 = nextInstructionAux[3]

                        if(rDestiny == nextSourceRegister1 or rDestiny == nextSourceRegister2):

                            instructionsListAux.insert(index + 1, stall)
                            instructionsListAux.insert(index + 2, stall)
                            instructionsListAux.insert(index + 3, stall)
        
                # Current is Data
                else:
                    # Next is Control
                    if(nextInstructionType == "00"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Conditional or Inconditional
                        nextCondition = nextInstructionOpCode[0]

                        if(nextCondition == "1"):

                            nextFirstRegister = nextInstructionAux[1]
                            nextSecondRegister = nextInstructionAux[2]

                            if(rDestiny == nextFirstRegister or rDestiny == nextSecondRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
                                instructionsListAux.insert(index + 3, stall)


                    # Next is Memory
                    elif(nextInstructionType == "01"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Load or Store
                        nextLoadorStore = nextInstructionOpCode[0]

                        # Store
                        if(nextLoadorStore == "0"):

                            nextSourceRegister = nextInstructionAux[1]
                            nextDestinyRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister or rDestiny == nextDestinyRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
                                instructionsListAux.insert(index + 3, stall)
                        # Load
                        else:
                            nextSourceRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
                                instructionsListAux.insert(index + 3, stall)

                    # Next is Data
                    else:

                        nextSourceRegister1 = nextInstructionAux[2]
                        nextSourceRegister2 = nextInstructionAux[3]

                        if(rDestiny == nextSourceRegister1 or rDestiny == nextSourceRegister2):

                            instructionsListAux.insert(index + 1, stall)
                            instructionsListAux.insert(index + 2, stall)
                            instructionsListAux.insert(index + 3, stall)

        index += 1

    # Without the last element
    return instructionsListAux[:-1]

# 1 instruction between them
# Case 2
def insertSecondStall(instructionsList, typeInstruction, opCode):

    instructionsListAux = instructionsList.copy()
    instructionsListAux.append("+")
    
    stall = ['ADDR', 'R0', 'R0', 'R0', "********************"]
    index = 0

    for instruction in instructionsListAux:

        if(len(instruction) > 1):

            if(instructionsListAux[index + 2] == "+"):
                break

            # Get name of instruction
            currentInstructionName = instruction[0]
            currentInstructionType = typeInstruction[currentInstructionName]

            # Obtain RD
            rDestiny = instruction[1]

            if(rDestiny != "R0"):

                # Next is instruction
                if(len(instructionsListAux[index + 2]) > 1):
                    nextInstructionAux = instructionsListAux[index + 2]

                # Next is Label
                else:
                    nextInstructionAux = instructionsListAux[index + 3]

                nextInstructionName = nextInstructionAux[0]

                nextInstructionType = typeInstruction[nextInstructionName]

                # Current is Memory
                if(currentInstructionType == "01" and currentInstructionName == "LFM"):

                    # Next is Control
                    if(nextInstructionType == "00"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Conditional or Inconditional
                        nextCondition = nextInstructionOpCode[0]

                        # Conditional
                        if(nextCondition == "1"):

                            nextFirstRegister = nextInstructionAux[1]
                            nextSecondRegister = nextInstructionAux[2]

                            if(rDestiny == nextFirstRegister or rDestiny == nextSecondRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)

                    # Next is Memory
                    elif(nextInstructionType == "01"):

                        nextInstructionOpCode = opCode[nextInstructionName]
                        # Load or Store
                        nextLoadorStore = nextInstructionOpCode[0]

                        # Store
                        if(nextLoadorStore == "0"):

                            nextSourceRegister = nextInstructionAux[1]
                            nextDestinyRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister or rDestiny == nextDestinyRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)

                        # Load
                        else:
                            nextSourceRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
            
                    # Next is Data "10"
                    else:
                        nextSourceRegister1 = nextInstructionAux[2]
                        nextSourceRegister2 = nextInstructionAux[3]

                        if(rDestiny == nextSourceRegister1 or rDestiny == nextSourceRegister2):

                            instructionsListAux.insert(index + 1, stall)
                            instructionsListAux.insert(index + 2, stall)
        
                # Current is Data
                else:
                    # Next is Control
                    if(nextInstructionType == "00"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Conditional or Inconditional
                        nextCondition = nextInstructionOpCode[0]

                        if(nextCondition == "1"):

                            nextFirstRegister = nextInstructionAux[1]
                            nextSecondRegister = nextInstructionAux[2]

                            if(rDestiny == nextFirstRegister or rDestiny == nextSecondRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)


                    # Next is Memory
                    elif(nextInstructionType == "01"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Load or Store
                        nextLoadorStore = nextInstructionOpCode[0]

                        # Store
                        if(nextLoadorStore == "0"):

                            nextSourceRegister = nextInstructionAux[1]
                            nextDestinyRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister or rDestiny == nextDestinyRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)
                        # Load
                        else:
                            nextSourceRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister):

                                instructionsListAux.insert(index + 1, stall)
                                instructionsListAux.insert(index + 2, stall)

                    # Next is Data
                    else:

                        nextSourceRegister1 = nextInstructionAux[2]
                        nextSourceRegister2 = nextInstructionAux[3]

                        if(rDestiny == nextSourceRegister1 or rDestiny == nextSourceRegister2):

                            instructionsListAux.insert(index + 1, stall)
                            instructionsListAux.insert(index + 2, stall)

        index += 1

    # Without the last element
    return instructionsListAux[:-1]

def insertThirdStall(instructionsList, typeInstruction, opCode):

    instructionsListAux = instructionsList.copy()
    instructionsListAux.append("+")
    
    stall = ['ADDR', 'R0', 'R0', 'R0', "********************"]
    index = 0

    for instruction in instructionsListAux:

        if(len(instruction) > 1):

            if(instructionsListAux[index + 3] == "+"):
                break

            # Get name of instruction
            currentInstructionName = instruction[0]
            currentInstructionType = typeInstruction[currentInstructionName]

            # Obtain RD
            rDestiny = instruction[1]

            if(rDestiny != "R0"):

                # Next is instruction
                if(len(instructionsListAux[index + 3]) > 1):
                    nextInstructionAux = instructionsListAux[index + 3]

                # Next is Label
                else:
                    nextInstructionAux = instructionsListAux[index + 4]

                nextInstructionName = nextInstructionAux[0]

                nextInstructionType = typeInstruction[nextInstructionName]

                # Current is Memory
                if(currentInstructionType == "01" and currentInstructionName == "LFM"):

                    # Next is Control
                    if(nextInstructionType == "00"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Conditional or Inconditional
                        nextCondition = nextInstructionOpCode[0]

                        # Conditional
                        if(nextCondition == "1"):

                            nextFirstRegister = nextInstructionAux[1]
                            nextSecondRegister = nextInstructionAux[2]

                            if(rDestiny == nextFirstRegister or rDestiny == nextSecondRegister):

                                instructionsListAux.insert(index + 1, stall)

                    # Next is Memory
                    elif(nextInstructionType == "01"):

                        nextInstructionOpCode = opCode[nextInstructionName]
                        # Load or Store
                        nextLoadorStore = nextInstructionOpCode[0]

                        # Store
                        if(nextLoadorStore == "0"):

                            nextSourceRegister = nextInstructionAux[1]
                            nextDestinyRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister or rDestiny == nextDestinyRegister):

                                instructionsListAux.insert(index + 1, stall)

                        # Load
                        else:
                            nextSourceRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister):

                                instructionsListAux.insert(index + 1, stall)
            
                    # Next is Data "10"
                    else:
                        nextSourceRegister1 = nextInstructionAux[2]
                        nextSourceRegister2 = nextInstructionAux[3]

                        if(rDestiny == nextSourceRegister1 or rDestiny == nextSourceRegister2):

                            instructionsListAux.insert(index + 1, stall)
        
                # Current is Data
                else:
                    # Next is Control
                    if(nextInstructionType == "00"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Conditional or Inconditional
                        nextCondition = nextInstructionOpCode[0]

                        if(nextCondition == "1"):

                            nextFirstRegister = nextInstructionAux[1]
                            nextSecondRegister = nextInstructionAux[2]

                            if(rDestiny == nextFirstRegister or rDestiny == nextSecondRegister):

                                instructionsListAux.insert(index + 1, stall)


                    # Next is Memory
                    elif(nextInstructionType == "01"):

                        nextInstructionOpCode = opCode[nextInstructionName]

                        # Load or Store
                        nextLoadorStore = nextInstructionOpCode[0]

                        # Store
                        if(nextLoadorStore == "0"):

                            nextSourceRegister = nextInstructionAux[1]
                            nextDestinyRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister or rDestiny == nextDestinyRegister):

                                instructionsListAux.insert(index + 1, stall)
                        # Load
                        else:
                            nextSourceRegister = nextInstructionAux[3]

                            if(rDestiny == nextSourceRegister):

                                instructionsListAux.insert(index + 1, stall)

                    # Next is Data
                    else:

                        nextSourceRegister1 = nextInstructionAux[2]
                        nextSourceRegister2 = nextInstructionAux[3]

                        if(rDestiny == nextSourceRegister1 or rDestiny == nextSourceRegister2):

                            instructionsListAux.insert(index + 1, stall)

        index += 1

    # Without the last element
    return instructionsListAux[:-1]


def getLabels(instructionsList):

    labels = {}

    indexPointer = 0

    for instruction in instructionsList:

        indexPointer += 1

        size = len(instruction)

        # Is Label
        if(size == 1):
            labels[instruction[0]] = indexPointer
            instructionsList.remove(instruction)

    return labels, instructionsList


# 2's complement
def complement(b):

    strValue = ""

    for index in b:
        if(index == "0"):
            strValue += "1"
        
        else:
            strValue += "0"

    strValue = int(strValue, 2)
    strValue += 1
    strValue = bin(strValue).replace("0b", "")
    
    return strValue


def extend(type, num, opCode, indexPointer):

    # Is Control
    if(type == "00"):

        imm = num - indexPointer
    
    else:

        imm = num
    
    b = bin(abs(imm)).replace("0b", "")
    bSize = len(b)

    # Is Control
    if(type == "00"):
        condition = opCode[0]

        # Is Conditional Jump
        if(condition == "1"):

            ext = "0" * (20 - bSize)
            b = ext + b

            # Is negative
            if(imm < 0):
                b = complement(b)
            return b
        
        # Is Unconditional Jump
        else:
            
            ext = "0" * (28 - bSize)
            b = ext + b
            if(imm < 0):
                b = complement(b)
            return b
    # Is Memory
    elif(type == "01"):

        ext = "0" * (18 - bSize)
        b = ext + b
        if(imm < 0):
            b = complement(b)
        return b
    
    # Is Data
    else:
        
        flag = opCode[0]

        if(flag == "1"):

            ext = "0" * (17 - bSize)
            b = ext + b
            if(imm < 0):
                b = complement(b)
            return b

def toBinary(file, instructionsList, type, opCode, registersIdentifiers, labels):

    bFile = open(file, 'w')
    index = 0

    for instruction in instructionsList:
        index += 1

        memoryPad = "000"
        dataPad = "0000000000000"

        print("Instruction: ", instruction)#

        # Get type of instruction
        instructionType = type[instruction[0]]
        op = opCode[instruction[0]]

        # Is Control
        if(instructionType == "00"):

            condition = op[0]

            # Conditional
            if(condition == "1"):
                reg1 = registersIdentifiers[instruction[1]]
                reg2 = registersIdentifiers[instruction[2]]
                addr = instruction[3]
                addr = labels[addr]
                addr = extend(instructionType, addr, op, index)

                finalInstruction = instructionType + op + reg1 + reg2 + addr
                print("final: ", instructionType + " " + op + " " + reg1 + " " + reg2 + " " + addr)

            # Unconditional
            else:
                addr = instruction[1]
                addr = labels[addr]
                addr = extend(instructionType, addr, op, index)

                finalInstruction = instructionType + op + addr

                print("final: ", instructionType + " " + op + " " + addr)#

        # Is Memory
        elif(instructionType == "01"):

            reg1 = registersIdentifiers[instruction[1]]
            imm = int(instruction[2])
            imm = extend(instructionType, imm, op, index)
            reg2 = registersIdentifiers[instruction[3]]
            finalInstruction = instructionType + op + memoryPad + reg1 + reg2 + imm
            print("final: ", instructionType + " " + op + " " + memoryPad + " " + reg1 + " " + reg2 + " " + imm)

        # Is Data
        else:
            flag = op[0]

            # Has Imm
            if(flag == "1"):

                reg1 = registersIdentifiers[instruction[1]]
                reg2 = registersIdentifiers[instruction[2]]
                imm = int(instruction[3])
                imm = extend(instructionType, imm, op, index)
                finalInstruction = instructionType + op + reg1 + reg2 + imm
                print("final: ", instructionType + " " + op + " " + reg1 + " " + reg2 + " " + imm)
            
            # Doesn't have Imm
            else:

                reg1 = registersIdentifiers[instruction[1]]
                reg2 = registersIdentifiers[instruction[2]]
                reg3 = registersIdentifiers[instruction[3]]
                finalInstruction = instructionType + op + reg1 + reg2 + reg3 + dataPad
                print("final: ", instructionType + " " + op + " " + reg1 + " " + reg2 + " " + reg3 + " " + dataPad)

        print(" - ")
        bFile.write(finalInstruction + "\n")

    return instructionsList


testInstructions = getInstructions('test.txt')
print("Instructions: ", testInstructions)

testInstructions = riskManagement(testInstructions, type, opCode)
print("Instructions Risk First: ", testInstructions)

labelsTest, testInstructions = getLabels(testInstructions)
print("Labels: ", labelsTest)
print("No labels: ", testInstructions)

toBinary('binary.txt', testInstructions, type, opCode, registersIdentifiers, labelsTest)
