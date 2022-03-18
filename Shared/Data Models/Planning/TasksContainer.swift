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
    
    @Published var categories: Set<Category> = Set()
    
    func reset(using data: ([Task], Set<Category>)? = nil) {
        self.tasks = data?.0 ?? []
        self.categories = data?.1 ?? Set()
    }
    
    /// Save all tasks into persistent storage
    /// - Parameters:
    ///   - completion: handler that accepts either the number of saved tasks or an error
    func saveAll(completion: ((Result<Int, Error>) -> Void)? = nil) {
        // TODO: Add improved filter logic here? E.g. no empty tasks
        TasksContainer.saveTasks(tasks: tasks, completion: completion ?? { _ in })
        TasksContainer.saveCategories(categories: categories, completion: completion ?? { _ in })
    }
    
    func addTask(task: Task) {
        self.tasks.append(task)
    }
    
    func removeTask(task: Task) {
        self.tasks.removeAll(where: { $0.id == task.id })
    }
    
    func addCategory(category: Category) {
        categories.update(with: category)
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
    
    private static func categoriesFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("chronosCategories.data")
    }
    
    /// Load app data  from persistent storage
    /// - Parameter completion: handler that accepts either the resulting list of loaded tuple of data or an error
    static func load(completion: @escaping (Result<([Task], Set<Category>), Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let tasksFileURL = try tasksFileURL()
                let categoriesFileURL = try categoriesFileURL()
                guard let tasksFile = try? FileHandle(forReadingFrom: tasksFileURL),
                      let categoriesFile = try? FileHandle(forReadingFrom: categoriesFileURL)
                else {
                    // No file with the given URL was found, return an empty data without failing
                    DispatchQueue.main.async {
                        completion(.success(([], Set())))
                    }
                    return
                }
                let tasks = try JSONDecoder().decode([Task].self, from: tasksFile.availableData)
                let categories = try JSONDecoder().decode(Set<Category>.self, from: categoriesFile.availableData)
                DispatchQueue.main.async {
                    completion(.success((tasks, categories)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Save selected tasks into persistent storage
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
    
    /// Save selected categories into persistent storage
    /// - Parameters:
    ///   - categories: categories to be saved
    ///   - completion: handler that accepts either the number of saved categories or an error
    static func saveCategories(categories: Set<Category>, completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(categories)
                let outfile = try categoriesFileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(categories.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
