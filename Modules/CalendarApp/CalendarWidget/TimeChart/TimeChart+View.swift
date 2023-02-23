import SwiftUI

struct TimeChart: View {    
    let sunriseTime: Date
    let sunsetTime: Date
    let currentTime: Date
    let startOfDay: Date
    let endOfDay: Date
    
    let fullCircleWidth: CGFloat = 1
    let TODCircleWidth: CGFloat = 5
    
    var body: some View {
        let totalMinutes = endOfDay.timeIntervalSince(startOfDay) / 60
        let currentMinutes = currentTime.timeIntervalSince(startOfDay) / 60
        
        let angle = Angle.degrees(360 * (currentMinutes / totalMinutes))
        
        return ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: fullCircleWidth)
            Circle()
                .trim(from: 0, to: CGFloat(currentMinutes / totalMinutes))
                .stroke(Color.blue, lineWidth: TODCircleWidth)
                .rotationEffect(.degrees(-180))
            Image(systemName: "sunrise")
                .rotationEffect(.degrees(90))
                .offset(x: 0, y: -110)
            Image(systemName: "sunset")
                .rotationEffect(.degrees(90))
                .offset(x: 0, y: 110)
            Image(systemName: "sun.max")
                .foregroundColor(.orange)
                .offset(x: 0, y: -110)
                .rotationEffect(angle)
        }.rotationEffect(.degrees(-90))
    }
}

// this is currently just a clock
// sunrise and sunset images would either need to be adjusted,
// or we need a new method

// could put a line thru???
