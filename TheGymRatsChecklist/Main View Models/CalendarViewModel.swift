//
//  CalendarViewModel.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/14/22.
//

import Foundation

class CalendarInfo: ObservableObject{
    private var counter: Int = 0
    @Published var weekDays: Array<Int> = [Int]()
    @Published var monthName: String = "Getting..."
    @Published var todaysDate: Int = 0
    
    
    func getTodaysDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEEE MMMM, dd"
        let formattedDate = format.string(from: Date())
        return formattedDate
    }
    
    func getTodaysMonth() -> String {
        let format = DateFormatter()
        format.dateFormat = "MMMM"
        let formattedDate = format.string(from: Date())
        return formattedDate
    }
    
    
    //get the dates in the current week. Use Core Data to get the info related to that Date
     func getDates(){
        let calendar = Calendar.current
        let someDate = Calendar.current.date(byAdding: .weekOfYear, value: counter, to: Date())!
        let someDayOfWeek = calendar.component(.weekday, from: someDate)
        let someWeekDays = calendar.range(of: .weekday, in: .weekOfYear, for: someDate)!
        let someDays = (someWeekDays.lowerBound ..< someWeekDays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - someDayOfWeek, to: someDate) }
        weekDays = someDays.map { calendar.dateComponents([.day], from: $0).day!}
        todaysDate = calendar.dateComponents([.day], from: Date()).day!
    }
    
     func updateWeek(change: String){
        if change == "dec"{
            self.counter = self.counter - 1
        }
        if (change == "inc"){
            self.counter = self.counter + 1
        }
         if (change == "zero"){
             self.counter = 0
         }
        getDates()
        getMonth()
    }
    
    func getMonth() {
        let someDate = Calendar.current.date(byAdding: .weekOfYear, value: counter, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: someDate)
        monthName = monthString
    }

    
}
