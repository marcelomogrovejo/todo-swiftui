//
//  TaskViewModel.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 25/12/2023.
//

import Foundation
import TodoRepositoryPackage

protocol TaskViewModelProtocol {
    var apiService: ApiService { get set }

    func save(task: TaskDataModel, for id: String?) async throws
    func getTaskBy(id: String) async throws
}

class TaskViewModel: ObservableObject, TaskViewModelProtocol {
    // Assigning an empty TaskDataModel to avoid errors publishing and to stop using @State on View.
    @Published var taskDataModel: TaskDataModel = TaskDataModel(date: Date.now.stringyfiedDate.formattedDate,
                                                                time: Date.now.stringyfiedTime.formattedTime,
                                                                title: "",
                                                                description: "",
                                                                isDone: false)
    // Associated to alert
    @Published var success = false

    // TODO: implement the PetShop factory ?
    var apiService = ApiService()

    // TODO: Warning !
    let tempAddingError: Error = NSError(domain: "Error: Adding item error", code: 10001)
    let tempUpdatingError: Error = NSError(domain: "Error: Updating item error", code: 10002)

    @MainActor
    func save(task: TaskDataModel, for id: String?) async throws {
        let dateStr = "\(task.date.formatted(date: .long, time: .omitted))"
        let timeStr = "\(task.time.formatted(date: .omitted, time: .shortened))"
        let fullDateStr = dateStr + " " + timeStr

        // Updating
        if let id = id {
            do {
                // TODO: avatar and username should be the existing ones
                let taskToUpdate = DomainTodoTask(id: id,
                                                  avatar: "",
                                                  username: "hsimpson",
                                                  title: task.title,
                                                  date: fullDateStr.fullFormattedDate,
                                                  description: task.description,
                                                  isCompleted: task.isDone)
                taskDataModel = try await updateTask(taskToUpdate)
                success = true
            } catch {
                print("Error updateing: \(error.localizedDescription)")
            }
        // Adding
        } else {
            do {
                let taskToSave = DomainTodoTask(id: UUID().uuidString,
                                                avatar: "",
                                                username: "currentUser",
                                                title: task.title,
                                                date: fullDateStr.fullFormattedDate,
                                                description: task.description,
                                                isCompleted: false)
                taskDataModel = try await addTask(taskToSave)
                success = true
            } catch {
                print("Error adding: \(error.localizedDescription)")
            }
        }
        
    }

    @MainActor
    func getTaskBy(id: String) async throws {
        do {
            let domainItem = try await apiService.getOneAsync(id: id)
            print("task completed? \(domainItem.isCompleted)")
            self.taskDataModel = convertFrom(domaintTodoTask: domainItem)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    // MARK: - Private methods

    private func addTask(_ domainTask: DomainTodoTask) async throws -> TaskDataModel {
        do {
            let domainTodoTask = try await apiService.newAsync(domainTask)
            return convertFrom(domaintTodoTask: domainTodoTask)
        } catch {
            print("Error \(error.localizedDescription)")
            throw tempAddingError
        }
    }

    private func updateTask(_ domainTask: DomainTodoTask) async throws -> TaskDataModel {
        do {
            let domainTodoTask = try await apiService.updateAsync(domainTask)
            return convertFrom(domaintTodoTask: domainTodoTask)
        } catch {
            print("Error \(error.localizedDescription)")
            throw tempUpdatingError
        }
    }


    private func convertFrom(domaintTodoTask: DomainTodoTask) -> TaskDataModel {
        // TODO: split date and time !
        return TaskDataModel(date: domaintTodoTask.date,
                             time: domaintTodoTask.date,
                             title: domaintTodoTask.title,
                             description: domaintTodoTask.description, 
                             isDone: domaintTodoTask.isCompleted)
    }
}
