//
//  TappableCircle.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/10/22.
//

import SwiftUI
import ConfettiSwiftUI

struct TappableCircle: View {
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
            }
            ConfettiCannon(counter: $counter, num: 5, openingAngle: Angle.degrees(1.0), radius: 40.0)
        }
            
    }
}

struct TappableCircle_Previews: PreviewProvider {
    static var previews: some View {
        TappableCircle()
    }
}
