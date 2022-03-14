//
//  CalendarViewModel.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/14/22.
//

import Foundation

struct CalendarInfo{
    private var counter: Int = 0
    var someDate: Date
    
    init(){
        someDate = Calendar.current.date(byAdding: .weekOfYear, value: counter, to: Date())!
    }
    
    
    //get the dates in the current week. Use Core Data to get the info related to that Date
    func getDates() -> [Date]{
        let calendar = Calendar.current
        var someDayOfWeek = calendar.component(.weekday, from: someDate)
        var someWeekDays = calendar.range(of: .weekday, in: .weekOfYear, for: someDate)!
        var someDays = (someWeekDays.lowerBound ..< someWeekDays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - someDayOfWeek, to: someDate) }
        return someDays
    }
    
    mutating func updateWeek(change: String){
        if change == "dec"{
            self.counter = self.counter - 1
        }
        else if (change == "inc"){
            self.counter = self.counter + 1
        }else{
            self.counter = self.counter + 0
        }
    }
    
    func getMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: someDate)
        return monthString
    }
    
}
