//
//  LoginView.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//

import SwiftUI

struct LoginView: View {
    @State private var identification_number: String = ""
    @State private var isIdentificationValid: Bool = false
    @State private var isImagePickerPresented: Bool = false
    @State private var isGKVScanned: Bool = false
    private let gkvScannerService: GKVScannerService = GKVScannerService()
    @State private var selectedImage: UIImage?
    var databaseService: DatabaseService
    
    @State private var id_gkv: String = "" {
        didSet {
            checkIdentificationFormat(identification_number: id_gkv)
            print("Identification Valid?: \(isIdentificationValid)")
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                Text("Bitte Geben sie untenstehend Ihre **Persönliche Kennnummer** der **Rückseite** Ihrer EGK ein. \nSie können die Rückseite der Karte alternativ einscannen.")
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            Image("Ecard-rueckseite")
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 160)
                .padding()
            
            if !isGKVScanned {
                TextField("Kennnummer eingeben", text: $id_gkv)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: id_gkv) {oldValue, newValue in
                        checkIdentificationFormat(identification_number: newValue)
                    }
                    .foregroundStyle(isIdentificationValid ? .green : .red)
            } else {
                TextField("GKV-Nummer: ", text: $id_gkv)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: id_gkv) {oldValue, newValue in
                        checkIdentificationFormat(identification_number: newValue)
                    }
                    .foregroundStyle(isIdentificationValid ? .green : .red)
            }
            
            
            if !isIdentificationValid && !id_gkv.isEmpty {
                Text("**Ungültiges Format der Kennnummer**, Bitte erneut Scannen oder Eingabe überprüfen")
                    .foregroundColor(.red)
                    .padding()
            }
           
            VStack(spacing: 5) {
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    HStack {
                        Image(systemName: "camera.viewfinder")
                            .padding()
                        Text("Scannen")
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                }
                .padding()
                
                Button(action: {
                    loginUser()
                }) {
                    HStack {
                        Image(systemName: "lock.open")
                            .padding()
                        Text("Anmelden")
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundStyle(.white)
                }
                .padding()
            }
        }
    }
}

#Preview {
    @Environment(\.managedObjectContext) var managedObjectContext
    LoginView(databaseService: DatabaseService(context: managedObjectContext))
}

extension LoginView {
    func checkIdentificationFormat(identification_number: String) {
        let pattern = "^[A-Z][0-9]{9}$"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let range = NSRange(location: 0, length: identification_number.utf16.count)
            if regex.firstMatch(in: identification_number, options: [], range: range) != nil {
                isIdentificationValid = true
            } else {
                isIdentificationValid = false
            }
        }
    }
    
    func loginUser() {
        // Prüfen, ob die Kennnummer in der Datenbank existiert
        // Beispiel: if database.checkUser(kennnummer) { ... }
        let userExists = checkUserInDatabase(identification_number: identification_number)
        
        if userExists {
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.set(identification_number, forKey: "userIdentification")
            // Wechseln Sie hier zur Hauptansicht Ihrer App oder führen Sie andere Aktionen aus
        } else {
            // Benachrichtigen Sie den Benutzer, dass die Kennnummer ungültig ist
        }
    }
    
    func checkUserInDatabase(identification_number: String) -> Bool {
        // Hier kommt Ihre Logik zur Überprüfung der Kennnummer in der Datenbank
        // Beispiel: return database.userExists(kennnummer)
        return true // Hier nur als Beispiel
    }
    
}
