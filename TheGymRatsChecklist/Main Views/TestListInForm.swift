//
//  TestListInForm.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/24/22.
//

import SwiftUI

struct TestListInForm: View {
    @State var selectedDate: Date = Date()
    @State var someList: [String] = ["Creatine", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water"]

    var body: some View {
        NavigationView {
            Form {
                    DatePicker("Choose a Date", selection: $selectedDate, displayedComponents: .date)
                    Section("List", content: {
                        ForEach($someList, id:\.self){$someItem in
                            //Text(someItem)
                            TextField("\(someItem)", text: $someItem)
                        }
                        .onMove { indexSet, offset in
                            someList.move(fromOffsets: indexSet, toOffset: offset)
                        }
                        .onDelete { indexSet in
                            someList.remove(atOffsets: indexSet)
                        }
                        
                    })
                }
            .navigationTitle("Form test")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    EditButton()
                })
            })
        }
    }
}

struct TestListInForm_Previews: PreviewProvider {
    static var previews: some View {
        TestListInForm()
    }
}
