//
//  CalendarView.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/13/22.
//

import SwiftUI

struct CalendarView: View {
    @State var calendarInfo = CalendarInfo()
    private var sixColumnGrid: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    
    
    var body: some View {
        ScrollView(.vertical){
            HStack{
                Image(systemName: "chevron.left")
                Spacer()
                Text(calendarInfo.getMonth())
                Spacer()
                Image(systemName: "chevron.right")
            }
            
            LazyVGrid(columns: sixColumnGrid, spacing: 20){
                ForEach((0...7), id:\.self){_ in
                    
                }
            }
            
            
            
            
            
        }.padding()
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}




