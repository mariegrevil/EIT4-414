#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

int main() {

    cout << "*** Source file must be located in same folder as this program ***" << '\n'  << '\n'; // P�mindelse om at filen skal ligge i samme mappe.

    bool runProgram = true;
    while(runProgram) { // Programmet forts�tter i et uendeligt loop, s� man ikke skal genstarte programmet for at konvertere en ny fil.

//*******************************************************************************************//
//*******************************************************************************************//
//* Inds�t navn p� kildefil                                                                 *//
//*******************************************************************************************//
//*******************************************************************************************//

        bool runConvertion = true;

        string fileName; // String indeholdende navnet p� filen, der skal konverteres.

        cout << "Enter name of .txt source file: ";
        cin >> fileName; // Afventer input i form af filnavn.
        cout << '\n';

        string fileAssembly = fileName + ".txt"; // Gemmer input-filnavn.
        string fileBinary = fileName + "2.txt"; // Gemmer output-filnavn.

//*******************************************************************************************//
//*******************************************************************************************//
//* �ben og l�s fra input-fil                                                                *//
//*******************************************************************************************//
//*******************************************************************************************//

        vector<string> lineAssembly; // Vektor indeholdende alle de l�ste linjer fra assembly-filen.
        ifstream assembly(fileAssembly); // �ben assembly-filen, s� den er klar til at blive l�st.

        if (assembly.is_open()) { // K�rer hvis assembly-filen er �ben.
            string line; // Midlertidig string indeholdende den nuv�rende linje.
            while (getline(assembly, line)) { // K�rer s� l�nge der er en ny linje at l�se i assembly-filen.
                lineAssembly.push_back(line); // Tilf�j linjens indhold i lineAssembly-vektoren.
            }
        }
        else {
            cout << "Could not read from " << fileAssembly; //Meddeler at input-filen ikke kunne �bnes.
            runConvertion = false; // Afslut programmet hvis assembly-filen ikke kunne �bnes.
        }

        assembly.close(); // Luk assembly-filen, da den ikke skal bruges l�ngere.

        if(runConvertion) { // K�rer kun hvis assembly-filen kunne �bnes.

            int inputLineNumber = lineAssembly.size(); //Gemmer st�rrelsen af lineAssembly-vektoren til senere brug.

//*******************************************************************************************//
//*******************************************************************************************//
//* Print linjeindhold                                                                      *//
//*******************************************************************************************//
//*******************************************************************************************//

            cout << "*** Raw contents of " << fileAssembly << " ***" << '\n';
            cout << "Line | String" << '\n';
            for (int i = 0; i < inputLineNumber; i++) { // K�rer for hver linje gemt i lineAssembly-vektoren.
                cout << setw(4) << i << " | " << lineAssembly.at(i) << '\n'; // Print linjens indhold + linjeskift.
            }
            cout << '\n';

//*******************************************************************************************//
//*******************************************************************************************//
//* Gener�r output - DET ER HER MAGIEN SKER                                                 *//
//*******************************************************************************************//
//*******************************************************************************************//

            vector<string> lineBinary; // Vektor indeholdende alle de konverterede linjer fra assembly-filen til output.

            for (int i = 0; i < inputLineNumber; i++) { // K�rer for hver linje gemt i lineAssembly-vektoren.
                if(lineAssembly.at(i) != ""){ // K�rer kun hvis linjen ikke er tom.

                    //* DET ER HER MAGIEN SKAL INDS�TTES *//

                    lineBinary.push_back(lineAssembly.at(i)); // Gemmer assembly-linjen til output.

                    //* DET ER HER MAGIEN SKAL INDS�TTES *//

                }
            }

            int outputLineNumber = lineBinary.size(); //Gemmer st�rrelsen af lineBinary-vektoren til senere brug.

//*******************************************************************************************//
//*******************************************************************************************//
//* Print output                                                                            *//
//*******************************************************************************************//
//*******************************************************************************************//

            cout << "*** Output for " << fileBinary << " ***" << '\n';
            cout << "Line | Binary" << '\n';
            for (int i = 0; i < outputLineNumber; i++) { // K�rer for hver linje gemt i lineBinary-vektoren.
                cout << setw(4) << i << " | " << lineBinary.at(i) << '\n'; // Print linjens indhold + linjeskift.
            }

//*******************************************************************************************//
//*******************************************************************************************//
//* �ben og skriv til output-fil                                                            *//
//*******************************************************************************************//
//*******************************************************************************************//

            string output = ""; // Initierer en tom output-string.

            for (int i = 0; i < outputLineNumber; i++) { // K�rer for hver linje gemt i lineBinary-vektoren.
                output.append(lineAssembly.at(i)); // Gemmer samtlige linjer i output-vektoren i �n output-string.
            }

            //cout << '\n' << "*** Generated output ***" << '\n' << output << '\n';

            ofstream binary(fileBinary, ios::trunc); // �ben binary-filen, s� den er klar til at blive skrevet til.
            if (binary.is_open()) { // K�rer hvis binary-filen er �ben.
                binary << output; // Skriv det genererede output til binary-filen.
            }
            else {
                cout << "Could not write to " << fileBinary; //Meddeler at output-filen ikke kunne �bnes.
                runConvertion = false; // Afslut programmet hvis binary-filen ikke kunne �bnes.
            }

            binary.close(); // Luk binary-filen, da den ikke skal bruges l�ngere.

            if(runConvertion) { // K�rer kun hvis binary-filen kunne �bnes.

//*******************************************************************************************//
//*******************************************************************************************//
//* Tjek output-fil.                                                            *//
//*******************************************************************************************//
//*******************************************************************************************//

                cout << '\n' << "*** Verifying output file ***" << '\n';

                ifstream verify(fileBinary); // �ben binary-filen, s� indholdet kan verificeres.

                if(verify.is_open()) { // K�rer hvis binary-filen er �ben.
                    string line; // Lokal string til test af binary-filens indhold.
                    if(getline(verify, line)) { // K�rer kun hvis filen ikke er tom.
                        if(line == output) { // K�rer kun hvis filens indhold matcher output-stringen.
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

                verify.close(); // Luk binary-filen, da den ikke skal bruges l�ngere.

//*******************************************************************************************//
//*******************************************************************************************//
//* Program er f�rdigt og genstarter                                                        *//
//*******************************************************************************************//
//*******************************************************************************************//
            }
        }

        cout << '\n' << '\n' << "*** Program finished ***" << '\n' << '\n';

    }

    return 0;
}
