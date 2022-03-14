//
//  SettingsPage.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/13/22.
//

import SwiftUI

struct SettingsPage: View {
    @State private var darkModeEnabled: Bool = false
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                }
            }
                .navigationTitle("Settings")
        }
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
