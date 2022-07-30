//
//  ShopTopBarView.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-30.
//

import SwiftUI

struct ShopTopBarView: View {
    
    @EnvironmentObject var authAPIModel : AuthAPIModel
    @State var nowDate: Date = Date()
    
    var colour:Color = Color(red: 40/255, green: 40/255, blue: 40/255)
    
    let referenceDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        
        ZStack {
            RectangleView(colour: colour)
                .shadow(color: .white, radius: 2)
            
            HStack {
                
                Text(countDownString(from: referenceDate))
                            .onAppear(perform: {
                                _ = self.timer
                            })
                            .padding(.leading)
                            .font(.caption)
                            
                
                Spacer()
                
                Button {
                    Task{
                        await authAPIModel.login()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.red)
                        .padding(.vertical, 5)
                        .padding(.trailing)
                }
            }
        }
    }
    
    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        
        let components = calendar
            .dateComponents([.hour, .minute, .second],
                            from: nowDate,
                            to: date)
        
        
        return String(format: "%02dh:%02dm:%02ds",
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
}


