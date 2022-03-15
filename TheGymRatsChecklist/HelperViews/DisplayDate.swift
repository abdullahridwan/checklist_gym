//
//  DisplayDate.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/14/22.
//

import SwiftUI

//Green Circle fraction depends on how many of the items were done on the specific day
struct DisplayDate: View {
    @EnvironmentObject var calendarInfo: CalendarInfo
        //using calendarInfo.month and the date pressed, I can recreate a date. Use the date to get info on the task list, which are completed and which are not from Core Data
     var dateNum: Int
    @State var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5.0)
                .opacity(0.2)
                .foregroundColor(Color.green)
                .frame(width: 35.0, height: 35.0)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.green.opacity(0.8))
                .rotationEffect(Angle(degrees: 270.0))
                .frame(width: 35.0, height: 35.0)
                //.animation(.linear)
            
//            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
//                .font(.largeTitle)
//                .bold()
            Text(String(dateNum))
                .font(.subheadline)
                
            
        }
    }
}

struct DisplayDate_Previews: PreviewProvider {
    static var previews: some View {
        DisplayDate(dateNum: 14, progress: 0.28)
    }
}
