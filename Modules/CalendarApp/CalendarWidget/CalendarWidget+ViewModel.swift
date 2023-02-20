import Foundation
import WidgetKit
import SwiftUI

class ViewModel: ObservableObject {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func dayOfWeek(date: Date) -> String {
        return String(dateFormatter.weekdaySymbols[calendar.component(.weekday, from: date) - 1])
    }
    
    func timeOfDay(date: Date) -> String {
        return String(DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short))
    }
}
