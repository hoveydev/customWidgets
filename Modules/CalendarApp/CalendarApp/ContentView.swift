//
//  ContentView.swift
//  CalendarApp
//
//  Created by Robert Alec Hovey on 2/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, Calendar App!")
                .onChange(of: scenePhase) { newPhase in
                    switch newPhase {
                        case .inactive:
                            print("inactive")
                        case .active:
                            if let url = URL(string: "calshow://") {
                                UIApplication.shared.open(url)
                            }
                        case .background:
                            print("background")
                    @unknown default:
                        print("Fatal Error")
                    }
                }
            // issue with the above code is that it only executes once when the app is opened
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
