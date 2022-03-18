//
//  HomePage.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/13/22.
//

import SwiftUI

struct HomePage: View {
    //@EnvironmentObject var calendarInfo: CalendarInfo
    @State var items:[String] = ["Creatine", "Weights", "Biotin"]
    @State var completionStatus: [Bool] = [Bool]()
    @State private var addIemSheet: Bool = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(items, id:\.self){item in
                    HStack{
                        TappableCircle(index: items.firstIndex(of: item) ?? 0, completionStatus: $completionStatus)
                        Text(item)
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
            .onAppear(perform: {
                completionStatus = Array(repeating: false, count: items.count)
            })
            .navigationTitle("Today")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        addIemSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                        .sheet(isPresented: $addIemSheet, content: {
                            AddItemSheet(items: $items, addItemSheet: $addIemSheet)
                        })
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    EditButton()
                })
                ToolbarItem(placement: .principal, content: {
                    Button(action: {}, label: {
                        Text("Log")
                            .foregroundColor(Color.red)
                    })
                })
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        print("items")
                        print(items)
                        print("\nCompletion Status")
                        print(completionStatus)
                    }, label: {
                        Text("Log Info")
                    })
                })
                
            })
        }
    }
                                    

    func toggleValue(b: Bool) -> Bool{
        return !b
    }
    
    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    
    /** Parameters:
        Return: Void
        --
        Description: Turns the current list os [items] into a string combined with "," and wheter they are completed or not as well. Then, makes a new DateItem from that Info. 
     */
    
    /** Parameters:
        Return: Void
        --
        Description: Turn DateItem to InfoModel and turn 
     */
    
    
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
