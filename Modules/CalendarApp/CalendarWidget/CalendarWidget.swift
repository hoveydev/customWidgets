//
//  CalendarWidget.swift
//  CalendarWidget
//
//  Created by Robert Alec Hovey on 2/18/23.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct CalendarWidgetEntryView : View {
    var entry: Provider.Entry
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()

    var body: some View {
        // SOLUTION:
        // Large widget with mutiple links
        // I will create deep linking to separate pages
        // pages will corelate to apps that I redirect to
        // use the pattern from `ContentView` to get an idea of what needs to happen
        VStack {
            // What will be included?
            // 1. current month calendar
            // 2. time w/ sunrise/set graphic
            // 3. Month and day of week
        }
        // use below code for date reference
//        HStack {
//            // Weekday + Day
//            VStack {
//                Spacer()
//                Link(destination: URL(string: "customwidgets")!) {
//                    HStack {
//                        Spacer()
//                        Text(String(dateFormatter.weekdaySymbols[calendar.component(.weekday, from: entry.date) - 1]))
//                        Spacer()
//                    }
//                }
//                HStack {
//                    Spacer()
//                    Text(String(calendar.dateComponents([.day], from: entry.date).day ?? 00))
//                    // maybe instead of day, we put the sunrise/sunset graphic
//                    Spacer()
//                }
//                Spacer()
//            }
//            .frame(width: 75)
//            .padding()
//            Spacer()
//            // Month View
//            VStack {
//                HStack {
//                    Text(String(dateFormatter.monthSymbols[calendar.component(.month, from: entry.date) - 1]))
//                    Spacer()
//                }
//                Spacer()
//                Text("Calendar Here another test to see")
//            }
//            .padding()
//        }
    }
}

struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CalendarWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
