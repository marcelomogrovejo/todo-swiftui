//
//  String+Date.swift
//  TodoMVP
//
//  Created by Marcelo Mogrovejo on 03/12/2023.
//

import Foundation

extension String {

    var fullFormattedDate: Date {
        getFullFormattedDate()
    }

    var formattedDate: Date {
        getFormattedDate()
    }

    var formattedTime: Date {
        getFormattedTime()
    }

    var isoFormattedDate: Date {
        getISOFormattedDate()
    }

    private func getFullFormattedDate() -> Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        21/12/2023 10:16 pm
        dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
//        dateFormatter.dateStyle = .short
//        dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.date(from: self) ?? Date.now
        return formattedDate
    }

    private func getFormattedDate() -> Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
//        dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
        dateFormatter.dateStyle = .short
        let formattedDate = dateFormatter.date(from: self) ?? Date.now
        return formattedDate
    }

    private func getFormattedTime() -> Date {
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
//        dateFormatter.dateFormat = "dd/MM/yyyy, h:mm a"
        dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.date(from: self) ?? Date.now
        return formattedDate
    }

    private func getISOFormattedDate() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
        let isoFormattedDate = dateFormatter.date(from: self) ?? Date.now
        return isoFormattedDate
    }

}
