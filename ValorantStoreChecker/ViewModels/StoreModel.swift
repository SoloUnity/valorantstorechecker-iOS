//
//  AccountListViewModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-24.
//

import Foundation

class StoreModel: ObservableObject {
    
    @Published var storefront : [Skin] = []
    @Published var region = "na"
    
    
    func getStore(token : String , riotEntitlement : String, puuid : String) async {
        do{
            
            let storefront = try await WebService.getStorefront(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: self.region)
            
            let skinModel = SkinModel()
            
            for skin in skinModel.data{
                for level in skin.levels!{
                    for item in storefront{
                        if item == level.id.description.lowercased(){
                            self.storefront.append(skin)
                        }
                    }
                }
            }
            
        }catch{
            
            print(error.localizedDescription)
            
        }
    }
}





