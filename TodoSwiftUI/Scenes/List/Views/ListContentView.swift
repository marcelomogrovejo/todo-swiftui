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

    // TODO: move to listViewModel ???
    @State private var showDeleteConfirmationAlert = false
    @State private var showAddTaskSheet = false
    @State private var onEditingTask: ListDataModel? = nil

    private struct Constants {
        static let btnDeleteTitle = "Delete"
        static let btnDeleteIconName = "trash.fill"
        static let btnEditTitle = "Edit"
        static let btnEditIconName = "square.and.pencil"
        
        
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(listViewModel.filterTasks) { task in
                    TaskRowView(task: task)
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
                                Label(Constants.btnDeleteTitle, systemImage: Constants.btnDeleteIconName)
                            }
                            .tint(.Button.removeBackgroundColor)

                            // MARK: - Edit a task button
                            Button {
                                self.onEditingTask = task
                            } label: {
                                Label(Constants.btnEditTitle, systemImage: Constants.btnEditIconName)
                            }
                            .tint(.Button.editBackgroundColor)
                        }
                        // MARK: - Delete confirmation popup
                        /** It is recommedable to use .confirmationDialog toguether with .swipeActions to avoid synchronization issues.
                         https://stackoverflow.com/questions/62720595/how-to-add-confirmation-to-ondelete-of-list-in-swiftui
                         */
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
            .animation(.spring, value: listViewModel.filterTasks)
            // MARK: - Edit task sheet popup
            .sheet(item: $onEditingTask, onDismiss: {
                // TODO: check it out if this is the correct way, repeat this code snippet
                Task {
                    do {
                        try await self.populateList()
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
                        listViewModel.showPendingTasks.toggle()
                    } label: {
                        Label(
                            title: { },
                            icon: {
                                Image(systemName: listViewModel.showPendingTasks ?
                                      "checkmark.circle" : "checkmark.circle.fill")
                            }
                        )
                    }
                    .tint(Color.Button.foregroundColor)
                }
                // MARK: - Add new task button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddTaskSheet = true
                    } label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: "plus") }
                        )
                    }
                    .tint(Color.Button.foregroundColor)
                    // MARK: - Add new task sheet popup
                    .sheet(isPresented: $showAddTaskSheet, onDismiss: {
                        // TODO: check it out if this is the correct way, repeat this code snippet
                        Task {
                            do {
                                try await self.populateList()
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
                    try await self.populateList()
                } catch {
                    // TODO: implement alert/error ?
                }
            }
            // MARK: - Empty content
            // TODO: implement spinner as well
            .overlay {
                /** 
                 Empty view how to (Available on iOS 17.x)
                 https://www.avanderlee.com/swiftui/contentunavailableview-handling-empty-states/
                 */
                if listViewModel.tasks.isEmpty {
                    ContentUnavailableView {
                        Label("Tasks not found.", systemImage: "checklist.checked")
                    }
                }
            }
        }
    }

    // MARK: - Private methods

    private func populateList() async throws {
        do {
            try await self.listViewModel.getAllTasks()
        } catch {
            // TODO: implement alert/error ?
        }
    }

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
