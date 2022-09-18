//
//  UpdatesView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-18.
//

import SwiftUI

struct UpdatesView: View {
    var body: some View {
        
        GeometryReader{ geo in
            
            ScrollView(showsIndicators: false){
                VStack (spacing: 20){
                    
                    HStack{
                        Text(LocalizedStringKey("UpdateButton"))
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                    }
                    
                    
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 20){
                            
                            HStack{
                                Text(LocalizedStringKey("WhatsNew"))
                                    .font(.title)
                                    .bold()
                                
                                Spacer()
                                
                            }
                            
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
                            
                            HStack{
                                Image(systemName: "chevron.up.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing)
                                
                                Text("\((defaults.string(forKey: "currentVersion") ?? "")) → \((defaults.string(forKey: "lastVersion") ?? ""))")
                                
                            }
                            
                        }
                        .padding()
                        
                        Spacer()
                    }
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

                    HStack{
                        VStack(alignment: .leading, spacing: 20){
                            
                            
                            Text(LocalizedStringKey("UpdateInstructions1"))
                                .bold()
                            
                            ForEach(0...3, id: \.self) { point in
                                HStack{
                                    Image(systemName: "\(String(point + 1)).circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .padding(.trailing)
                                    
                                    if point == 0 {
                                        Text(LocalizedStringKey("UpdateInstructions2"))
                                    }
                                    else if point == 1 {
                                        Text(LocalizedStringKey("UpdateInstructions3"))
                                    }
                                    else if point == 2 {
                                        Text(LocalizedStringKey("UpdateInstructions4"))
                                    }
                                    else if point == 3 {
                                        Text(LocalizedStringKey("UpdateInstructions5"))
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
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
                    
                    Button {
                        if let url = URL(string: Constants.URL.appStore) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        ZStack {
                            
                            RectangleView(colour: .pink)
                            
                            Text("UpdateTitle")
                                .foregroundColor(.white)
                        }
                        .frame(height: 50)
                        
                    }

                    
                    
                }
            }
            
        }
        .padding()
        

        
        
    }
}

struct UpdatesView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatesView()
    }
}
