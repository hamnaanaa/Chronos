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
                            print("[ERROR] Could not load data from persistent storage. Reason: \(String(describing: error))")
                            // couldn't load data from persistent storage -> initialize empty list
                            tasksContainer.reset(using: nil)
                            // too aggresive
                            // fatalError(String(describing: error))
                        case .success(let data):
                            tasksContainer.reset(using: data)
                        }
                    }
                }
        }
    }
}
