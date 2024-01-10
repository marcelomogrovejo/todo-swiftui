//
//  TaskContentView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 25/12/2023.
//

import SwiftUI

struct TaskContentView: View {

    private let taskId: String?

    init(taskId: String?) {
        self.taskId = taskId
    }

    @StateObject private var taskViewModel = TaskViewModel()

    // Can be used the old school to display and get date and time as in TodoMVP version
    /*
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
     */

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Task") {
                    TextField("title", text: $taskViewModel.taskDataModel.title)
                        .autocorrectionDisabled()
                    TextField("description", text: $taskViewModel.taskDataModel.description)
                        .autocorrectionDisabled()
                }

                Section("Schedule") {
                    DatePicker(selection: $taskViewModel.taskDataModel.date,
                               in: Date.now..., displayedComponents: .date) {
                        Text("Date")
                    }
                    DatePicker(selection: $taskViewModel.taskDataModel.time,
                               displayedComponents: .hourAndMinute) {
                        Text("Time")
                    }
                }

                if let _ = taskId {
                    Section {
                        Toggle("Complete task?", isOn: $taskViewModel.taskDataModel.isDone)
                            .toggleStyle(SwitchToggleStyle(tint: Color.Toggle.backgroundColor))
                            .disabled(taskViewModel.taskDataModel.isDone)
                    }
                }
            }
            .navigationTitle("ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Left side button: Cancel
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        self.dismiss()
                    }
                    .tint(Color.Button.foregroundColor)
                }
                // Right side button: Save
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let taskDataModel = TaskDataModel(date: taskViewModel.taskDataModel.date,
                                                          time: taskViewModel.taskDataModel.time,
                                                          title: taskViewModel.taskDataModel.title,
                                                          description: taskViewModel.taskDataModel.description, 
                                                          isDone: taskViewModel.taskDataModel.isDone)
                        Task {
                            do {
                                try await taskViewModel.save(task: taskDataModel, for: taskId)
                            } catch {
                                // TODO: implement alert/error ?
                                print("View Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    .tint(Color.Button.foregroundColor)
                    .disabled(taskViewModel.taskDataModel.title.isEmpty ||
                              taskViewModel.taskDataModel.description.isEmpty)
                }
            }
            .toolbarBackground(Color.NavBar.backgroundColor, 
                               for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .alert("Your task has been \(taskId != nil ? "updated" : "added").", isPresented: $taskViewModel.success) {
                Button("OK") {
                    self.dismiss()
                }
            }
            .onAppear {
                Task {
                    guard let taskId = self.taskId else { return }
                    do {
                        try await self.taskViewModel.getTaskBy(id: taskId)
                    } catch {
                        print("Error \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        let listDataModel = ListDataModel.example()
        TaskContentView(taskId: listDataModel.id.uuidString)
    }
}
