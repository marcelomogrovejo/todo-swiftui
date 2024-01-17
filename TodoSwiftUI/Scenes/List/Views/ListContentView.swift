//
//  ListContentView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 13/12/2023.
//

import SwiftUI

struct ListContentView: View {

    @StateObject private var listViewModel = ListViewModel()

    @Environment(\.dismiss) private var dismiss

    @State private var showDeleteConfirmationAlert = false
    @State private var showAddTask = false
    @State private var presentedTask: ListDataModel? = nil
    @State private var showNotCompletedOnly: Bool = false

    // MARK: - Filter completed tasks
    // TODO: WARNING !
//    var tasks: [ListDataModel] {
//        if showNotCompletedOnly {
//            return listViewModel.tasks.filter { !$0.isComplete }
//        } else {
//            return listViewModel.tasks
//        }
//    }

    var body: some View {
        NavigationStack {
            List {
                ForEach($listViewModel.tasks) { $task in
                    TaskRowView(task: $task)
                        .swipeActions(allowsFullSwipe: false) {
                            // MARK: - Remove a task button
                            /**
                             (role: .destructive) triggers the cell removing effect, so we can se a cell vanishing meanwhile the alert is shown.
                             Then the cell appear suddenly behind the alert giving a bad user experience effect.
                             Figure out how to trigger this destructive effect when we confirm deletion through alert.
                             */
                            Button/*(role: .destructive)*/ {
                                self.showDeleteConfirmationAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(.Button.removeBackgroundColor)

                            // MARK: - Edit a task button
                            Button {
                                self.presentedTask = task
                            } label: {
                                Label("Edit", systemImage: "square.and.pencil")
                            }
                            .tint(.Button.editBackgroundColor)
                        }
                        // MARK: - Delete confirmation popup
                        .confirmationDialog(
                            Text("Are you sure you want to remove the task?"),
                            isPresented: $showDeleteConfirmationAlert,
                            titleVisibility: .visible) {
                            Button("Delete", role: .destructive) {
                                withAnimation {
                                        self.deleteTask(task)
                                }
                            }
                        }
                }
                /** 
                 It just works when .swipeActions is not implemented.
                 Prior iOS 15.x version
                 */
                /*
                .onDelete { offsets in
                    print("IndexSet: \(offsets)")
                    listViewModel.indexToDelete = offsets.last ?? 0
                }
                 */
            }
            .environmentObject(listViewModel)
            // MARK: - Edit task sheet popup
            .sheet(item: $presentedTask, onDismiss: {
                // TODO: check it out if this is the correct way, repeat this code snippet
                Task {
                    do {
                        try await self.listViewModel.getAllTasks()
                    } catch {
                        // TODO: implement alert/error ?
                    }
                }
            }, content: { task in
                TaskContentView(taskId: task.id.uuidString)
            })
            .navigationTitle("ToDo List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.NavBar.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                // MARK: - Close tasks list button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.dismiss()
                    } label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: "xmark") }
                        )
                    }
                    .tint(Color.Button.foregroundColor)
                }
                // MARK: - Filter completed tasks button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNotCompletedOnly.toggle()
                    } label: {
                        Label(
                            title: { },
                            icon: {
                                Image(systemName: showNotCompletedOnly ? 
                                      "checkmark.circle.fill" :
                                        "checkmark.circle")
                            }
                        )
                    }
                    .tint(Color.Button.foregroundColor)
                }
                // MARK: - Add new task button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddTask = true
                    } label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: "plus") }
                        )
                    }
                    .tint(Color.Button.foregroundColor)
                    // MARK: - Add new task sheet popup
                    .sheet(isPresented: $showAddTask, onDismiss: {
                        // TODO: check it out if this is the correct way, repeat this code snippet
                        Task {
                            do {
                                try await self.listViewModel.getAllTasks()
                            } catch {
                                // TODO: implement alert/error ?
                            }
                        }
                    }) {
                        TaskContentView(taskId: nil)
                    }
                }
            }
            //            .navigationDestination(for: ListDataModel.self) { listDataModel in
            //                TaskContentView(taskId: listDataModel.id.uuidString)
            //            }
            // MARK: - onAppear
            .task {
                do {
                    try await self.listViewModel.getAllTasks()
                } catch {
                    // TODO: implement alert/error ?
                }
            }
            // MARK: - Empty content
            .overlay {
                /** 
                 Empty view how to (Available on iOS 17.x)
                 https://www.avanderlee.com/swiftui/contentunavailableview-handling-empty-states/
                 */
                // TODO: WARNING !
//                if tasks.isEmpty {
                if listViewModel.tasks.isEmpty {
                    ContentUnavailableView {
                        Label("Tasks not found.", systemImage: "checklist.checked")
                    }
                }
            }
        }
    }

    // MARK: - Private methods

    private func deleteTask(_ task: ListDataModel) {
        Task {
            do {
                try await self.listViewModel.removeTask(task)
            } catch {
                // TODO: implement alert/error ?
            }
        }
    }
}

#Preview {
    ListContentView()
}
