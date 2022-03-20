//
//  History.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/19/22.
//

import SwiftUI

struct History: View {
    @State var selectedDate: Date = Date()
    @State var selectedItems: [String] = [String]()
    
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Choose a Date", selection: $selectedDate, displayedComponents: .date)
                
                Section("List", content: {
                    List($selectedItems, id: \.self){$item in
                        TextField("Title", text: $item)
                    }

                    Button(action: {
                        selectedItems.append("")
                    }, label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Item")
                        }
                    })
                })
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    EditButton()
                })
            })
            .navigationTitle("History")
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
