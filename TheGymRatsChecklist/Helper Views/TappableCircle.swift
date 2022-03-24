//
//  TappableCircle.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/10/22.
//

import SwiftUI
import ConfettiSwiftUI

struct TappableCircle: View {
    var index: Int
    @Binding var allTasks: [TaskAndStatus]
    @State var fillCircle: Bool = false
    @State var counter:Int = 0

    var body: some View {
        
        ZStack {
            Circle()
                .strokeBorder(Color.black, lineWidth: 1)
                .background(fillCircle ? Circle().fill(Color("C2")) : Circle().fill(Color.white))
                .frame(width: 15, height: 15)
                .onTapGesture {
                    counter += 1
                    fillCircle.toggle()
                    toggleCompletionStatus(completionStatus: allTasks, idx: index)
            }
            ConfettiCannon(counter: $counter, num: 5, openingAngle: Angle.degrees(1.0), radius: 40.0)
        }
        .onChange(of: fillCircle){newValue in
            if newValue {
                allTasks[index].completion = "T"
            }else{
                allTasks[index].completion = "F"
            }
        }
            
    }
    
    func toggleCompletionStatus(completionStatus: [TaskAndStatus], idx: Int){
        //index range check
        if idx >= allTasks.count{
            return 
        }
        
        if self.allTasks[idx].completion == "F" {
            self.allTasks[idx].completion = "T"
        }else{
            self.allTasks[idx].completion = "F"
        }
    }
}

struct TappableCircle_Previews: PreviewProvider {
    static var previews: some View {
        TappableCircle(index: 2, allTasks: .constant([TaskAndStatus(task: "T1", completion: "T"), TaskAndStatus(task: "t2", completion: "F")]))
    }
}
