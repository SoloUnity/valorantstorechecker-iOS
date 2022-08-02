//
//  SwiftUIView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-01.
//

import SwiftUI

struct MultifactorView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    
    var body: some View {
        
        GeometryReader { geo in
            VStack{
                
                Logo()
                    .frame(width: geo.size.width/4)
                
                // MARK: General info
                VStack{
                    
                    if !authAPIModel.failedLogin{
                        Text("Enter the code sent to")
                            .bold()
                        Text(authAPIModel.email)
                            .bold()
                    }else{
                        Text("Invalid Code")
                            .bold()
                    }
                    
                    // MARK: 2fa code box
                    ZStack {
                        HStack {
                            
                            Image(systemName: "lock")
                                .foregroundColor(.white)
                            
                            TextField("Two Factor Authentication" , text: $authAPIModel.multifactor)
                                .keyboardType(.numberPad)
                                .autocorrectionDisabled()
                                .foregroundColor(authAPIModel.failedLogin ? .red : .white)
                                .disableAutocorrection(true)
                                
                            
                        }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            .shadow(color: authAPIModel.failedLogin ? .red : .white, radius: 2)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            
                    }
                }
                .padding(.top, 25)
                
                Spacer()
                
                Button {
                    authAPIModel.enteredMultifactor = true
                    Task {
                        await authAPIModel.multifactor()
                    }
                } label: {
                    if !authAPIModel.enteredMultifactor {
                        ZStack{
                            CircleView(colour: .pink)
                                .shadow(color:.pink, radius: 2)
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .padding(15)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 60, height: 60)
                    }
                    else{
                        ProgressView()
                            .frame(width: 60, height: 60)
                    }
                    
                }
                
            }
            .padding(50)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MultifactorView()
    }
}
