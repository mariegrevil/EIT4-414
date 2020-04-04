#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

int main() {

    cout << "*** Source file must be located in same folder as this program ***" << '\n'  << '\n'; // Påmindelse om at filen skal ligge i samme mappe.

    bool runProgram = true;
    while(runProgram) { // Programmet fortsætter i et uendeligt loop, så man ikke skal genstarte programmet for at konvertere en ny fil.

//*******************************************************************************************//
//*******************************************************************************************//
//* Indsæt navn på kildefil                                                                 *//
//*******************************************************************************************//
//*******************************************************************************************//

        bool runConvertion = true;

        string fileName; // String indeholdende navnet på filen, der skal konverteres.

        cout << "Enter name of .txt source file: ";
        cin >> fileName; // Afventer input i form af filnavn.
        cout << '\n';

        string fileAssembly = fileName + ".txt"; // Gemmer input-filnavn.
        string fileBinary = fileName + "2.txt"; // Gemmer output-filnavn.

//*******************************************************************************************//
//*******************************************************************************************//
//* Åben og læs fra input-fil                                                                *//
//*******************************************************************************************//
//*******************************************************************************************//

        vector<string> lineAssembly; // Vektor indeholdende alle de læste linjer fra assembly-filen.
        ifstream assembly(fileAssembly); // Åben assembly-filen, så den er klar til at blive læst.

        if (assembly.is_open()) { // Kører hvis assembly-filen er åben.
            string line; // Midlertidig string indeholdende den nuværende linje.
            while (getline(assembly, line)) { // Kører så længe der er en ny linje at læse i assembly-filen.
                lineAssembly.push_back(line); // Tilføj linjens indhold i lineAssembly-vektoren.
            }
        }
        else {
            cout << "Could not read from " << fileAssembly; //Meddeler at input-filen ikke kunne åbnes.
            runConvertion = false; // Afslut programmet hvis assembly-filen ikke kunne åbnes.
        }

        assembly.close(); // Luk assembly-filen, da den ikke skal bruges længere.

        if(runConvertion) { // Kører kun hvis assembly-filen kunne åbnes.

            int inputLineNumber = lineAssembly.size(); //Gemmer størrelsen af lineAssembly-vektoren til senere brug.

//*******************************************************************************************//
//*******************************************************************************************//
//* Print linjeindhold                                                                      *//
//*******************************************************************************************//
//*******************************************************************************************//

            cout << "*** Raw contents of " << fileAssembly << " ***" << '\n';
            cout << "Line | String" << '\n';
            for (int i = 0; i < inputLineNumber; i++) { // Kører for hver linje gemt i lineAssembly-vektoren.
                cout << setw(4) << i << " | " << lineAssembly.at(i) << '\n'; // Print linjens indhold + linjeskift.
            }
            cout << '\n';

//*******************************************************************************************//
//*******************************************************************************************//
//* Generér output - DET ER HER MAGIEN SKER                                                 *//
//*******************************************************************************************//
//*******************************************************************************************//

            vector<string> lineBinary; // Vektor indeholdende alle de konverterede linjer fra assembly-filen til output.

            for (int i = 0; i < inputLineNumber; i++) { // Kører for hver linje gemt i lineAssembly-vektoren.
                if(lineAssembly.at(i) != ""){ // Kører kun hvis linjen ikke er tom.

                    //* DET ER HER MAGIEN SKAL INDSÆTTES *//

                    lineBinary.push_back(lineAssembly.at(i)); // Gemmer assembly-linjen til output.

                    //* DET ER HER MAGIEN SKAL INDSÆTTES *//

                }
            }

            int outputLineNumber = lineBinary.size(); //Gemmer størrelsen af lineBinary-vektoren til senere brug.

//*******************************************************************************************//
//*******************************************************************************************//
//* Print output                                                                            *//
//*******************************************************************************************//
//*******************************************************************************************//

            cout << "*** Output for " << fileBinary << " ***" << '\n';
            cout << "Line | Binary" << '\n';
            for (int i = 0; i < outputLineNumber; i++) { // Kører for hver linje gemt i lineBinary-vektoren.
                cout << setw(4) << i << " | " << lineBinary.at(i) << '\n'; // Print linjens indhold + linjeskift.
            }

//*******************************************************************************************//
//*******************************************************************************************//
//* Åben og skriv til output-fil                                                            *//
//*******************************************************************************************//
//*******************************************************************************************//

            string output = ""; // Initierer en tom output-string.

            for (int i = 0; i < outputLineNumber; i++) { // Kører for hver linje gemt i lineBinary-vektoren.
                output.append(lineAssembly.at(i)); // Gemmer samtlige linjer i output-vektoren i én output-string.
            }

            //cout << '\n' << "*** Generated output ***" << '\n' << output << '\n';

            ofstream binary(fileBinary, ios::trunc); // Åben binary-filen, så den er klar til at blive skrevet til.
            if (binary.is_open()) { // Kører hvis binary-filen er åben.
                binary << output; // Skriv det genererede output til binary-filen.
            }
            else {
                cout << "Could not write to " << fileBinary; //Meddeler at output-filen ikke kunne åbnes.
                runConvertion = false; // Afslut programmet hvis binary-filen ikke kunne åbnes.
            }

            binary.close(); // Luk binary-filen, da den ikke skal bruges længere.

            if(runConvertion) { // Kører kun hvis binary-filen kunne åbnes.

//*******************************************************************************************//
//*******************************************************************************************//
//* Tjek output-fil.                                                            *//
//*******************************************************************************************//
//*******************************************************************************************//

                cout << '\n' << "*** Verifying output file ***" << '\n';

                ifstream verify(fileBinary); // Åben binary-filen, så indholdet kan verificeres.

                if(verify.is_open()) { // Kører hvis binary-filen er åben.
                    string line; // Lokal string til test af binary-filens indhold.
                    if(getline(verify, line)) { // Kører kun hvis filen ikke er tom.
                        if(line == output) { // Kører kun hvis filens indhold matcher output-stringen.
                            cout << "Output was correctly written to " << fileBinary;
                        }
                        else {
                            cout << "Output doesn't match contents of " << fileBinary;
                        }
                    }
                    else {
                        cout << "Nothing was written to " << fileBinary;
                    }
                }
                else {
                    cout << "Could not read from " << fileBinary;
                }

                verify.close(); // Luk binary-filen, da den ikke skal bruges længere.

//*******************************************************************************************//
//*******************************************************************************************//
//* Program er færdigt og genstarter                                                        *//
//*******************************************************************************************//
//*******************************************************************************************//
            }
        }

        cout << '\n' << '\n' << "*** Program finished ***" << '\n' << '\n';

    }

    return 0;
}
