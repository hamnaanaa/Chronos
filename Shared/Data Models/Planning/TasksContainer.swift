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
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("chronos.data")
    }
    
    /// Load tasks from persistent storage
    /// - Parameter completion: handler that accepts either the resulting list of loaded tasks or an error
    static func load(completion: @escaping (Result<[Task], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    // No file with the given URL was found, return an empty list without failing
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let tasks = try JSONDecoder().decode([Task].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(tasks))
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
    static func save(tasks: [Task], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(tasks)
                let outfile = try fileURL()
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
    
    /// Save all tasks into persistent storage
    /// - Parameters:
    ///   - completion: handler that accepts either the number of saved tasks or an error
    func saveAll(completion: ((Result<Int, Error>) -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(self.tasks)
                let outfile = try TasksContainer.fileURL()
                try data.write(to: outfile)
                
                if let completion = completion {
                    DispatchQueue.main.async {
                        completion(.success(self.tasks.count))
                    }
                }
            } catch {
                if let completion = completion {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
