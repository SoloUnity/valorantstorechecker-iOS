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
    
    
    func getStore(token : String , riotEntitlement : String, puuid : String) {
        
        let webService = WebService()
        
        /*
        webService.getStorefront(token: token, riotEntitlement: riotEntitlement, puuid: puuid, region: region) { result in
            
            // TODO: Make this more efficient
            switch result{
            case .success(let storefront):
                let skinModel = SkinModel()
                for skin in skinModel.data{
                    for level in skin.levels!{
                        for item in storefront{
                            if item == level.id.description.lowercased(){
                                DispatchQueue.main.async {
                                    self.storefront.append(skin)
                                }
                            }
                        }
                    }
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
             
        }
        */
    }
}





