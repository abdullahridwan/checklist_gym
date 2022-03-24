//
//  TestingListInScrollView.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/24/22.
//

import SwiftUI

struct TestingListInScrollView: View {
    @State var someList: [String] = ["Creatine", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water", "Water"]
    var body: some View {
        NavigationView {
            
            ZStack {
                Color("purp")
                    //.edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea()
                VStack {
                    ScrollView(.horizontal){
                        HStack{
                            Text("hello")
                                .padding()
                            Text("goofy")
                            Text("goober")
                            Text("goober")
                            Text("goober")
                        }
                    }
                    List {
                        ForEach($someList, id:\.self){$someItem in
                            //Text(someItem)
                            TextField("\(someItem)", text: $someItem)
                        }
                    }
                    .onAppear() {
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITableViewCell.appearance().backgroundColor = UIColor.clear
                    }
                    .listStyle(.automatic)
        //                List {
        //                    ForEach($someList, id:\.self){$someItem in
        //                        //Text(someItem)
        //                        TextField("\(someItem)", text: $someItem)
        //                    }
        //                }
                    .navigationTitle("List")
                }
            }
        }
    }
}

struct TestingListInScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestingListInScrollView()
    }
}
