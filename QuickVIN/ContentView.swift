//
//  ContentView.swift
//  QuickVIN
//
//  Created by Jordan Vaglivelo on 1/13/21.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    
    @State var carVIN:String = ""
    @State var isLoaded:Bool = false
    @State private var isShowingScanner = false

    var body: some View {
        VStack {
            HStack {
                Text("QuickVIN")
                    .fontWeight(.black)
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
                    .padding()
            }
            Spacer()
                .frame(height: UIScreen.main.bounds.height * 0.075)
            HStack{
                TextField("Enter VIN", text: $carVIN, onEditingChanged: { (changed) in
                }) {
                    print("VIN Entered")
                    carVIN = carVIN.replacingOccurrences(of: " ", with: "")
                    isLoaded = true
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .multilineTextAlignment(.center)
                Button(action: {
                    isShowingScanner = true
                }) {
                    Text("Scan VIN")
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.accentColor)
                        .cornerRadius(8)
                }
                Spacer()
            }.sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.code39], simulatedData: "WP0AA2A88HK270210", completion: self.handleScan)
            }
            if (isLoaded){
                Button(action: {
                    isLoaded = false
                    carVIN = ""
                }) {
                    Text("Clear")
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 25, alignment: .center)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.accentColor)
                        .cornerRadius(8)

                }
                VStack {
                    carInfoList(carVin: carVIN, carData: [VINData(ErrorCode: "", VIN: "", Make: "", Manufacturer: "", Model: "", ModelYear: "", BodyClass: "", Doors: "", EngineHP: "", DriveType: "", EngineCylinders: "", FuelTypePrimary: "", FuelTypeSecondary: "", PlantCity: "", PlantState: "", PlantCountry: "", VehicleType: "", DisplacementL: "", BatteryType: "", EVDriveUnit: "", BatteryKWh: "", BatteryKWh_to: "", ElectrificationLevel: "", BatteryInfo: "", TransmissionSpeeds: "", TransmissionStyle: "", Turbo: "", BasePrice: "", SeatRows: "", Seats: "", Trim: "", EngineModel: "")])
                }
            }
            
            Spacer()
            Button(action: {
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: SettingsView())
                    window.makeKeyAndVisible()
                }
            }) {
                Text("Settings")
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25, alignment: .center)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.accentColor)
                    .cornerRadius(8)

            }

        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
       self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            print(details[details.count-1])
            carVIN = details[details.count-1]
            isLoaded = true
        case .failure(let error):
            print("Scanning failed")
            print("error", error)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct carInfoList: View {
    var carVin: String
    @State var carData: [VINData]
    var body: some View {
        VStack {
            List(){
                if (carData[0].ErrorCode == "0"){
                Group {
                        //Main Info
                        carInfoCell(title: "Vehicle", value: carData[0].ModelYear + " " + carData[0].Make + " " + carData[0].Model, checker: carData[0].Model)
                        
                        //Trim
                        carInfoCell(title: "Trim", value: carData[0].Trim, checker: carData[0].Trim)

                        //Base Price
                        carInfoCell(title: "Base Price", value: "$" + carData[0].BasePrice, checker: carData[0].BasePrice)
                
                        //Drive Type
                        carInfoCell(title: "Drive Type", value: carData[0].DriveType, checker: carData[0].DriveType)
                
                        //Manufacturer Location
                        carInfoCell(title: "Manufactured in", value: carData[0].PlantCity + "," + carData[0].PlantState + " " +  carData[0].PlantCountry, checker: carData[0].PlantCity)
                
                        //Vehicle Type
                        carInfoCell(title: "Vehicle Type", value: carData[0].VehicleType, checker: carData[0].VehicleType)
                
                        //Primary Fuel
                        carInfoCell(title: "Primary Fuel Type", value: carData[0].FuelTypePrimary, checker: carData[0].FuelTypePrimary)
                
                        //Primary Fuel
                        carInfoCell(title: "Secondary Fuel Type", value: carData[0].FuelTypeSecondary, checker: carData[0].FuelTypeSecondary)

                        //Engine
                        carInfoCell(title: "Engine", value: carData[0].DisplacementL + "L " + carData[0].EngineCylinders + "-cylinder engine", checker: carData[0].DisplacementL)
                                                
                        //Engine Model
                        carInfoCell(title: "Engine Model", value: carData[0].EngineModel, checker: carData[0].EngineModel)

                    }
                    Group {

                        //Motor
                        carInfoCell(title: "Motor", value: carData[0].EVDriveUnit, checker: carData[0].EVDriveUnit)

                        //Battery Type
                        carInfoCell(title: "Battery Type", value: carData[0].BatteryType, checker: carData[0].BatteryType)
                        
                        //Battery Info
                        carInfoCell(title: "Battery Info", value: carData[0].BatteryInfo, checker: carData[0].BatteryInfo)

                        //Battery KWh
                        carInfoCell(title: "Battery KWh", value: carData[0].BatteryKWh + "KW/h to " + carData[0].BatteryKWh_to + "KW/h", checker: carData[0].BatteryKWh)
                        
                        //Electrification Level
                        carInfoCell(title: "Electrification Level", value: carData[0].ElectrificationLevel, checker: carData[0].ElectrificationLevel)

                        //Horsepower
                        carInfoCell(title: "Horsepower", value: carData[0].EngineHP + "hp", checker: carData[0].EngineHP)
                
                        //Style
                        carInfoCell(title: "Doors", value: carData[0].Doors + "-door ", checker: carData[0].Doors)
                        
                        //Seats
                        carInfoCell(title: "Seating", value: carData[0].SeatRows + " row(s) with " + carData[0].Seats + " seats total", checker: carData[0].Seats)

                        
                        //Transmission
                        carInfoCell(title: "Transmission", value: carData[0].TransmissionSpeeds + "-speed " + carData[0].TransmissionStyle, checker: carData[0].TransmissionSpeeds)
                        
                        //Turbo
                        carInfoCell(title: "Turbocharger", value: carData[0].Turbo, checker: carData[0].Turbo)

                    }

                }else if (carData[0].ErrorCode.isEmpty){
                    carInfoCell(title: "Loading...", value: "", checker: "Loading...")

                }else {
                    carInfoCell(title: "Error", value: "Either VIN is invalid or no information avaliable", checker: "ERROR")
                }
            }
        }.onAppear(){
            getVINData(vin: carVin) { (output) in
                carData = output
            }

        }
    }
}

struct carInfoCell: View {
    var title:String
    var value:String
    var checker:String
    var body: some View {
        if (!checker.isEmpty){
            HStack {
                Spacer()
                VStack {
                    Text("\(title): ")
                    Text(value)
                        .font(Font.body.bold())
                        .padding(.top, 10)
                }
                Spacer()
            }
        }
    }
}
