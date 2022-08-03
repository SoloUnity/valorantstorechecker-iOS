//
//  AssetsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//

import SwiftUI

struct AssetsView: View {
    
    @EnvironmentObject var skinModel : SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    var width: CGFloat = 200
    
    var body: some View {
        
        GeometryReader { geo in
            HStack{
                Spacer()
                VStack(spacing: 15) {
                    
                    Logo()
                        .frame(width: geo.size.width/4)
                        .padding(.top, 30)
                    
                    
                    Text("Before using the app, all assets must first be downloaded.")
                        .bold()
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    /*
                    ZStack (alignment: .leading){
                        RoundedRectangle (cornerRadius: 20, style: .continuous)
                            .frame (width: width, height: 20)
                            .foregroundColor(Color.white.opacity (0.1))
                        
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .frame(width: skinModel.percent * multiplier, height: 20)
                            .foregroundColor(.pink)
                            .animation(.spring(), value: skinModel.percent)
                    }
                    */
                    
                    
                    Spacer()
                    
                    Button {
                        /*
                        Task {
                            skinModel.getLocalData()
                            skinModel.getRemoteData()
                            authAPIModel.reload()
                        }
                        */
                        
                    } label: {
                        ZStack {
                            CircleView(colour: .pink)
                                .shadow(color:.pink, radius: 2)
                            
                            Image(systemName: "arrow.down.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                            
                        }
                        .frame(width: 60, height: 60)
                        .padding(.bottom, 50)
                    }
                    
                }
                Spacer()
            }
            

        }

        .background(Constants.bgGrey)
        .preferredColorScheme(.dark)
    }
}

struct AssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AssetsView()
    }
}
