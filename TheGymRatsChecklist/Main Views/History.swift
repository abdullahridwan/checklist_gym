//
//  History.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/19/22.
//

import SwiftUI

struct History: View {
    @EnvironmentObject var calendarInfo: CalendarInfo
    @State var selectedDate: Date = Date()
    @State var selectedItems: [String] = [String]()
    @State var itemStatus: [Bool] = [Bool]()
    @State var confirmationSheet: Bool = false
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                    DatePicker("Choose a Date", selection: $selectedDate, displayedComponents: .date)
                    
                    Section("List", content: {
                        List($selectedItems, id: \.self){$item in
                            HStack {
                                TextField("Write in an item...", text: $item)
                                Spacer()
                                Button(action: {
                                    if let index = selectedItems        .firstIndex(of: item) {
                                        selectedItems.remove(at: index)
                                    }
                                }, label: {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(Color.red)
                                })
                            }
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
                        Button(action: {
                            //log all the items for that date and save

                            confirmationSheet.toggle()
                            //reset view to current date
                        }, label: {
                            Text("Done")
                        })
                    })
                    ToolbarItem(placement: .navigationBarLeading, content: {
                        EditButton()
                    })
                })
                .sheet(isPresented: $confirmationSheet, content: {
                    HistoryConfirmed()
                })
            .navigationTitle("History")
            }
        }
        .onChange(of: selectedDate, perform: { newDate in
            selectedItems = calendarInfo.getItemsAndCompletion(dateItem: calendarInfo.getDateItem(dateOn: newDate)).map { $0.task }
        })
        
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
