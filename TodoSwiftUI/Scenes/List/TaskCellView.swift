///
//  TaskCellView.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 15/12/2023.
//

import SwiftUI

struct TaskCellView: View {

    private struct Constants {
        static let defaultAvatarWidth: CGFloat = 30.0
        
        // TODO: implement font size
        
        static let defaultTitleFontSize: CGFloat = 14.0
        static let defaultDateFontSize: CGFloat = 13.0
        static let defaultDescriptionFontSize: CGFloat = 12.0
    }

    @State var tableViewData: ListDataModel
    @State var isCompleted: Bool

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(uiImage: .icnTaskCell)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constants.defaultAvatarWidth, height: Constants.defaultAvatarWidth, alignment: .topLeading)

                VStack(alignment: .leading) {
                    Text(tableViewData.title)
                        .font(.caption)
                        .bold()
                        .foregroundStyle(Color(.Text.highlitedColor ?? .lightGray))
                    Text(tableViewData.date)
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(Color(.Text.defaultColor ?? .darkGray))
                }

                Spacer()

//                RadioButton("", callback: { message in
//                    print(message)
//                }, selectedID: "")
                RadioButton(size: 25, value: $isCompleted)
                .frame(width: Constants.defaultAvatarWidth)
            }

            Text(tableViewData.description)
                .font(.headline)
                .foregroundStyle(Color(.Text.defaultColor ?? .darkGray))
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
    return TaskCellView(tableViewData: listDataModel,
                 isCompleted: false)
}

