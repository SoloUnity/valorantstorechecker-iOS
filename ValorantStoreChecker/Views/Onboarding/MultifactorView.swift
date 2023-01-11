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
    @EnvironmentObject private var networkModel : NetworkModel
    @EnvironmentObject private var alertModel : AlertModel
    
    var body: some View {
        
        GeometryReader { geo in
            VStack{
                
                Logo()
                    .frame(height: 70)
                
                Spacer()
                
                // MARK: General info
                VStack(alignment: .leading){
                    
                    
                    
                    if !authAPIModel.multifactorFailure {
                        
                        Text(LocalizedStringKey("EnterTheCode"))
                            .font(.title3)
                            .bold()
                        
                         Text(authAPIModel.multifactorEmail)
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
                            
                            TextField(LocalizedStringKey("TwoFactorAuthentication") , text: $authAPIModel.inputMultifactor)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .disableAutocorrection(true)
                                
                            
                        }.padding(.horizontal).frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            .frame(maxWidth:.infinity , minHeight:45, maxHeight: 45)
                            .foregroundColor(authAPIModel.multifactorFailure ? .red : .white)
                            
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .offset(y: -50)
                
                Spacer()
                
                if authAPIModel.inputMultifactor.count == 6 {
                    Button {
                        
                        haptic()
                        
                        if networkModel.isConnected {
                            
                            authAPIModel.multifactorAnimation = true
                            
                            Task {
                                await authAPIModel.multifactor(skinModel: skinModel)
                            }
                            
                        }
                        else {
                            
                            withAnimation(.easeIn) {
                                alertModel.alertNoNetwork = true
                            }
                            
                        }
                        
                        
                        
                    } label: {
                        
                        if !authAPIModel.multifactorAnimation {
                            
                            ZStack{
                                RectangleView()
                                    .shadow(color:.pink, radius: 2)
                                    .cornerRadius(15)
                                
                                //LOCALIZETEXT
                                Text("Enter")
                                    .bold()
                                    .padding(15)
                                    .foregroundColor(.white)
                                
                                
                            }
                            .frame(height: Constants.dimensions.circleButtonSize)
                        }
                        else{
                            
                            ZStack{
                                RectangleView()
                                    .shadow(color:.pink, radius: 2)
                                    .cornerRadius(15)
                                
                                ProgressView()
                                    .tint(.white)
                                
                            }
                            .frame(height: Constants.dimensions.circleButtonSize)

                        }
                        
                    }
                }
                else {
                    ZStack{
                        RectangleView()
                            .cornerRadius(15)
                            .preferredColorScheme(.dark)
                        
                        Text("Enter")
                            .bold()
                            .padding(15)
                            .foregroundColor(.white)
                            
                    }
                    .frame(height: Constants.dimensions.circleButtonSize)
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
