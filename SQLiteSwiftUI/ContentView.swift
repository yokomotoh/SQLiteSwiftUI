//
//  ContentView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SQLiteView()
            .tabItem {
                Label("SQLite", systemImage: "list.dash")
            }

            ChartView()
            .tabItem {
                Label("Chart", systemImage: "chart.bar")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
