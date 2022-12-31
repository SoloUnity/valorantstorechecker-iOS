//
//  SwiftUIView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-01.
//

import SwiftUI

struct MultifactorView: View {
    
    @EnvironmentObject private var authAPIModel : AuthAPIModel
    @EnvironmentObject private var skinModel : SkinModel
    
    var body: some View {
        
        GeometryReader { geo in
            VStack{
                
                Logo()
                    .frame(height: 70)
                
                Spacer()
                
                // MARK: General info
                VStack(alignment: .leading){
                    
                    Text(LocalizedStringKey("EnterTheCode"))
                        .font(.title3)
                        .bold()
                    
                    if !authAPIModel.failedLogin {
                        
                         Text(authAPIModel.email)
                            .bold()
                            
                    }else {
                        Text(LocalizedStringKey("InvalidCode"))
                            .bold()
                    }
                    
                    // MARK: 2fa code box
                    ZStack {
                        HStack {
                            
                            Image(systemName: "lock")
                                .foregroundColor(.white)
                            
                            TextField(LocalizedStringKey("TwoFactorAuthentication") , text: $authAPIModel.multifactor)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                
                            
                        }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            .shadow(color: authAPIModel.failedLogin ? .red : .white, radius: 2)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            .foregroundColor(authAPIModel.failedLogin ? .red : .white)
                            
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .offset(y: -50)
                
                Spacer()
                
                if authAPIModel.multifactor.count >= 6 {
                    Button {
                        
                        authAPIModel.enteredMultifactor = true
                        
                        Task {
                            await authAPIModel.multifactor(skinModel: skinModel)
                        }
                        
                    } label: {
                        if !authAPIModel.enteredMultifactor {
                            ZStack {
                                CircleView(colour: .pink)
                                    .shadow(color:.pink, radius: 2)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(15)
                                    .foregroundColor(.white)
                                
                            }
                            .frame(width: Constants.dimensions.circleButtonSize, height: Constants.dimensions.circleButtonSize)
                        }
                        else {
                            ProgressView()
                                .frame(width: Constants.dimensions.circleButtonSize, height: Constants.dimensions.circleButtonSize)
                                .tint(.gray)
                        }
                    }
                }
                else {
                    ZStack {
                        CircleView(colour: .pink)
                            .shadow(color:.pink, radius: 2)
                        
                        Image(systemName: "arrow.right")
                            .resizable()
                            .scaledToFit()
                            .padding(15)
                            .foregroundColor(.white)
                        
                    }
                    .frame(width: Constants.dimensions.circleButtonSize, height: Constants.dimensions.circleButtonSize)
                    .opacity(0.5)
                }
                
                
            }
            .padding()
        }
        .background(Constants.bgGrey)
        .preferredColorScheme(.dark)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MultifactorView()
    }
}
