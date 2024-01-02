//
//  List.swift
//  TodoSwiftUI
//
//  Created by Marcelo Mogrovejo on 15/12/2023.
//

import Foundation

struct ListDataModel: Equatable, Identifiable, Hashable, Decodable {
    var id: UUID
    var avatar: String?
    var username: String
    var title: String
    var date: String
    var description: String
    var isComplete: Bool

    // MARK: - Mock

    static func example() -> ListDataModel {
        return ListDataModel(id: UUID(),
                             username: "hsimpson",
                             title: "Go to Coles",
                             date: Date.now.stringyfiedFullDate,
                             description: "Do a lot of groceries",
                             isComplete: false)
    }

}
