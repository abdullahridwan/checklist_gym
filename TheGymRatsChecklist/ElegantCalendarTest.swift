//
//  ElegantCalendarTest.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/14/22.
//

import SwiftUI
import ElegantCalendar


struct ElegantCalendarTest: View {
    // Start & End date should be configured based on your needs.
    var startDate: Date = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36)))
    var endDate: Date = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))
    

    @ObservedObject var calendarManager: ElegantCalendarManager
    init(){
        self.calendarManager = ElegantCalendarManager(
            configuration: CalendarConfiguration(startDate: startDate,
                                                 endDate: endDate))
    }
    

    var body: some View {
        ElegantCalendarView(calendarManager: calendarManager)
    }
}

struct ElegantCalendarTest_Previews: PreviewProvider {
    static var previews: some View {
        ElegantCalendarTest()
    }
}
