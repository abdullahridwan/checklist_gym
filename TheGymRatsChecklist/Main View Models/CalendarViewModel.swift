//
//  CalendarViewModel.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/14/22.
//

import Foundation

struct DateItem {
    var day: Date
    var dayID: UUID
    var progress: Float
    var tasks: [String]
    var whichDone: [String]
}



class CalendarInfo: ObservableObject{
    private var counter: Int = 0
    @Published var weekDays: Array<Int> = [Int]()
    @Published var monthName: String = "Getting..."
    @Published var todaysDate: Int = 0
    @Published var allTasks: [DateItem] = [DateItem]()
    
    
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
    
    
    /** Based on [self.counter], gets the dates for the given week */
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
    
    /** Changes counter based on user input and updates published fields accordingly */
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
    
    /** Input: None
        Return: None
        --
        Description:  Uses [self.counter] to determine the month that the user is on. Assigns [self.monthName] to string formatted month.
     */
    func getMonth() {
        let someDate = Calendar.current.date(byAdding: .weekOfYear, value: counter, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: someDate)
        monthName = monthString
    }
    
    
    /** Input: String
        Return: [String]
        --
        Description: Takes in [InfoModel].task or [InfoModel].whichDone, which is a string, and parses it based on "," delimiter to get a list of tasks
     */
    func getList(str:String) -> [String] {
        return str.components(separatedBy: ",")
    }
    
    /** Input: [InfoModel]
        Return: [DateItem]
        --
        Description: Takes in [InfoModel] and maps it to [DateItem]. Requires parsing [InfoModel].tasks and [InfoModel].whichDone
     */
    func mapEntityToDateItem(){
        allTasks = CoreDataManager.shared.getAllDates().map{ (InfoModel) -> DateItem in
            return DateItem(day: InfoModel.day!, dayID: InfoModel.dayID!, progress: InfoModel.progress, tasks: getList(str: InfoModel.tasks!), whichDone: getList(str: InfoModel.whichDone!))
        }
    }
    
    
    /** Input: [(String, String)]
        Return: Float
        --
        Description: Number of Tasks Completed / Total Number of Tasks
     */
    func calculateProgress(tasks: [(String, String )]) -> Float {
        var count = 0
        for task in tasks{
            if(task.1 == "T"){
                count += 1
            }
        }
        return Float(count) / Float(tasks.count)
    }
    
    
    /** Input: DateItem
        Return: [(String, String)]
        --
        Description: Parses the [tasks] and [whichDone] fields and returns such that .0 is the task and .1 is wheter it was completed or not.
     */
    func getItemsAndCompletion(dateItem: DateItem) -> [(String, String)]{
        var ret: [(String, String)] = []
        for task in dateItem.tasks{
            ret.append((task, ""))
        }
        for n in 0..<dateItem.whichDone.count {
            if(n <= dateItem.tasks.count){
                ret[n].1 = dateItem.whichDone[n]
            }
        }
        return ret
    }
    
    


    
    /** Input: DateItem
        Return: None
        --
        Description: Takes in DateItem and converts it to the [InfoModel], which is then saved to Core Data
     */
    func createInfoModel(){}
    
    
    

    
    
}
