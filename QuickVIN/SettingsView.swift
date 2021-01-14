//
//  SettingsView.swift
//  QuickVIN
//
//  Created by Jordan Vaglivelo on 1/13/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.openURL) var openURL

    var body: some View {
        VStack {
            HStack {
                Text("QuickVIN")
                    .fontWeight(.black)
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
                    .padding()
                
            }
            Text("Settings")
                .fontWeight(.bold)
                .font(.system(size: 22))
                .foregroundColor(.blue)
                .padding(.bottom)

            VStack {
                Text("QuickVIN quickly decodes data from a vehicle's VIN and displays it in an easy to read list")
                    .padding()
                    .multilineTextAlignment(.center)
            }

            HStack {
                Text("Data Source")
                    .padding()
                Spacer()
                Button(action: {
                    openURL(URL(string: "https://vpic.nhtsa.dot.gov/api/")!)
                }) {
                    Text("NHTSA.DOT.GOV")
                        .padding()
                }
            }
            HStack {
                Text("Developed by")
                    .padding()
                Spacer()
                Button(action: {
                    openURL(URL(string: "https://jvaglivelo.me")!)
                }) {
                    Text("Jordan Vaglivelo")
                        .padding()
                }
            }
            VStack {
                Text("This Project is open source on GitHub")
                    .padding(.top)
                Button(action: {
                    openURL(URL(string: "https://github.com/jvaglivelo/quickVIN")!)
                }) {
                    Text("View Source Code")
                }

            }

            Spacer()
            Button(action: {
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = UIHostingController(rootView: ContentView())
                    window.makeKeyAndVisible()
                }
            }) {
                Text("Return")
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 25, alignment: .center)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.accentColor)
                    .cornerRadius(8)

            }

        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
