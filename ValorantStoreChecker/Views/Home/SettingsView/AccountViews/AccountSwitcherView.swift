//
//  AccountSwitcherView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-23.
//

import SwiftUI

struct AccountSwitcherView: View {
    
    @State var account = 0
    
    var body: some View {
        HStack{
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.teal)
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .foregroundColor(.white)
            }
            .frame(width: 30, height: 30, alignment: .center)
            .padding(.trailing)
            
            //LOCALIZETEXT
            Text(LocalizedStringKey("SwitchAccounts"))
            
            Spacer()

            HStack {
                
                Picker("", selection: $account){
                    
                    Text("Account 1")
                        .tag(0)
                    
                    Text("Account 2")
                        .tag(1)
                    
                    Text("Account 3")
                        .tag(2)
                    
                    Text("Account 4")
                        .tag(3)
                }
                .pickerStyle(MenuPickerStyle())
                
                if #available(iOS 16, *) {
                    // code that should only run on iOS 16 and above
                } else {
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(.pink)
                }
            }
            

        }
    }
}

struct AccountSwitcherView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSwitcherView()
    }
}
