//
//  Date+String.swift
//  TodoMVP
//
//  Created by Marcelo Mogrovejo on 03/12/2023.
//

import Foundation

extension Date {

    var finalDate: Date {
        getFinalDate()
    }

    var stringyfiedDate: String {
        getStringyfiedDate()
    }

    var stringyfiedTime: String {
        getStringyfiedTime()
    }

    var stringyfiedFullDate: String {
        getStringyfiedFullDate()
    }

    private func getFinalDate() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: self)
        return calendar.date(from: components)!
    }

    
    // TODO: WARNING !!
    // It's not working, for any reason detect GTM+8 and also lost the minutes and seconds using 00:00 instead.
    
    private func getStringyfiedDate() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])

        return dateFormatter.string(from: self)
    }

    private func getStringyfiedTime() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])

        return dateFormatter.string(from: self)
    }

    private func getStringyfiedFullDate() -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])

        return dateFormatter.string(from: self)
    }

}
