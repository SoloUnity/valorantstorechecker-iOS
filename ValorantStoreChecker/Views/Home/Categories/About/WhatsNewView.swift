//
//  WhatsNewView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-18.
//

import SwiftUI

struct WhatsNewView: View {
    
    @Binding var expand: Bool
    
    var body: some View {
        HStack{
            
            VStack(alignment: .leading, spacing: 20){
                
                Button {
                    
                    expand.toggle()
                    
                } label: {
                    
                    HStack{
                        
                        Text(LocalizedStringKey("WhatsNew"))
                            .bold()
                            .font(.title3)
                            
                        Spacer()
                        
                        Image(systemName: expand ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 13, height: 6)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    
                }
                
                if expand {
                    
                    let defaults = UserDefaults.standard
                    let releaseNotes = defaults.array(forKey: "releaseNotes") as? [String] ?? []
                    ForEach(0...releaseNotes.count - 1, id: \.self) { point in
                        HStack{
                            Image(systemName: "\(String(point + 1)).circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(.trailing)
                            
                            Text(releaseNotes[point])
                            
                        }
                    }
                    
                    
                    
                }
                
            }
            .animation(.spring(), value: expand)

            
            
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
    }
}



