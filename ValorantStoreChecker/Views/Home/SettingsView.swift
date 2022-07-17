//
//  SettingsView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-16.
//

import SwiftUI

struct SettingsView: View {
    
    @State var dark = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Settings lmao")
                .font(.title)
                .padding()
            
            Toggle("Dark Mode", isOn: $dark)
                .frame(width: 200)
            
            Spacer()
        }
        
            
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
