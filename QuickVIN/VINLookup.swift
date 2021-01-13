//
//  VINLookup.swift
//  QuickVIN
//
//  Created by Jordan Vaglivelo on 1/13/21.
//

import Foundation


func getVINData(vin: String){
    
    //create the url with NSURL
    let url = URL(string: "https://vpic.nhtsa.dot.gov/api/vehicles/decodevinvalues/\(vin)*BA?format=json")!
    let session = URLSession.shared
    let request = URLRequest(url: url)

    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        guard error == nil else {
            return
        }
        guard let data = data else {
            return
        }
       do {
          //create json object from data
          if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
             print(json)
          }
       } catch let error {
         print(error.localizedDescription)
       }
    })

    task.resume()

}
