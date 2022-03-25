//
//  ContentView.swift
//  Shared
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WeeklyTasksView()
                .tabItem {
                    Label("Weekly Planning", systemImage: "newspaper")
                }
            TasksOverview()
                .tabItem {
                    Label("All Tasks", systemImage: "list.bullet")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
