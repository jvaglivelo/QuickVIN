//
//  ContentView.swift
//  QuickVIN
//
//  Created by Jordan Vaglivelo on 1/13/21.
//

import SwiftUI

struct ContentView: View {
    @State var carVIN:String = ""
    @State var isLoaded:Bool = false
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
                    isLoaded = true
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .multilineTextAlignment(.center)
            }
            if (isLoaded){
                Text(carVIN)
                VStack {
                    carInfoList(carVin: carVIN, carData: [VINData(VIN: "", Make: "", Manufacturer: "", Model: "", ModelYear: "", BodyClass: "", Doors: "", EngineHP: "", DriveType: "", EngineCylinders: "", FuelTypePrimary: "", PlantCity: "", PlantCountry: "", VehicleType: "", DisplacementL: "", Series: "")])
                }
            }
            
            Spacer()
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
                carInfoCell(title: "Vehicle", value: carData[0].ModelYear + " " + carData[0].Make + " " + carData[0].Model)
                if (carData[0].Series != ""){
                    carInfoCell(title: "Series", value: carData[0].Series)
                }
                carInfoCell(title: "Manufactured in", value: carData[0].PlantCity + ", " + carData[0].PlantCountry)
                carInfoCell(title: "Vehicle Type", value: carData[0].VehicleType)
                carInfoCell(title: "Fuel Type", value: carData[0].FuelTypePrimary)
                carInfoCell(title: "Engine", value: carData[0].DisplacementL + "L " + carData[0].EngineCylinders + "-cylinder engine")
                carInfoCell(title: "Horsepower", value: carData[0].EngineHP + "hp")
                carInfoCell(title: "Style", value: carData[0].Doors + "-door" + " " + carData[0].BodyClass)

            }
        }.onAppear(){
            getVINData(vin: "WBADW7C53BE443696") { (output) in
                carData = output
            }

        }
    }
}

struct carInfoCell: View {
    var title:String
    var value:String
    var body: some View {
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
