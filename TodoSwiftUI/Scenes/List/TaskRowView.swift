///
//  TaskRowView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 15/12/2023.
//

import SwiftUI

struct TaskRowView: View {

    private struct Constants {
        static let defaultAvatarWidth: CGFloat = 30.0
        
        // TODO: implement font size
        
        static let defaultTitleFontSize: CGFloat = 14.0
        static let defaultDateFontSize: CGFloat = 13.0
        static let defaultDescriptionFontSize: CGFloat = 12.0
    }

    @EnvironmentObject var listViewModel: ListViewModel

    @Binding var tableViewData: ListDataModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(uiImage: .icnTaskCell)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constants.defaultAvatarWidth, 
                           height: Constants.defaultAvatarWidth,
                           alignment: .topLeading)

                VStack(alignment: .leading) {
                    Text(tableViewData.title)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(Color.Text.highlitedColor)
                    Text(tableViewData.date)
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(Color.Text.defaultColor)
                }

                Spacer()

                /**
                 How to bind between parent/child, List/Row
                 https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-list-or-a-foreach-from-a-binding
                 */
                RadioButton(isSet: $tableViewData.isComplete, size: 25)
                    .frame(width: Constants.defaultAvatarWidth)
                    .onChange(of: tableViewData.isComplete) {
                        Task {
                            do {
                                try await self.listViewModel.completeTask(tableViewData)
                            } catch {
                                // TODO: implement error handling
                                print(error.localizedDescription)
                            }
                        }
                    }
                    .disabled(tableViewData.isComplete)
            }

            Text(tableViewData.description)
                .font(.headline)
                .foregroundStyle(Color.Text.defaultColor)
        }
    }
}

#Preview {
    let listDataModel = ListDataModel(id: UUID(), 
                                      avatar: "",
                                      username: "hsimpson",
                                      title: "Go to Coles",
                                      date: "15/12/2023 6:30pm",
                                      description: "Do some groceries to BBQ",
                                      isComplete: false)
    return TaskRowView(tableViewData: .constant(listDataModel))
}

