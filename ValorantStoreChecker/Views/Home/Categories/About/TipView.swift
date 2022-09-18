//
//  TipView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-08-17.
//

import SwiftUI
import Keychain
import StoreKit

struct TipView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @EnvironmentObject var tipModel : TipModel
    @State var title = LocalizedStringKey("Sponsor")
    @Binding var expand : Bool

    let tips : [Product]
    let keychain = Keychain()
    
    
    var body: some View {
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
                
                ForEach(tips, id: \.id) { tip in
                    tipButton(expand: $expand, tip: tip)
                }
                
                if tips.isEmpty {
                    HStack {
                        
                        Text(LocalizedStringKey("NetworkError"))
                            .bold()
                        
                        Spacer()
                        
                    }
                }
                
                /*
                tipButton(expand: $expand, index: 0)
                
                tipButton(expand: $expand, index: 1)
                
                tipButton(expand: $expand, index: 2)
                
                tipButton(expand: $expand, index: 3)
                */
            }
            
        }
        .foregroundColor(.white)
        .padding(7)
        .background(Color.pink)
        .cornerRadius(10)
        .animation(.spring(), value: expand)
        .shadow(color:.pink, radius: 2)
        
        
    }
    
    struct tipButton : View {
        
        @EnvironmentObject var tipModel : TipModel
        @Binding var expand : Bool
        @State private var errorTitle = ""
        @State private var isError = false
        
        let tip : Product
        
        var body: some View {
            
            Button {
                
                Task {
                    await purchase()
                }
                
                //tipModel.purchase(index: index)
                expand = false
         
            } label: {
                
                HStack {
                    

                    
                    Text(tip.displayPrice)
                }
            }
            .alert(LocalizedStringKey("ErrorTitle"), isPresented: $isError, actions: {
                
                Button(LocalizedStringKey("OK"), role: nil, action: {
                    isError = false
                })
                
                
            }, message: {
                
                Text(LocalizedStringKey("ErrorMessage3"))
                
            })
        }
        
        
        @MainActor
        func purchase() async {
            do {
                
                let _ = try await tipModel.purchase(tip)
                
            } catch StoreError.failedVerification {
                isError = true
            } catch {
                print("Failed fuel purchase: \(error)")
            }
        }
        
        
    }
}


