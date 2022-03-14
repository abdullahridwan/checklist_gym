//
//  ContentView.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/9/22.
//

import SwiftUI

struct ContentView: View {

    
    var body: some View {
        TabView{
            HomePage()
                .tabItem({
                    Label("Home", systemImage: "house")
                })
            
            SettingsPage()
                .tabItem({
                    Label("Settings", systemImage: "gear")
                })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
