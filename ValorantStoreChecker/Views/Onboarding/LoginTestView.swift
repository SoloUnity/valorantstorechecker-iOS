//
//  LoginTestView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-25.
//

import SwiftUI

struct LoginTestView: View {
    
    @StateObject private var accountListVM = AccountListViewModel()
    @StateObject private var loginModel = LoginViewModel()
    
    var body: some View {
        Button("Get Accounts") {
            accountListVM.getAllAccounts()
        }
        .padding()
        .background(Color.pink)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        
        if loginModel.isAuthenticated && accountListVM.accounts.count > 0 {
            List(accountListVM.accounts, id: \.id) { account in
                HStack {
                    Text("\(account.name)")
                    Spacer()
                    Text(String(format: "$%.2f", account.balance))
                }
            }.listStyle(PlainListStyle())
        } else {
            Text("Login to see your accounts!")
        }
    }
}

struct LoginTestView_Previews: PreviewProvider {
    static var previews: some View {
        LoginTestView()
    }
}
