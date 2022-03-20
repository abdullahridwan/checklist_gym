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
    var tasks: [String]
    var whichDone: [String]
}

struct TaskAndStatus: Hashable {
    var task: String
    var completion: String
}



class CalendarInfo: ObservableObject{
    private var counter: Int = 0
    @Published var weekDays: Array<Int> = [Int]()
    @Published var monthName: String = "Getting..."
    @Published var todaysDate: Int = 0
    @Published var allTasks: [DateItem] = [DateItem]() //
    
    init(){
        mapEntityToDateItem()
    }
    
    func getTodaysDate() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEEE MMMM, dd"
        let formattedDate = format.string(from: Date())
        return formattedDate
    }
    
    // Note sure what this is used for tbh
    func getTodaysMonth() -> String {
        let format = DateFormatter()
        format.dateFormat = "LLLL, YYYY"
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
        dateFormatter.dateFormat = "LLLL, YYYY"
        let monthString = dateFormatter.string(from: someDate)
        monthName = monthString
    }
    
    
    /** From Ipad: Given Date Pressed and the current month,year I'm on, we get the Date the user is on */
    func createDateFromPress(datePressed: Int) -> Date {
        //Get the month and year form monthName
        let monthAndYear = monthName
        var items = monthAndYear.components(separatedBy: ",")
        items[1] = items[1].trimmingCharacters(in: .whitespacesAndNewlines)
        
        //month list
        let monthsArr = ["January","February","March","April","May","June","July",
                    "August","September","October","November","December"]
        
        
        var dateComponents = DateComponents()
        dateComponents.year = Int(items[1]) //need this to be variable too ig.
        dateComponents.month = monthsArr.firstIndex(of: items[0]) ?? 0 + 1 //march with indexing starting at 1?tnotion
        dateComponents.day = datePressed
        let createdDate: Date = Calendar.current.date(from: dateComponents) ?? Date.now
        print("\n[createdDateFromPress] \(createdDate)")
        return createdDate
    }
    
    /** From Ipad:
        Input: Date
        Return: DateItem
        --
        Description: Find first instance of DateItem given the Date Input. Return that first instance.
     */
    func getDateItem(dateOn: Date) -> DateItem {
        let indexOfDate = allTasks.firstIndex{ $0.day == dateOn } ?? -1
        if (indexOfDate == -1){
            return DateItem(day: dateOn, dayID: UUID(), tasks: [randomString(of: 5), randomString(of: 5), randomString(of: 5)], whichDone: ["F", "T", "F"])
        }else{
            return allTasks[indexOfDate]
        }
    }
    
    
    /** Input: DateItem
        Return: [TaskAndStatus]
        --
        Description: Parses the [tasks] and [whichDone] fields and returns such that .0 is the task and .1 is wheter it was completed or not.
     */
    func getItemsAndCompletion(dateItem: DateItem) -> [TaskAndStatus]{
        var imm: [(String, String)] = []
        var ret: [TaskAndStatus] = [TaskAndStatus]()
        for task in dateItem.tasks{
            imm.append((task, ""))
        }
        for n in 0..<dateItem.whichDone.count {
            if(n <= dateItem.tasks.count){
                imm[n].1 = dateItem.whichDone[n]
            }
        }
        
        for item in imm {
            ret.append(TaskAndStatus(task: item.0, completion: item.1))
        }
        return ret
    }
    
    
    /** Parameters:
            - datePressed: Int  - From CalendarView
        Return: [TaskAndStatus]
        --
        Description: Takes in [datePressed] and [self.monthName] and returns the tasks for that date
    */
    func getTasksForADate(datePressed: Int) -> [TaskAndStatus]{
        let dateValue = createDateFromPress(datePressed: datePressed)
        let dateItemValue = getDateItem(dateOn: dateValue)
        return getItemsAndCompletion(dateItem: dateItemValue)
    }
    
    
    
    
    
    //Not sure about all the functions below tbh
    
    /** Input: String
        Return: [String]
        --
        Description: Takes in [InfoModel].task or [InfoModel].whichDone, which is a string, and parses it based on "," delimiter to get a list of tasks
     */
    func getList(str:String) -> [String] {
        return str.components(separatedBy: ",")
    }
    
    
    
    
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
    
    /** Input: [InfoModel]
        Return: [DateItem]
        --
        Description: Takes in [InfoModel] and maps it to [DateItem]. Requires parsing [InfoModel].tasks and [InfoModel].whichDone
     */
    func mapEntityToDateItem(){
        allTasks = CoreDataManager.shared.getAllDates().map{ (InfoModel) -> DateItem in
            return DateItem(day: InfoModel.day ?? Date(), dayID: InfoModel.dayID ?? UUID(), tasks: getList(str: InfoModel.tasks ?? "None"), whichDone: getList(str: InfoModel.whichDone ?? "None"))
        }
        //allTasks = [DateItem(day: Date(), dayID: UUID(), tasks: [randomString(of: 5)], whichDone: ["T"])] //for testing purposes
    }
    
    
    /** Parameters:
            - datePressed: Int
            - monthName: String
        Return: Float
        --
        Description: Number of Tasks Completed / Total Number of Tasks
     */
    func calculateProgress(datePressed: Int) -> Float {
        let tasks = getTasksForADate(datePressed: datePressed)
        var count = 0
        for task in tasks{
            if(task.completion == "T"){
                count += 1
            }
        }
        return Float(count) / Float(tasks.count)
    }
    
    
    /** Parameters:
            - datePressed: Int
            - monthName: String
        Return: Float
        --
        Description: Update the list of items, and T/F for the date pressed
     */

    
}
