//
//  ChartView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    
    // array of user models
    @State var userModels: [UserModel] = []
    
    // check if user is selected for edit
    @State var userSelected: Bool = false
     
    // id of selected user to edit or delete
    @State var selectedUserId: Int64 = 0
    
    var body: some View {
        // create navigation view
        NavigationView {
         
            VStack {
         
                BarChartView(data: ChartData(values: userModels.map { ($0.username, $0.age) } ), title: "Ages", legend: "username", form: ChartForm.extraLarge)
                
                LineView(data: userModels.map { Double($0.price) }, title: "Prices", legend: "price par username")
         
            }
            // load data in user models array
            .onAppear(perform: {
                self.userModels = DB_Manager().getUsers()
            })
            .padding()
            .navigationBarTitle("Chart")
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

import Foundation
let us : [UserModel] = []
let usrs = us.map { ($0.username, $0.age) }

