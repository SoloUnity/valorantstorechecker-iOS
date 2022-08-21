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
                            
                        if expand {
                            
                            Spacer()
                            
                        }
                        
                        Image(systemName: expand ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 13, height: 6)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    
                }
                
                if expand {
                    
                    tipButton(expand: $expand, index: 0)
                    
                    tipButton(expand: $expand, index: 1)
                    
                    tipButton(expand: $expand, index: 2)
                    
                    tipButton(expand: $expand, index: 3)
                    
                }
                
            }
            .foregroundColor(.white)
            .padding(7)
            .background(Color.pink)
            .cornerRadius(10)
            .animation(.spring(), value: expand)
            .shadow(color:.pink, radius: 2)

            
 
        }
        .onAppear {
            tipModel.fetchTips()
        }
        
        
    }
    
    struct tipButton : View {
        
        @EnvironmentObject var tipModel : TipModel
        @Binding var expand : Bool
        var index : Int
        
        
        var body: some View {
            Button {
                
                tipModel.purchase(index: index)
                expand = false
                
            } label: {
                
                HStack {
                    
                    Text(tipModel.tips[index].displayName)
                        .bold()
                    
                    Spacer()
                    
                    Text(tipModel.tips[index].displayPrice)
                }
            }
        }
    }
}


