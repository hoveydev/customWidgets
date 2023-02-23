import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), sunriseSunsetData: Results.init(results: SunsetSunriseData(sunrise: "", sunset: "")))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, sunriseSunsetData: Results.init(results: SunsetSunriseData(sunrise: "", sunset: "")))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        
        // Make the API call to get the data
        apiCall().getSunriseSunsetData { (data) in
            let entry = SimpleEntry(date: currentDate, configuration: configuration, sunriseSunsetData: data)
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }

}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let sunriseSunsetData: Results
}

struct CalendarWidgetEntryView : View {

    var entry: Provider.Entry
    var viewModel = ViewModel()

    var body: some View {
        // SOLUTION:
        // Large widget with mutiple links
        // I will create deep linking to separate pages
        // pages will corelate to apps that I redirect to
        // use the pattern from `ContentView` to get an idea of what needs to happen
        VStack {
            // What will be included?
            // 1. Month and day of week
            // 2. time w/ sunrise/set graphic
            HStack {
                Text(viewModel.dayOfWeek(date: entry.date))
                Text(viewModel.timeOfDay(date: entry.date))
                Spacer()
            }
            HStack {
                TimeChart(
                    sunriseTime: viewModel.stringToDateObject(time: entry.sunriseSunsetData.results.sunrise),
                    sunsetTime: viewModel.stringToDateObject(time: entry.sunriseSunsetData.results.sunset),
                    currentTime: Date.now,
                    startOfDay: viewModel.startOfDay(date: entry.date),
                    endOfDay: viewModel.endOfDay(date: entry.date)
                )
                // ParabolicLine()
            }
            .border(Color.black)
            Spacer()
            // 3. current month calendar (2, w/ month ahead)
            HStack {
                // calendars here
                Text("Calendars Here")
            }
            .border(Color.black)
        }
        .padding()
        // use below code for date reference
// Text(String(dateFormatter.weekdaySymbols[calendar.component(.weekday, from: entry.date) - 1]))
// Text(String(calendar.dateComponents([.day], from: entry.date).day ?? 00))
// Text(String(dateFormatter.monthSymbols[calendar.component(.month, from: entry.date) - 1]))
    }
}

struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            CalendarWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                // .background(Color("WidgetBackground"))
                // background color can be changed in 'Assets'
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), sunriseSunsetData: Results(results: SunsetSunriseData(sunrise: "", sunset: ""))))
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
