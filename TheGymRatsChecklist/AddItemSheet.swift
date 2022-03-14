//
//  AddItemSheet.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/13/22.
//

import SwiftUI

struct AddItemSheet: View {
    @Binding var items: [String]
    @State var itemName: String = ""
    @Binding var addItemSheet: Bool
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Item Name", text: $itemName)
                }
            }
            .navigationTitle("Add an Item")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button("Done"){
                        items.append(itemName)
                        addItemSheet.toggle()
                    }
                })
            })
        }
    }
}

struct AddItemSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddItemSheet(items: .constant(["Hello"]), addItemSheet: .constant(false))
    }
}
