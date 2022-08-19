//
//  TipView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-17.
//

import SwiftUI
import Keychain

struct TipView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var tipModel : TipModel
    @State var title = LocalizedStringKey("Sponsor")
    @Binding var expand : Bool

    let keychain = Keychain()
    
    var body: some View {
        VStack {
            
            
            VStack(alignment: .leading, spacing: 10){
                
                Button {
                    
                    expand.toggle()
                    
                } label: {
                    
                    HStack{
                        Text(title)
                            .bold()
                            .padding(.bottom, 4)
                            
                        
                        Spacer()
                        
                        Image(systemName: expand ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 13, height: 6)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    
                }
                
                if expand {
                    
                    tipButton(title: $title, expand: $expand, description: "Small Tip", price: 1, index: 0)
                    
                    tipButton(title: $title, expand: $expand, description: "Medium Tip", price: 5, index: 1)
                    
                    tipButton(title: $title, expand: $expand, description: "Big Tip", price: 10, index: 2)
                    
                    tipButton(title: $title, expand: $expand, description: "Epic Tip", price: 20, index: 3)
                    
                    tipButton(title: $title, expand: $expand, description: "Nice Tip", price: 69, index: 4)
                }
            }
            .foregroundColor(.white)
            .padding(7)
            .background(Color.pink)
            .cornerRadius(10)
            .animation(.spring(), value: expand)
            .shadow(color:.pink, radius: 2)
            .padding(.trailing, UIScreen.main.bounds.height / 7.5)
            
 
        }
        .onAppear {
            tipModel.fetchTips()
        }
        
        
    }
    
    struct tipButton : View {
        
        @EnvironmentObject var tipModel : TipModel
        @Binding var title : LocalizedStringKey
        @Binding var expand : Bool
        var description : String
        var price : Int
        var index : Int
        
        
        var body: some View {
            Button {
                
                tipModel.purchase(index: index)
                expand = false
                
            } label: {
                
                HStack {
                    
                    Text(description)
                    
                    Spacer()
                    
                    Text(String(price) + "$")
                }
            }
        }
    }
}


