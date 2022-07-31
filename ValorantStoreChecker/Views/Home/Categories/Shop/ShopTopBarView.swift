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
    
    let referenceDate: Date
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var body: some View {
        
        ZStack {
            RectangleView(colour: Constants.cardGrey)
                .shadow(color: .white, radius: 2)
            
            HStack {
                
                Image(systemName: "clock")
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, 5)
                    .padding(.leading)
                    .frame(width: 28, height: 28)
                
                Text(countDownString(from: referenceDate))
                            .onAppear(perform: {
                                _ = self.timer
                            })
                            .font(.caption)
                            
                
                Spacer()
                
                Button {
                    authAPIModel.reloading = true
                    Task{
                        await authAPIModel.reload()
                    }
                } label: {
                    if !authAPIModel.reloading{
                        Image(systemName: "arrow.clockwise")
                            .padding(.vertical, 5)
                            .padding(.trailing)
                    }else{
                        ProgressView()
                            .padding(.vertical, 5)
                            .padding(.trailing)
                    }
                    
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
        
        
        return String(format: "%02d:%02d:%02d",
                      components.hour ?? 00,
                      components.minute ?? 00,
                      components.second ?? 00)
    }
}


