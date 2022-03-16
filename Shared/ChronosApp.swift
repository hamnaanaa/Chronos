//
//  ChronosApp.swift
//  Shared
//
//  Created by Hamudi Naanaa on 15.03.22.
//

import SwiftUI

@main
struct ChronosApp: App {
    @StateObject private var tasksContainer = TasksContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(tasksContainer)
                .onAppear {
                    TasksContainer.load { result in
                        switch result {
                        case .failure(let error):
                            fatalError(String(describing: error))
                        case .success(let tasks):
                            tasksContainer.tasks = tasks
                        }
                    }
                }
        }
    }
}
