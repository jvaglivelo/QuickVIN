//
//  VINLookup.swift
//  QuickVIN
//
//  Created by Jordan Vaglivelo on 1/13/21.
//

import Foundation

struct ApiResponse: Decodable {
    let Results: [VINData]
}

struct VINData: Decodable {
    let ErrorCode: String
    let VIN: String
    let Make: String
    let Manufacturer: String
    let Model: String
    let ModelYear: String
    let BodyClass: String
    let Doors: String
    let EngineHP: String
    let DriveType: String
    let EngineCylinders: String
    let FuelTypePrimary: String
    let PlantCity: String
    let PlantCountry: String
    let VehicleType: String
    let DisplacementL: String
    let Series: String
    //Electric Car Exclusives
    let BatteryType: String
    let EVDriveUnit: String
    let BatteryKWh: String
    let BatteryKWh_to: String
    //Misc.
    let TransmissionSpeeds: String
    let TransmissionStyle: String
    let Turbo: String
}


func getVINData(vin: String, completionBlock: @escaping ([VINData]) -> Void) -> Void {
    
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

            let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
            let carData = apiResponse.Results
            completionBlock(carData);

        
       } catch let error {
         print(error.localizedDescription)
       }
    })

    task.resume()

}
