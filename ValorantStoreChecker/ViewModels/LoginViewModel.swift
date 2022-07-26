//
//  LoginViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation

class LoginViewModel: ObservableObject{
    
    @Published var isAuthenticated: Bool = false
    var username: String = ""
    var password: String = ""
    
    
    func login(){
        
        let defaults = UserDefaults.standard
        
        WebService().login(username: username, password: password) { result in
            
            switch result{
                
            case .success(let token):
                print(token)
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async{
                    self.isAuthenticated = true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
           
       let defaults = UserDefaults.standard
       defaults.removeObject(forKey: "jsonwebtoken")
       DispatchQueue.main.async {
           self.isAuthenticated = false
       }
       
    }
    
}
