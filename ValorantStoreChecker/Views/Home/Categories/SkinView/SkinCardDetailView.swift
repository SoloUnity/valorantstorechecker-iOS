//
//  WeaponCardDetailView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-17.
//

import SwiftUI
import AVKit
import AZVideoPlayer
//import GoogleMobileAds

extension UIApplication {
    
    static let keyWindow = keyWindowScene?.windows.filter(\.isKeyWindow).first
    static let keyWindowScene = shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    
}

extension View {
    
    func shareSheet(isPresented: Binding<Bool>, items: [Any]) -> some View {

        guard isPresented.wrappedValue else { return self }
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        let presentedViewController = UIApplication.keyWindow?.rootViewController?.presentedViewController ?? UIApplication.keyWindow?.rootViewController
        activityViewController.completionWithItemsHandler = { _, _, _, _ in isPresented.wrappedValue = false }
        presentedViewController?.present(activityViewController, animated: true)
        return self
        
    }
}

struct SkinCardDetailView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @ObservedObject var skin:Skin
    
    @State var selectedLevel = 0
    @State var selectedChroma = 0
    @State var showAlert = false
    @State var pickerStyle = SegmentedPickerStyle()
    @State var videoName = ""
    @State var colourName = ""
    @State var noVideo = false
    @State private var isPresentingShareSheet = false
    
    var price = ""
    
    private let player = AVPlayer()

    var body: some View {
        
        ZStack {
            GeometryReader{ geo in
                
                VStack(alignment: .leading, spacing: UIScreen.main.bounds.height / 40) {
                    
                    // MARK: Title header
                    HStack{
                        
                        
                        
                        if skin.contentTierUuid != nil{
                            PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 30)
                        }else{
                            Image(systemName: "questionmark.circle")
                                .frame(width: 30, height: 30)
                        }
                        
                        // Determine title size
                        let name = skin.displayName
                        Text (String(name))
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.4)
                        
                        Spacer()
                        
                        Button {
                            Dispatch.background {
                                self.isPresentingShareSheet = true
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height:20)
                        }
                        .shareSheet(isPresented: $isPresentingShareSheet, items: [URL(string: "https://valorantstore.net/skin/\(skin.id.description.lowercased())")!])

                        
                        
                    }
                    
                    
                        
                        VStack {
                            // MARK: Price
                            ZStack{
                                
                                
                                HStack{
                                    
                                    
                                    if skin.contentTierUuid != nil {
                                        let price = PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased())
                                        
                                        if price != "Unknown" {
                                            
                                            if skin.contentTierUuid == nil || (skin.contentTierUuid != nil && PriceTier.getRemotePrice(authAPIModel: authAPIModel, uuid: skin.levels!.first!.id.description.lowercased()) == "2475+") {
                                                
                                                Button {
                                                    showAlert = true
                                                } label: {
                                                    Image(systemName: "info.circle")
                                                        .accentColor(.white)
                                                }
                                                .alert(isPresented: $showAlert) { () -> Alert in
                                                    Alert(title: Text(LocalizedStringKey("InfoPrice")))
                                                }
                                            }
                                            
                                            Text(LocalizedStringKey("Cost"))
                                                .bold()
                                            
                                            Spacer()
                                            
                                            if self.price != "" {
                                                Image("vp")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 18, height: 18)
                                                
                                                Text(self.price)
                                                    .foregroundColor(.white)
                                                    .bold()
                                            }
                                            else {
                                                Image("vp")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 18, height: 18)
                                                
                                                Text(price)
                                                    .foregroundColor(.white)
                                                    .bold()
                                            }
                                            
                                            
                                        }
                                        else{
                                            
                                            Text(LocalizedStringKey("ExclusiveSkinMessage"))
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                        }
                                    }
                                    else{
                                        
                                        Text(LocalizedStringKey("ExclusiveSkinMessage"))
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                    }

                                }
                                .padding()
                                
           
                            }
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
                            
                            
                            
                            // MARK: Skin tier videos
                            if skin.levels!.first?.streamedVideo != nil {
                                ZStack {
                                    
                                    
                                    
                                    AZVideoPlayer(player: player)
                                        .cornerRadius(10)
                                        .aspectRatio(CGSize(width: 1920, height: 1080), contentMode: .fit)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color(red: 60/255, green: 60/255, blue: 60/255), lineWidth: 3)
                                                .offset(y: -1)
                                                .offset(x: -1)
                                                .mask {
                                                    RoundedRectangle(cornerRadius: 10)
                                                }
                                        }
                                        .onAppear{
                                            
                                            let url  = skin.levels![selectedLevel].streamedVideo
                                            if player.currentItem == nil && (url != nil) {
                                                
                                                self.noVideo = false
                                                let item = AVPlayerItem(url: URL(string: url!)!)
                                                player.replaceCurrentItem(with: item)
                                                
                                            }
                                            else if url == nil {
                                                self.noVideo = true
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                                player.play() // Autoplay
                                            })
                                            
                                            
                                        }
                                        .onChange(of: selectedLevel) { level in
                                            let url  = skin.levels![selectedLevel].streamedVideo
                                            if url == nil {
                                                self.noVideo = true
                                                player.replaceCurrentItem(with: nil)
                                            }
                                            else {
                                                self.noVideo = false
                                                let item = AVPlayerItem(url: URL(string: url!)!)
                                                player.replaceCurrentItem(with: item)
                                            }
                                            
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                                player.play() // Autoplay
                                            })
                                        }
                                        
                                    
                                    if noVideo {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .font(.title)
                                    }
                                    
                                }
                            }
                            
                            
                            
                            
                            if skin.levels!.count != 1 {
                                
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
                                    
                                    
                                    /*
                                     Picker("Video Number", selection: $selectedLevel){
                                     ForEach(0..<skin.levels!.count, id: \.self){ level in
                                     
                                     let videoTierName = cleanLevelName(name: String(skin.levels![level].levelItem ?? "Default"))
                                     if videoTierName == "Default" {
                                     Text(LocalizedStringKey("Default"))
                                     .tag(level)
                                     }
                                     else {
                                     Text("\(level). " + videoTierName)
                                     .tag(level)
                                     }
                                     
                                     
                                     }
                                     }
                                     .padding(.horizontal, 8)
                                     .pickerStyle(MenuPickerStyle())
                                     .background(.ultraThinMaterial)
                                     .cornerRadius(7)
                                     */
                                    
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
                            
                            
                            // MARK: Skin Variants / Chromas
                            HStack{
                                Spacer()
                                
                                if let imageData = UserDefaults.standard.data(forKey: skin.chromas![selectedChroma].id.description) {
                                    
                                    let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData)
                                    
                                    let uiImage = UIImage(data: decoded)
                                    
                                    Image(uiImage: uiImage ?? UIImage())
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                    
                                }
                                else if skin.chromas![selectedChroma].displayIcon != nil{
                                    
                                    AsyncImage(url: URL(string: skin.chromas![selectedChroma].displayIcon!)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .scaledToFit()
                                    .padding()
                                    
                                }
                                else if skin.chromas![selectedChroma].fullRender != nil{
                                    
                                    AsyncImage(url: URL(string: skin.chromas![selectedChroma].fullRender!)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .scaledToFit()
                                    .padding()
                                    
                                }
                                
                                
                                Spacer()
                            }
                            .frame(height: (UIScreen.main.bounds.height / 5.5))
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
                            

                            
                            // MARK: Skin Chroma Picker
                            if skin.chromas!.count != 1{
                                // Custom picker for images
                                HStack(spacing: 0) {
                                    
                                    ForEach(0..<skin.chromas!.count, id:\.self) { index in
                                        let isSelected = selectedChroma == index
                                        
                                        if let imageData = UserDefaults.standard.data(forKey: skin.chromas![index].id.description + "swatch") {
                                            
                                            let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData)
                                            
                                            let uiImage = UIImage(data: decoded)
                                            
                                            ZStack {
                                                Rectangle()
                                                    .fill(.ultraThinMaterial)
                                                
                                                Rectangle()
                                                    .opacity(isSelected ? 1 : 0.01)
                                                    .foregroundColor(Color(red: 120/255, green: 120/255, blue: 120/255))
                                                    .cornerRadius(10)
                                                    .padding(2)
                                                    .onTapGesture {
                                                        withAnimation(.interactiveSpring(response: 0.2,
                                                                                         dampingFraction: 2,
                                                                                         blendDuration: 0.5)) {
                                                            self.selectedChroma = index
                                                        }
                                                    }
                                            }
                                            .overlay(
                                                
                                                ZStack {
                                                    
                                                    Image(uiImage: uiImage ?? UIImage())
                                                        .resizable()
                                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                                        .frame(width: 25, height: 25)
                                                    
                                                }
                                                
                                                    
                                            )
                                            .frame(height: 35)
                                            
                                            
                                            
                                        }
                                        else if skin.chromas![selectedChroma].swatch != nil{
                                            ZStack {
                                                Rectangle()
                                                    .fill(.ultraThinMaterial)
                                                
                                                Rectangle()
                                                    .opacity(isSelected ? 1 : 0.01)
                                                    .foregroundColor(Color(red: 120/255, green: 120/255, blue: 120/255))
                                                    .cornerRadius(10)
                                                    .padding(2)
                                                    .onTapGesture {
                                                        withAnimation(.interactiveSpring(response: 0.2,
                                                                                         dampingFraction: 2,
                                                                                         blendDuration: 0.5)) {
                                                            self.selectedChroma = index
                                                        }
                                                    }
                                            }
                                            .overlay(
                                                
                                                ZStack {
                                                    
                                                    AsyncImage(url: URL(string: skin.chromas![index].swatch!)) { image in
                                                        image.resizable()
                                                    } placeholder: {
                                                        ProgressView()
                                                    }
                                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                                    .frame(width: 25, height: 25)
                                                        
                                                    
                                                }
                                                
                                                    
                                            )
                                            .frame(height: 35)
                                            
                                            
                                        }
                                        
                                    }
                                }
                                .cornerRadius(10)
                                .padding()
                                .background(Blur(radius: 25, opaque: true))
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
                                HStack{

                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    // Text based picker
                                    
                                    /*
                                    if pickerStyleChooser(skin: skin) {
                                        
                                        Menu {
                                            
                                            ForEach(0..<skin.chromas!.count, id: \.self){ chroma in
                                                
                                                let chromaName = cleanChromaName(name: (skin.chromas![chroma].displayName ?? "Default"))
                                                
                                                Button {
                                                    
                                                    self.selectedChroma = chroma
                                                    
                                                    if chromaName == "Default" {
                                                        self.colourName = ""
                                                    }
                                                    else {
                                                        self.colourName = chromaName
                                                    }
                                                    
                                                } label: {
                                                    if chromaName == "Default" {
                                                        Text("Default")
                                                    }
                                                    else {
                                                        Text(chromaName)
                                                    }
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                        } label: {
                                            
                                            HStack {
                                                
                                                if colourName == "" {
                                                    Text("Default")
                                                        .font(.footnote)
                                                        .bold()
                                                }
                                                else {
                                                    Text(colourName)
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
                                    else {
                                        
                                        
                                        Picker("Video Number", selection: $selectedChroma){
                                            ForEach(0..<skin.chromas!.count, id: \.self){ chroma in
                                                
                                                let chromaTierName = cleanChromaName(name: (skin.chromas![chroma].displayName ?? "Default"))
                                                if chromaTierName == "Default" {
                                                    Text(LocalizedStringKey("Default"))
                                                        .tag(chroma)
                                                }
                                                else {
                                                    Text(chromaTierName)
                                                        .tag(chroma)
                                                }
                                                
                                                
                                            }
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                                        .accentColor(.red)
                                        
                                        
                                    }
                                    */
                                    
                                    
                                }
                                 */
                            }
                            
                            
                            /*
                            if skin.levels!.first?.streamedVideo == nil {

                            }
                            */
                            
                            
                            
                            
                        }
                        
                        
                    

                }
                .foregroundColor(.white)
                .padding()
            }
            .background(LinearGradient(gradient: Constants.bgGradient, startPoint: .top, endPoint: .bottom))
            
            VStack {
                
                Spacer()
                
                CustomBannerView()
                    .padding()
                
            }
            
        }
        
    }
}


// MARK: Helper Functions
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

func cleanChromaName(name: String) -> String {
    
    if name == "Default" {
        return "Default"
    }else{
        
        // Remove irrelevant information
        if name.contains("(") {
            let bracket1 = name.split(separator: "(")
            let bracket2 = bracket1[1].split(separator: ")")
            var nameList = bracket2[0].split(separator: " ")
            nameList.removeFirst()
            nameList.removeFirst()
            
            var finalString = ""
            
            for item in nameList {
                finalString += item
            }
            
            return finalString
        }
        else{
            return "Default"
        }
    }
}

func pickerStyleChooser(skin: Skin) -> Bool {
    
    for item in skin.chromas! {
        if  cleanChromaName(name: (item.displayName ?? "Default")).count > 7 {
            
            return true
        }
        
    }
    return false
    
}


