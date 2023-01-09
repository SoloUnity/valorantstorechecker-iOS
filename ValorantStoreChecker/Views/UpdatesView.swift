//
//  UpdatesView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-09-18.
//

import SwiftUI

struct UpdatesView: View {
    
    @State private var expand = false
    
    var body: some View {
        
        VStack {
            HStack {
                Text(LocalizedStringKey("UpdateButton"))
                    .font(.title)
                    .bold()

                
                Spacer()
                
            }
            
            VStack {
                
                VStack {
                    // Whats new
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
                            
                            if releaseNotes.count > 0 {
                                ForEach(0...releaseNotes.count - 1, id: \.self) { point in
                                    HStack{
                                        Image(systemName: "\(String(point + 1)).circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                            .padding(.trailing)
                                        
                                        Text(releaseNotes[point])
                                        
                                    }
                                }
                            }
                            
                            
                            HStack{
                                Image(systemName: "chevron.up.circle")
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

                    Divider()
                    
                    
                    // Instructions
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 20){
                            
                            Button {
                                
                                expand.toggle()
                                
                            } label: {
                                
                                HStack{
                                    
                                    Text(LocalizedStringKey("UpdateInstructions1"))
                                        .bold()
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                    
                                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                                        .resizable()
                                        .frame(width: 13, height: 6)
                                        .multilineTextAlignment(.trailing)
                                }
                                
                                
                            }
                            
                            if expand {
                                
                                ForEach(0...3, id: \.self) { point in
                                    HStack{
                                        Image(systemName: "\(String(point + 1)).circle")
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
                            
                        }
                        .animation(.spring(), value: expand)
                        
                        Spacer()
                        
                    }
                    .padding()
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))

                
                Spacer()
                
                
                // Update Button
                Button {
                    if let url = URL(string: Constants.URL.appStore) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    
                    ZStack{
                        RectangleView()
                            .shadow(color: .pink, radius: 2)
                            .cornerRadius(15)
                        
                        Text("UpdateTitle")
                            .bold()
                            .padding(15)
                            .foregroundColor(.white)
                            
                    }
                    .frame(height: Constants.dimensions.circleButtonSize)

                }
                
            }
            .navigationTitle(Text(LocalizedStringKey("UpdateButton")))
            
        }
        .padding()
        

    }
}
