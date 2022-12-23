//
//  TitleView.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-22.
//

import SwiftUI

extension UIApplication {
    
    static let keyWindow = keyWindowScene?.windows.filter(\.isKeyWindow).first
    static let keyWindowScene = shared.connectedScenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
    
}

extension View {
    
    // Share button
    func shareSheet(isPresented: Binding<Bool>, items: [Any]) -> some View {
        
        guard isPresented.wrappedValue else { return self }
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        let presentedViewController = UIApplication.keyWindow?.rootViewController?.presentedViewController ?? UIApplication.keyWindow?.rootViewController
        activityViewController.completionWithItemsHandler = { _, _, _, _ in isPresented.wrappedValue = false }
        presentedViewController?.present(activityViewController, animated: true)
        return self
        
    }
}

struct TitleView: View {
    
    @EnvironmentObject var skinModel:SkinModel
    @ObservedObject var skin:Skin
    
    @State private var isPresentingShareSheet = false
    
    var body: some View {
        // MARK: Title header
        HStack{
            
            if skin.contentTierUuid != nil{
                PriceTierView(contentTierUuid: skin.contentTierUuid!, dimensions: 30)
            }else{
                Image(systemName: "questionmark.circle")
                    .frame(width: 30, height: 30)
            }
            
            
            Text (String(skin.displayName))
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            
            Spacer()
            
            // MARK: Share Button
            Button {
                DispatchQueue.main.async {
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
    }
}

