import Foundation
import WidgetKit
import SwiftUI

class ViewModel: ObservableObject {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func dayOfMonth(date: Date) -> String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func dayOfWeek(date: Date) -> String {
        return String(dateFormatter.weekdaySymbols[calendar.component(.weekday, from: date) - 1])
    }
    
    func timeOfDay(date: Date) -> String {
        // let timeAsString = String(DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short))
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func startOfDay(date: Date) -> Date {
        // Get the year, month, and day components of the current date
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        // Create a new Date object with the components and a time of midnight
        let components = DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
        let midnight = calendar.date(from: components)
        
        guard let midnight = midnight else { return date }
        return midnight
    }
    
    func endOfDay(date: Date) -> Date {
        // Get the year, month, and day components of the current date
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)

        // Create a new Date object with the components and a time of midnight
        let components = DateComponents(year: year, month: month, day: day, hour: 23, minute: 59, second: 59)
        let midnight = calendar.date(from: components)
        
        guard let midnight = midnight else { return date }
        return midnight
    }
    
    func stringToDateObject(time: String) -> Date {
        dateFormatter.dateFormat = "h:mm:ss a"
        guard let formattedDate = dateFormatter.date(from: time) else { return Date() }
        return formattedDate
    }
}
