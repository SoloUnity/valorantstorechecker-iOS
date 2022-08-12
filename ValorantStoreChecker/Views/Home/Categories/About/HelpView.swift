//
//  HelpView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-08-02.
//  Tipping from https://www.youtube.com/watch?v=JJG3xI5FmFY

import SwiftUI


struct HelpView: View {
    
    //@StateObject var tipModel = TipModel()
    
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text(LocalizedStringKey("Help"))
                    .bold()
                    .font(.title3)
                
                Text(LocalizedStringKey("HelpMessage"))
                    .font(.footnote)
                
                HStack{
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                    
                    Button {
                        
                        // Valid link when app goes live
                        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
                        //       You can find the App Store ID in your app's product URL
                        guard let writeReviewURL = URL(string: Constants.URL.review)
                            else { fatalError("Expected a valid URL") }
                        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
                        
                    } label: {
                        Text(LocalizedStringKey("Review"))
                            .bold()
                        
                        
                        Image(systemName: "link")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(.trailing)
                    }
                    
                }
                
                // TODO: Implement tip
                /*
                if let tip = tipModel.tips.first {
                    HStack{
                        Image(systemName: "heart.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                        
                        Button {
                            
                            tipModel.purchase()
                            
                        } label: {
                            Text(LocalizedStringKey("Sponsor"))
                                .bold()
                            
                            Image(systemName: "link")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(.trailing)
                        }
                        
                    }
                }
                */
                
                
                
            }
            
            Spacer()
            
        }
        .padding()
        .foregroundColor(.white)
        .background(Blur(radius: 25, opaque: true))
        .cornerRadius(10)
        .overlay{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 3)
                .offset(y: -1)
                .offset(x: -1)
                .blendMode(.overlay)
                .blur(radius: 0)
                .mask {
                    RoundedRectangle(cornerRadius: 10)
                }
        }
        /*
        .onAppear {
            tipModel.fetchTips()
        }
         */
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
