//
//  HomePage.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/13/22.
//

import SwiftUI

struct HomePage: View {
    @State var items:[String] = ["Creatine", "Weights", "Biotin"]
    @State private var addIemSheet: Bool = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(items, id:\.self){item in
                    HStack{
                        TappableCircle()
                        Text(item)
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
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
            })
        }
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
