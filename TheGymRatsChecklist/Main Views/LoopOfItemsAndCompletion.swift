//
//  ListOfItemsOnADate.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/24/22.
//

import SwiftUI

struct ListOfItemsOnADate: View {
    @State var tasksForDay: [TaskAndStatus]
    var body: some View {
            ForEach($tasksForDay, id: \.self){$aTask in
                HStack{
                    Circle()
                        .strokeBorder(Color.black, lineWidth: 1)
                        .background(aTask.completion == "T" ? Circle().fill(Color("C2")) : Circle().fill(Color.white))
                        .frame(width: 15, height: 15)
                    TextField("Write an item...", text: $aTask.task)
                    Spacer()
                }
            }
            .onAppear() {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            }
    }
}

struct ListOfItemsOnADate_Previews: PreviewProvider {
    static var previews: some View {
        ListOfItemsOnADate(tasksForDay: [TaskAndStatus(task: "something", completion: "T")])
    }
}
