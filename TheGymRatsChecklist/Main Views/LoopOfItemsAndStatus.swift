//
//  LoopOfItemsAndStatus.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/24/22.
//

import SwiftUI

struct LoopOfItemsAndStatus: View {
    @Binding var tasksForDay: [TaskAndStatus]

    var body: some View {
        List{
            ForEach($tasksForDay, id: \.self){$aTask in
                HStack{
                    TappableCircle(index: tasksForDay.firstIndex(of: aTask) ?? 0, allTasks: $tasksForDay)
                    TextField("Write an item...", text: $aTask.task)
                    Spacer()
                }
            }
        }
        .onAppear() {
            UITableView.appearance().backgroundColor = UIColor.clear
            UITableViewCell.appearance().backgroundColor = UIColor.clear
        }
        
    }
}

struct LoopOfItemsAndStatus_Previews: PreviewProvider {
    static var previews: some View {
        LoopOfItemsAndStatus(tasksForDay: .constant([TaskAndStatus(task: "something", completion: "T")]))
    }
}
