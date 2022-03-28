//
//  TasksContainer.swift
//  Chronos
//
//  Created by Hamudi Naanaa on 16.03.22.
//

import Foundation
import SwiftUI

class TasksContainer: ObservableObject {
    @Published var tasks: [Task] = []
    
    @Published var epics: [Epic] = []
    
    func reset(using data: ([Task], [Epic])? = nil) {
        self.tasks = data?.0 ?? []
        self.epics = data?.1 ?? []
    }
    
    /// Save all tasks into persistent storage
    /// - Parameters:
    ///   - completion: handler that accepts either the number of saved tasks or an error
    func saveAll(completion: ((Result<Int, Error>) -> Void)? = nil) {
        // TODO: Add improved filter logic here? E.g. no empty tasks
        TasksContainer.saveTasks(tasks: tasks, completion: completion ?? { _ in })
        TasksContainer.saveEpics(epics: epics, completion: completion ?? { _ in })
    }
    
    func addTask(task: Task) {
        self.tasks.append(task)
    }
    
    func removeTask(task: Task) {
        self.tasks.removeAll(where: { $0.id == task.id })
    }
    
    func addEpic(epic: Epic) {
        self.epics.append(epic)
    }
    
    func removeEpic(epic: Epic) {
        self.epics.removeAll(where: { $0.id == epic.id })
    }
}


/// Persistency logic
extension TasksContainer {
    private static func tasksFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("chronosTasks.data")
    }
    
    private static func epicsFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("chronosEpics.data")
    }
    
    /// Load app data  from persistent storage
    /// - Parameter completion: handler that accepts either the resulting list of loaded tuple of data or an error
    static func load(completion: @escaping (Result<([Task], [Epic]), Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let tasksFileURL = try tasksFileURL()
                let epicsFileURL = try epicsFileURL()
                guard let tasksFile = try? FileHandle(forReadingFrom: tasksFileURL),
                      let epicsFile = try? FileHandle(forReadingFrom: epicsFileURL)
                else {
                    // No file with the given URL was found, return an empty data without failing
                    DispatchQueue.main.async {
                        completion(.success(([], [])))
                    }
                    return
                }
                let tasks = try JSONDecoder().decode([Task].self, from: tasksFile.availableData)
                let epics = try JSONDecoder().decode([Epic].self, from: epicsFile.availableData)
                DispatchQueue.main.async {
                    completion(.success((tasks, epics)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Save selected `Task`s into persistent storage
    /// - Parameters:
    ///   - tasks: tasks to be saved
    ///   - completion: handler that accepts either the number of saved tasks or an error
    static func saveTasks(tasks: [Task], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(tasks)
                let outfile = try tasksFileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(tasks.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Save selected `Epic`s into persistent storage
    /// - Parameters:
    ///   - epics: epics to be saved
    ///   - completion: handler that accepts either the number of saved epics or an error
    static func saveEpics(epics: [Epic], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(epics)
                let outfile = try epicsFileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(epics.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}


/// Mocked data
extension TasksContainer {
    static var mockedTasks = [Task.exampleTask1, .exampleTask2, .exampleTaskLongestText, .exampleTask3]
    static var mockedEpics = [Epic.exampleEpic1, .exampleEpic2, .exampleEpic3, .exampleEpic4]
}
