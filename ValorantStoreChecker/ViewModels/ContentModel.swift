//
//  ContentModel.swift
//  ValorantStoreChecker
//
//  Created by Gordon Ng on 2022-07-15.
//

import Foundation

class ContentModel: ObservableObject{

    init(){
        
        
    }
    

    /* 2 factor authentication
     Method: PUT
     URL: https://auth.riotgames.com/api/v1/authorization
     Headers: Content-Type : application/json
     Body:
     {
     "type": "multifactor",
     "code": "YOUR 2FA CODE HERE",
     "rememberDevice": true
     }
    */
    
    /*
     func getBusinesses(category:String, location:CLLocation){
         
         // Create URL
         /*
          let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
          
          let url = URL(string: urlString)
          
          */
         
         var urlComponents = URLComponents(string:Constants.apiUrl)
         urlComponents?.queryItems = [
             URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
             URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
             URLQueryItem(name: "categories", value: category),
             URLQueryItem(name: "limit", value: "6")
         ]
         
         let url = urlComponents?.url
         
         if let url = url{
             // Create the URL Request
             var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
             request.httpMethod = "GET"  //Endpoint type of GET from API docs
             
             request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
             // Get URL Session
             let session = URLSession.shared
             
             // Create Data Task
             let dataTask = session.dataTask(with: request) { (data, response, error) in
                 // Check that there isn't an error
                 if error == nil{
                     
                     // Parse JSON
                     do{
                         let decoder = JSONDecoder()
                         let result = try decoder.decode(BusinessSearch.self, from: data!)
                         
                         // Sort businesses, result.businesses is unsorted
                         var businesses = result.businesses
                         businesses.sort{(b1,b2) -> Bool in
                             return b1.distance ?? 0 < b2.distance ?? 0
                         }
                         
                         // Call the get image function of the businesses
                         
                         for b in businesses{
                             b.getImageData()
                         }
                         
                         DispatchQueue.main.async{
                             // Assign results to the appropriate category, assigning things to a published property must be from main thread
                        
                             switch category{
                             case Constants.sightsKey:
                                 self.sights = businesses
                             case Constants.restaurantsKey:
                                 self.restaurants = businesses
                             default:
                                 break
                             }
                         }
                         
                     }
                     catch{
                         print(error) // Error from datatask
                     }
                     
                     
                 }
             }
             // Start the Data Task
             dataTask.resume()
         }
     */
 }
     
   
    
