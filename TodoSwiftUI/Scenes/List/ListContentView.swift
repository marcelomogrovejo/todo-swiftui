//
//  ListContentView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 13/12/2023.
//

import SwiftUI

struct ListContentView: View {

    // TODO: Add navigationStack and close buttn
    /*
    @Environment(\.dismiss) var dismiss

        var body: some View {
            Button("Press to dismiss") {
                dismiss()
            }
            .font(.title)
            .padding()
            .background(.black)
        }
    */
    @Environment(\.dismiss) private var dismiss

    var todos: [String] = ["Go to pharmacy",
                "Do something",
                "Go to work",
                "Do something interesting"
    ]

    var body: some View {
        NavigationStack {

            List(todos, id: \.self) { index in
                Text(index)
            }
            .navigationTitle("ToDo List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(.NavBar.backgroundColor ?? .white), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: "xmark") }
                        )
                    })
                    .tint(Color(.Button.foregroundColor ?? .systemBlue))
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // TODO: 
                        print("To add task...")
                    }, label: {
                        Label(
                            title: { },
                            icon: { Image(systemName: "plus") }
                        )
                    })
                    .tint(Color(.Button.foregroundColor ?? .systemBlue))
                }
            }
        }
    }
}

#Preview {
    ListContentView()
}
