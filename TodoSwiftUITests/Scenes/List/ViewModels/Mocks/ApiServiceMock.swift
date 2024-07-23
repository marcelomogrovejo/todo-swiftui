//
//  ApiServiceMock.swift
//  TodoSwiftUITests
//
//  Created by Marcelo Mogrovejo on 15/07/2024.
//

import Foundation
import TodoRepositoryPackage
@testable import TodoSwiftUI

class ApiServiceMock: ApiServiceProtocol {
    
    var isGetAllAsyncSuccess: Bool = true
    
    func getOne(id: String, completion: @escaping (Result<TodoRepositoryPackage.DomainTodoTask, TodoRepositoryPackage.RepositoryError>) -> Void) {
        // TODO
    }
    
    func getOneAsync(id: String) async throws -> DomainTodoTask {
        // TODO
        return DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test1", title: "Test task 1", date: Date(), description: "Test task 1 description")
    }
    
    func getAll(completion: @escaping (Result<[TodoRepositoryPackage.DomainTodoTask], TodoRepositoryPackage.RepositoryError>) -> Void) {
        // TODO
    }
    
    func getAllAsync() async throws -> [DomainTodoTask] {
        if isGetAllAsyncSuccess {
            var tasks: [DomainTodoTask] = []
            let task1 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test1", title: "Test task 1", date: Date(), description: "Test task 1 description")
            tasks.append(task1)
            let task2 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test2", title: "Test task 2", date: Date(), description: "Test task 2 description")
            tasks.append(task2)
            let task3 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test3", title: "Test task 3", date: Date(), description: "Test task 3 description")
            tasks.append(task3)
            let task4 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test4", title: "Test task 4", date: Date(), description: "Test task 4 description")
            tasks.append(task4)
            let task5 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test5", title: "Test task 5", date: Date(), description: "Test task 5 description")
            tasks.append(task5)
            return tasks
        } else {
            throw RepositoryError.notFound
        }
    }
    
    func new(_ item: TodoRepositoryPackage.DomainTodoTask, completion: @escaping (Result<TodoRepositoryPackage.DomainTodoTask, TodoRepositoryPackage.RepositoryError>) -> Void) {
        // TODO
    }
    
    func newAsync(_ item: TodoRepositoryPackage.DomainTodoTask) async throws -> DomainTodoTask {
        return DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test1", title: "Test task 1", date: Date(), description: "Test task 1 description")
        // TODO
    }
    
    func update(_ item: TodoRepositoryPackage.DomainTodoTask, completion: @escaping (Result<TodoRepositoryPackage.DomainTodoTask, TodoRepositoryPackage.RepositoryError>) -> Void) {
        // TODO
    }
    
    func updateAsync(_ item: TodoRepositoryPackage.DomainTodoTask) async throws -> DomainTodoTask {
        return DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test1", title: "Test task 1", date: Date(), description: "Test task 1 description")
        // TODO
    }
    
    func delete(_ item: TodoRepositoryPackage.DomainTodoTask, completion: @escaping (Result<Bool, TodoRepositoryPackage.RepositoryError>) -> Void) {
        // TODO
    }
    
    func deleteAsync(_ item: TodoRepositoryPackage.DomainTodoTask) async throws -> Bool {
        return true
        // TODO
    }
    
    func completeTask(_ item: TodoRepositoryPackage.DomainTodoTask, completion: @escaping (Result<TodoRepositoryPackage.DomainTodoTask, TodoRepositoryPackage.RepositoryError>) -> Void) {
        // TODO
    }
    
    func completeTaskAsync(_ item: TodoRepositoryPackage.DomainTodoTask) async throws -> DomainTodoTask {
        return DomainTodoTask(id: UUID().uuidString, avatar: "", username: "test1", title: "Test task 1", date: Date(), description: "Test task 1 description")
        // TODO
    }
    
    
}
