//
//  NetworkService.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2022-12-28.
//

import Foundation
import SwiftUI
import Network

class NetworkModel: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue (label: "Monitor")
    @AppStorage("isConnected") var isConnected = false
    @AppStorage("isMobileData") var isMobileData = false
    @AppStorage("isLowData") var isLowData = false
    @AppStorage("currentNetworkType") var networkType = ""
    
    
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                self.isMobileData = path.isExpensive
                self.isLowData = path.isConstrained
                
                let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi]
                let tempType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
                
                switch tempType {
                case .wifi:
                    self.networkType = "wifi"
                case .cellular:
                    self.networkType = "cellular"
                case .other:
                    self.networkType = ""
                default:
                    self.networkType = ""
                }
                
            }
        }
        monitor.start(queue: queue)
    }
    
    
}
