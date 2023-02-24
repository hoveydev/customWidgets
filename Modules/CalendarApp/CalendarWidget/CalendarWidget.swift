import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), sunriseSunsetData: Results.init(results: SunsetSunriseData(sunrise: "6:33:29 AM", sunset: "5:27:59 PM")))
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, sunriseSunsetData: Results.init(results: SunsetSunriseData(sunrise: "6:33:29 AM", sunset: "5:27:59 PM")))
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        
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
            Spacer()
            HStack {
                VStack {
                    Text(viewModel.dayOfWeek(date: entry.date))
                        .font(.title)
                        .fontWeight(.light)
                    Text(viewModel.timeOfDay(date: entry.date))
                        .font(.largeTitle)
                    Spacer()
                }
                .fixedSize(horizontal: true, vertical: false) // used to prevent the time from adjusting the position of other components
                .padding([.trailing], 40)
                .padding()
                VStack {
                    TimeChart(
                        sunriseTime: viewModel.stringToDateObject(time: entry.sunriseSunsetData.results.sunrise),
                        sunsetTime: viewModel.stringToDateObject(time: entry.sunriseSunsetData.results.sunset),
                        currentTime: Date.now,
                        startOfDay: viewModel.startOfDay(date: entry.date),
                        endOfDay: viewModel.endOfDay(date: entry.date)
                    )
                    .frame(width: 70)
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.trailing, 30)
            }
            Spacer()
        }
        .padding()
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
        CalendarWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), sunriseSunsetData: Results(results: SunsetSunriseData(sunrise: "6:33:29 AM", sunset: "5:27:59 PM"))))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
