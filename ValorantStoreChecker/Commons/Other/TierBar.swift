//
//  TierBar.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-25.
//

import SwiftUI

struct TierBar: View {
    var contentTierUuid : String
    var clip = ""
    
    let clipPixels = 25
    
    var body: some View {
        switch contentTierUuid {
        case "12683d76-48d7-84a3-4e09-6985794f0445":
            ZStack {
                
                if clip == "" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -10)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: 10)
                }
                else if clip == "top" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: CGFloat(clipPixels))
                    
                }
                else if clip == "bottom" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -CGFloat(clipPixels))
                     

                }
                else {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 110)
                        
                    
                }
                
                
                
            }
                .frame(width: 2)
                .foregroundColor(Color(red: 107/255, green: 157/255, blue: 220/255))
                .shadow(color: Color(red: 107/255, green: 157/255, blue: 220/255), radius: 4)
            
        case "0cebb8be-46d7-c12a-d306-e9907bfc5a25":
            
            ZStack {
                if clip == "" {
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -10)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: 10)
                }
                else if clip == "top" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: CGFloat(clipPixels))
                    
                }
                else if clip == "bottom" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -CGFloat(clipPixels))
                     

                }
                else {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 110)
     
                    
                }
            }
                .frame(width: 2)
                .foregroundColor(Color(red: 69/255, green: 154/255, blue: 133/255))
                .shadow(color: Color(red: 69/255, green: 154/255, blue: 133/255), radius: 4)
            
        case "60bca009-4182-7998-dee7-b8a2558dc369":
            
            ZStack {
                if clip == "" {
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -10)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: 10)
                }
                else if clip == "top" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: CGFloat(clipPixels))
                    
                }
                else if clip == "bottom" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -CGFloat(clipPixels))
                     

                }
                else {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 110)
  
                    
                }
            }
                .frame(width: 2)
                .foregroundColor(Color(red: 194/255, green: 93/255, blue: 138/255))
                .shadow(color: Color(red: 194/255, green: 93/255, blue: 138/255), radius: 4)
            
        case "411e4a55-4e59-7757-41f0-86a53f101bb5":
            
            ZStack {
                if clip == "" {
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -10)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: 10)
                }
                else if clip == "top" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: CGFloat(clipPixels))
                    
                }
                else if clip == "bottom" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -CGFloat(clipPixels))
                     

                }
                else {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 110)

                    
                }
            }
                .frame(width: 2)
                .foregroundColor(Color(red: 245/255, green: 215/255, blue: 117/255))
                .shadow(color: Color(red: 245/255, green: 215/255, blue: 117/255), radius: 4)
            
        case "e046854e-406c-37f4-6607-19a9ba8426fc":
            
            ZStack {
                if clip == "" {
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -10)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: 10)
                }
                else if clip == "top" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: CGFloat(clipPixels))
                    
                }
                else if clip == "bottom" {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .offset(y: -CGFloat(clipPixels))
                     

                }
                else {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: 110)
                    
                }
            }
                .frame(width: 2)
                .foregroundColor(Color(red: 235/255, green: 152/255, blue: 100/255))
                .shadow(color: Color(red: 235/255, green: 152/255, blue: 100/255), radius: 4)
            
            
        default:
            EmptyView()
            
        }
    }
}


