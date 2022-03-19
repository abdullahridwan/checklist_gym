//
//  CalendarView.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/13/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var calendarInfo: CalendarInfo
    var sevenColumnGrid: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    let dateFormatter = DateFormatter()
    @State var datePressed: Int = 0
    @State var tasksForDay: [TaskAndStatus] = [TaskAndStatus]()
    
//    init() {
//        UITableView.appearance().separatorStyle = .singleLine
//        UITableViewCell.appearance().backgroundColor = .white
//        UITableView.appearance().backgroundColor = .white
//    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                MonthAndButons(calendarInfo: _calendarInfo)
                    .padding(.top)
                WeekDayNamesComponent(sevenColumnGrid: sevenColumnGrid)
                
                WeekDayNumbersComponent(calendarInfo: _calendarInfo, datePressed: $datePressed, tasksForDay: $tasksForDay, sevenColumnGrid: sevenColumnGrid)
                LazyVStack{
                    HStack{
                        Spacer()
                        Button(action: {
                        }, label: {
                            Image(systemName: "plus.circle")
                        })
                    }
                    ForEach(tasksForDay, id: \.self){item in
                        HStack{
                            Circle()
                                .strokeBorder(Color.black, lineWidth: 1)
                                .background(item.completion == "T" ? Circle().fill(Color("C2")) : Circle().fill(Color.white))
                                .opacity(0.8)
                                .frame(width: 15, height: 15)
                            Text(item.task)
                                .foregroundColor(Color.black)
                                .opacity(0.8)
                            Spacer()
                        }
                    }
                }
                .padding()
                .padding(.top, 10)
//                List{
//                    ForEach(tasksForDay, id: \.self){taskItem in
//                        HStack{
//                            TappableCircle()
//                            Text(taskItem.task)
//                            Spacer()
//                        }
//                    }
//                }
//                Spacer()
            }
            .padding(.horizontal)
            .onAppear(perform: {
                calendarInfo.mapEntityToDateItem()
                calendarInfo.updateWeek(change: "none")
                datePressed = calendarInfo.todaysDate
                tasksForDay = calendarInfo.getTasksForADate(datePressed: datePressed)
            })
            .navigationTitle("Calendar")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        calendarInfo.updateWeek(change: "zero")
                        datePressed = calendarInfo.todaysDate
                    }, label: {
                        Image(systemName: "house")
                    })
                })
                
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        print("All Tasks: ")
                        print(calendarInfo.allTasks)
                        print("\nDatePressed")
                        print(datePressed)
                        print("\nTasks for Today:")
                        print(tasksForDay)
                    }, label: {
                        Image(systemName: "gear")
                    })
                })
                
                
                
            })
        }
    }
    
    
    
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarInfo())
    }
}





struct MonthAndButons: View {
    @EnvironmentObject var calendarInfo: CalendarInfo
    var body: some View {
        HStack{
            Button(action: {
                calendarInfo.updateWeek(change: "dec")
                
            }, label: {
                Image(systemName: "chevron.left")
            })
            
            Spacer()
            Text(calendarInfo.monthName)
            Spacer()
            Button(action: {
                calendarInfo.updateWeek(change: "inc")
            }, label: {
                Image(systemName: "chevron.right")
            })
        }
    }
}



struct WeekDayNamesComponent: View {
    var sevenColumnGrid: [GridItem]
    var weekDayNames: [String] = ["Sun", "Mon", "Tue", "Wed", "Thr", "Fri", "Sat"]

    var body: some View {
        LazyVGrid(columns: sevenColumnGrid, spacing: 20){
            ForEach(weekDayNames, id: \.self){dayName in
                Text(dayName).foregroundColor(Color.gray)
            }
        }
    }
}

struct WeekDayNumbersComponent: View {
    @EnvironmentObject var calendarInfo: CalendarInfo
    @Binding var datePressed: Int
    @Binding var tasksForDay: [TaskAndStatus]
    var sevenColumnGrid: [GridItem]
    var body: some View {
        LazyVGrid(columns: sevenColumnGrid, spacing: 20){
            ForEach(calendarInfo.weekDays, id:\.self){d in
                VStack {
                    DisplayDate(dateNum: d, progress: calendarInfo.calculateProgress(datePressed: datePressed))
                        .foregroundColor(calendarInfo.getTodaysMonth() == calendarInfo.monthName && d == datePressed ? Color.red : Color.black)
                        .onTapGesture {
                            datePressed = d
                            tasksForDay = calendarInfo.getTasksForADate(datePressed: datePressed)
                        }
                }
            }
        }
    }
}


