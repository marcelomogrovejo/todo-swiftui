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
    @State private var itemToRemove: ListDataModel? = nil
    @State private var showAddTask = false
    @State private var presentedTask: ListDataModel? = nil
    @State private var showNotCompletedOnly: Bool = false

    // Filter completed tasks
    var tasks: [ListDataModel] {
        if showNotCompletedOnly {
            return listViewModel.tasks.filter { !$0.isComplete }
        } else {
            return listViewModel.tasks
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks.indices, id: \.self) { idx in
                    TaskRowView(taskIdx: idx)
                        .swipeActions(allowsFullSwipe: false) {
                        /**
                         (role: .destructive) triggers the cell removing effect, so we can se a cell vanishing meanwhile the alert is shown.
                         Then the cell appear suddenly behind the alert giving a bad user experience effect.
                         Figure out how to trigger this destructive effect when we confirm deletion through alert.
                         */
                            Button/*(role: .destructive)*/ {
                                self.itemToRemove = tasks[idx]
                                self.showDeleteConfirmationAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(.Button.removeBackgroundColor)

                            Button {
                                self.presentedTask = tasks[idx]
                            } label: {
                                Label("Edit", systemImage: "square.and.pencil")
                            }
                            .tint(.Button.editBackgroundColor)
                        }
                }
            }
            .environmentObject(listViewModel)
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
                // Close sheet
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: "xmark") }
                        )
                    })
                    .tint(Color.Button.foregroundColor)
                }
                // Filter completed tasks
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNotCompletedOnly.toggle()
                    } label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: showNotCompletedOnly ? "checkmark.circle.fill" : "checkmark.circle") }
                        )
                    }
                    .tint(Color.Button.foregroundColor)
                }
                // Add new task
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddTask = true
                    }, label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: "plus") }
                        )
                    })
                    .tint(Color.Button.foregroundColor)
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
            
            .task {
                do {
                    try await self.listViewModel.getAllTasks()
                } catch {
                    // TODO: implement alert/error ?
                }
            }
            .alert(isPresented: $showDeleteConfirmationAlert) {
                Alert(title: Text("Delete Task"),
                      message: Text("Are you sure you want to remove the task?"),
                      primaryButton: .default(Text("Ok"), action: {
                    Task {
                        do {
                            guard let itemToRemove = itemToRemove else { return }
                            try await self.listViewModel.removeTask(itemToRemove)
                        } catch {
                            // TODO: implement alert/error ?
                        }
                    }
                }), secondaryButton: .cancel(Text("Cancel")))
            }
            .overlay {
                // Available on iOS 17.x
                // https://www.avanderlee.com/swiftui/contentunavailableview-handling-empty-states/
                if tasks.isEmpty {
                    ContentUnavailableView {
                        Label("No uncompleted tasks.", systemImage: "checklist.checked")
                    }
                }
            }
        }
    }
}

#Preview {
    ListContentView()
}
