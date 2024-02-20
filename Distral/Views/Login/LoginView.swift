//
//  LoginView.swift
//  Distral
//
//  Created by Philipp Korn on 20.02.24.
//

import SwiftUI

struct LoginView: View {
    // identification Variables
    @State private var identification_number: String = ""
    @State private var isIdentificationValid: Bool = false
    // GKV scanning variables
    @State private var isImagePickerPresented: Bool = false
    @State private var isGKVScanned: Bool = false
    private let gkvScannerService: GKVScannerService = GKVScannerService()
    @State private var selectedImage: UIImage?
    // database
    var databaseService: DatabaseService
    // Login variables
    @State private var navigationTarget: NavigationTarget?
    @State private var showAlert: Bool = false
    @Binding var showTabsView: Bool
    @Binding var isUserLoggedIn: Bool
    
    @State private var id_gkv: String = "" {
        didSet {
            checkIdentificationFormat(identification_number: id_gkv)
            print("Identification Valid?: \(isIdentificationValid)")
        }
    }
    
    var body: some View {
        NavigationStack {
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
                        if checkUserInDatabase(identification_number: id_gkv) {
                            loginUser()
                        } else {
                            showAlert = true
                        }
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
            NavigationLink(value: navigationTarget) {
                    EmptyView()
            }
            .navigationDestination(for: NavigationTarget.self) {target in
                switch target {
                case .profile:
                    TabsView(selectedTab: .profile, isUserLoggedIn: $isUserLoggedIn)
                }
            }
            
            .alert(isPresented: $showAlert) {
                Alert (
                    title: Text("Profil anlegen"),
                    message: Text("Sie sind noch nicht in der Datenbank. \nMöchten Sie ein Profil anlegen?"),
                    primaryButton: .default(Text("Ja"), action: {
                        createUser()
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }
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
        let userExists = checkUserInDatabase(identification_number: id_gkv)
        
        if userExists {
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.set(id_gkv, forKey: "userIdentification")
            isUserLoggedIn = true
        } else {
            databaseService.addUser(id_gkv: id_gkv) { success in
                if success {
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    UserDefaults.standard.set(id_gkv, forKey: "userIdentification")
                    isUserLoggedIn = true
                } else {
                    print("Fehler beim Login des Users.")
                }
            }
        }
    }
    
    func checkUserInDatabase(identification_number: String) -> Bool {
        return databaseService.userExits(with: identification_number)
    }
    
    func createUser() {
        databaseService.addUser(id_gkv: id_gkv) { success in
            if success {
                loginUser()
            } else {
                print("LoginView: Anlegen des users hat nicht funktioniert")
            }
        }
    }
    
}
