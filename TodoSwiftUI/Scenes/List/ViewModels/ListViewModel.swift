//
//  ListViewModel.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 23/12/2023.
//

import SwiftUI
import TodoRepositoryPackage

protocol ListViewModelProtocol: AnyObject {
    func getAllTasks() async throws
    func removeTask(_ task: ListDataModel) async throws
    func completeTask(_ task: ListDataModel) async throws
}

class ListViewModel: ObservableObject, ListViewModelProtocol {

    @Published var tasks: [ListDataModel] = []

    // TODO: implement the PetShop factory ?
    private let apiService = ApiService()

    /**
     "Methods or types marked with @MainActor can (for the most part) safely modify the UI because it will always be running on the main queue"

     https://www.hackingwithswift.com/quick-start/concurrency/how-to-use-mainactor-to-run-code-on-the-main-queue
     */
    @MainActor
    func getAllTasks() async throws {
        do {
            // TODO: Warning ! temporary commented to mock the table content.
//            let domainTasks = try await self.getAllTasksMock()
            let domainTasks = try await apiService.getAllAsync()
            var tempTaskArr: [ListDataModel] = []
            domainTasks.forEach{ domainTask in
                if let domainTaskId = UUID(uuidString: domainTask.id) {
                    let listDataModel = ListDataModel(id: domainTaskId,
                                                      username: domainTask.username,
                                                      title: domainTask.title,
                                                      // TODO: Warning !
                                                      date: "\(domainTask.date)",
                                                      description: domainTask.description,
                                                      isComplete: domainTask.isCompleted)
                    tempTaskArr.append(listDataModel)
                } else {
                    print("Error bad item id, item won't be added to the list.")
                }
            }
            self.tasks = tempTaskArr.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    @MainActor
    func removeTask(_ task: ListDataModel) async throws {
        do {
            let domainTodoTask = DomainTodoTask(id: task.id.uuidString,
                                                avatar: task.avatar ?? "",
                                                username: task.username,
                                                title: task.title,
                                                date: task.date.fullFormattedDate,
                                                description: task.description)
            let success = try await apiService.deleteAsync(domainTodoTask)
            if success {
                guard let taskToRemoveIndex = tasks.firstIndex(of: task) else {
                    print("Error task to delete not found")
                    return
                }
                tasks.remove(at: taskToRemoveIndex)
            } else {
                print("Error success on deletioon \(success)")
            }
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    @MainActor
    func completeTask(_ task: ListDataModel) async throws {
        do {
            let domainItemToComplete = DomainTodoTask(id: task.id.uuidString,
                                                      avatar: task.avatar ?? "",
                                                      username: task.username,
                                                      title: task.title,
                                                      date: task.date.fullFormattedDate,
                                                      description: task.description,
                                                      isCompleted: true)
            let completedDomainItem = try await apiService.completeTaskAsync(domainItemToComplete)
            guard let taskToRefreshIndex = tasks.firstIndex(of: task) else {
                print("Error task to delete not found")
                return
            }
            tasks.remove(at: taskToRefreshIndex)
            let completedListItemModel = ListDataModel(id: UUID(uuidString: completedDomainItem.id)!,
                                                       avatar: completedDomainItem.avatar,
                                                       username: completedDomainItem.username,
                                                       title: completedDomainItem.title,
                                                       date: completedDomainItem.date.stringyfiedFullDate,
                                                       description: completedDomainItem.description,
                                                       isComplete: completedDomainItem.isCompleted)
            tasks.insert(completedListItemModel, at: taskToRefreshIndex)
        } catch {
            print("Error \(error.localizedDescription)")
        }
    }

    // MARK: - Mocks

    private func getAllTasksMock() async throws -> [DomainTodoTask] {
        var tasks: [DomainTodoTask] = []

        let task1 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "hsimpson", title: "Go to the beach", date: Date.now, description: "BBq on the beach with the guys")
        tasks.append(task1)

        let task2 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "hsimpson", title: "Do some groceries", date: Date.now, description: "Go an buy stuff on Coles")
        tasks.append(task2)

        let task3 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "hsimpson", title: "Validate degree", date: Date.now, description: "Translate paper and validate")
        tasks.append(task3)

        let task4 = DomainTodoTask(id: UUID().uuidString, avatar: "", username: "hsimpson", title: "Move to Adelaide", date: Date.now, description: "Gather all the shit and move...")
        tasks.append(task4)

        return tasks
    }
}
