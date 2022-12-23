//
//  VideoPickerView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

struct VideoPickerView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @ObservedObject var skin:Skin
    @Binding var selectedLevel : Int
    @State var videoName = ""
    
    var body: some View {
        // MARK: Video Tier Picker
        HStack{
            HStack {
                Text(LocalizedStringKey("Tier"))
                    .bold()
                Text(String(selectedLevel + 1))
                    .bold()
                    .padding(-4)
            }
            
            
            
            Spacer()
            
            
            Menu {
                
                ForEach(0..<skin.levels!.count, id: \.self){ level in
                    
                    let videoTierName = cleanLevelName(name: String(skin.levels![level].levelItem ?? "null"))
                    
                    Button {
                        
                        self.selectedLevel = level
                        
                        if level == 0 {
                            self.videoName = ""
                        }
                        else if videoTierName == "null" {
                            self.videoName = "Tier \(level + 1)"
                        }
                        else {
                            self.videoName = videoTierName
                        }
                        
                    } label: {
                        
                        if level == 0 {
                            Text("Default1")
                        }
                        else if videoTierName == "null" {
                            Text("\(level + 1). " + "Tier \(level + 1)")
                        }
                        else {
                            Text("\(level + 1). " + videoTierName)
                        }
                        
                    }
                    
                    
                }
                
            } label: {
                
                
                HStack {
                    
                    if videoName == "" {
                        Text("Default")
                            .font(.footnote)
                            .bold()
                    }
                    else {
                        Text(videoName)
                            .font(.footnote)
                            .bold()
                    }
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.callout)
                }
                
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(Constants.pickerWhite)
            .cornerRadius(7)
            
        }
        .padding()
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

// Helper function
func cleanLevelName(name : String) -> String {
    
    if name == "Default"{
        return "Default"
    }else{
        let nameList = name.split(separator: ":")
        
        guard let last = nameList.last else{
            return "Unknown"
        }
        
        // Check if all string is uppercased
        if last == last.uppercased(){
            return String(last)
        }else{
            // Split into list of individual letters
            var characters = last.map{ String($0) }
            
            var count = 0
            
            // Insert space before Capital letters
            for letter in characters {
                
                if letter == letter.uppercased(){
                    characters.insert(" ", at: count)
                    count += 1
                }
                count += 1
                
            }
            
            // Assemble into string
            var finalString = ""
            
            for item in characters {
                finalString += item
            }
            
            return finalString.trimmingCharacters(in: .whitespaces)
        }
    }
}
