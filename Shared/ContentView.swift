//
//  ContentView.swift
//  Shared
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var tasksContainer: TasksContainer
    
    var body: some View {
        TabView {
            WeeklyTasksView()
                .tabItem {
                    Label("Weekly", systemImage: "newspaper")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
