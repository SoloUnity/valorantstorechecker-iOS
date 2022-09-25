//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct AboutView: View {
    
    @State var showSettings = false
    @State var expandCommunity = true
    @State var expandSupport = false
    @State var expandWhatsNew = false
    @State var expandHelp = true
    @State var expandTip = false
    @State var expandAcknowledgements = false
    @State var expandCopyright = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        GeometryReader{ geo in
            
            ScrollView(showsIndicators: false){
                VStack (spacing: 20){
                    
                    HStack{
                        Text(LocalizedStringKey("About"))
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        
                        Button {
                            
                            self.showSettings = true
                            
                        } label: {
                            
                            Image(systemName: "gear")
                            
                        }
                        
                        
                    }
                    
                    let defaults = UserDefaults.standard
                    let releaseNotes = defaults.array(forKey: "releaseNotes") as? [String] ?? []
                    
                    AccountView()
                    
                    CommunityView(expand: $expandCommunity)
                    
                    HelpView(expandMain: $expandHelp, expandTip: $expandTip)
                    
                    SupportView(expand: $expandSupport)
                    
                    if !releaseNotes.isEmpty {
                        WhatsNewView(expand: $expandWhatsNew)
                    }
                    
                    
                    
                    
                    AcknowledgementsView(expand: $expandAcknowledgements)
                    
                    CopyrightView(expand: $expandCopyright)
                    
                    HStack {
                        
                        Text("MadeIn")
                            .bold()
                        
                        
                        Spacer()
                        
                        Text("v" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!)
                            .font(.caption2)
                            .opacity(0.5)
                        
                        
                        Spacer()
                        
                        HStack {
                            Text("MadeWith")
                                .bold()
                            
                            Image("swiftui")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        
                    }

                    
                }
            }
            
        }
        .padding(.bottom, 1)
        .padding([.horizontal, .top])
        .sheet(isPresented: $showSettings) {
            SettingsView(referenceDate: defaults.object(forKey: "timeLeft") as? Date ?? Date())
                .preferredColorScheme(.dark)
        }
        .animation(.spring(), value: expandCommunity)
        .animation(.spring(), value: expandSupport)
        .animation(.spring(), value: expandWhatsNew)
        .animation(.spring(), value: expandHelp)
        .animation(.spring(), value: expandTip)
        .animation(.spring(), value: expandAcknowledgements)
        .animation(.spring(), value: expandCopyright)
    }
}

struct AboutView_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutView()
    }
}



