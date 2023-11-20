#include <iostream>

// Definir los campos de la instrucción
#define OPCODE_MASK     0xF00000
#define RD_MASK         0x0F0000
#define RS1_MASK        0x00F000
#define RS2_MASK        0x000F00
#define FREE_7_5_MASK   0x0000E0
#define OPTYPE_4_3_MASK 0x000018
#define FREE_2_0_MASK   0x000007

#define OPCODE_SHIFT    20
#define RD_SHIFT        16
#define RS1_SHIFT       12
#define RS2_SHIFT       8
#define FREE_7_5_SHIFT  5
#define OPTYPE_4_3_SHIFT 3
#define FREE_2_0_SHIFT  0

#define SUM_OPCODE      0x5
#define RES_OPCODE      0x6
#define MUL_OPCODE      0x8
#define DIV_OPCODE      0x9

bool validateInstruction(uint32_t instruction,  uint8_t opcodeGeneral) {

    if ((instruction & 0xFF000000) != 0) {
        std::cout << "Error: La instrucción no es de 24 bits." << std::endl;
        return false;
    }

    uint8_t opcode = (instruction & OPCODE_MASK) >> OPCODE_SHIFT;
    uint8_t rd = (instruction & RD_MASK) >> RD_SHIFT;
    uint8_t rs1 = (instruction & RS1_MASK) >> RS1_SHIFT;
    uint8_t rs2 = (instruction & RS2_MASK) >> RS2_SHIFT;
    uint8_t free_7_5 = (instruction & FREE_7_5_MASK) >> FREE_7_5_SHIFT;
    uint8_t op_type_4_3 = (instruction & OPTYPE_4_3_MASK) >> OPTYPE_4_3_SHIFT;
    uint8_t free_2_0 = (instruction & FREE_2_0_MASK) >> FREE_2_0_SHIFT;
    uint32_t resultado;
    std::string instructionType;

    switch (opcode) {
        case SUM_OPCODE:
            std::cout << "Instruccion de suma." << std::endl;
            instructionType= "suma";
            resultado = rs1+rs2;
            break;
        case RES_OPCODE:
            std::cout << "Instruccion de resta." << std::endl;
            instructionType= "resta";
            resultado = rs1-rs2;
            break;
        case MUL_OPCODE:
            std::cout << "Instruccion de multiplicacion." << std::endl;
            instructionType= "multiplicacion";
            resultado = rs1*rs2;
            break;
        case DIV_OPCODE:
            std::cout << "Instruccion de division." << std::endl;
            instructionType= "division";
            resultado = rs1/rs2;
            break;
        default:
            std::cout << "Opcode no reconocido." << std::endl;
            return false;
    }


    std::cout << "Opcode: " << std::hex << static_cast<int>(opcode) << std::endl;
    std::cout << "RD: " << static_cast<int>(rd) << std::endl;
    std::cout << "RS1: " << static_cast<int>(rs1) << std::endl;
    std::cout << "RS2: " << static_cast<int>(rs2) << std::endl;
    std::cout << "FREE[7:5]: " << static_cast<int>(free_7_5) << std::endl;
    std::cout << "Op type[4:3]: " << static_cast<int>(op_type_4_3) << std::endl;
    std::cout << "FREE[2:0]: " << static_cast<int>(free_2_0) << std::endl;


    std::cout << "Resultado de la " << instructionType << "en hexadecimal es: " << resultado << std::endl;

    return true;
}

int main() {

    uint8_t opcodeToValidateSum = 0x5;
    uint8_t opcodeToValidateRes = 0x6;
    uint8_t opcodeToValidateMul = 0x8;
    uint8_t opcodeToValidateDiv = 0x9;

    uint32_t instructionSum = 0x526300;
    uint32_t instructionRes = 0x626300;
    uint32_t instructionMul = 0x826300;
    uint32_t instructionDiv = 0x926300;

    validateInstruction(instructionSum, opcodeToValidateSum);
    validateInstruction(instructionRes, opcodeToValidateRes);
    validateInstruction(instructionMul, opcodeToValidateMul);
    validateInstruction(instructionDiv, opcodeToValidateDiv);


    return 0;
}
