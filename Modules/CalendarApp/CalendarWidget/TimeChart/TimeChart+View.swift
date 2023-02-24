import SwiftUI

struct TimeChart: View {    
    let sunriseTime: Date
    let sunsetTime: Date
    let currentTime: Date
    let startOfDay: Date
    let endOfDay: Date
    
    let fullCircleWidth: CGFloat = 1
    let TODCircleWidth: CGFloat = 3
    
    var body: some View {
        let totalMinutes = endOfDay.timeIntervalSince(startOfDay) / 60
        let currentMinutes = currentTime.timeIntervalSince(startOfDay) / 60
        
        let sunriseHour = Calendar.current.component(.hour, from: sunriseTime)
        let sunriseMinute = Calendar.current.component(.minute, from: sunriseTime)
        let sunriseMinutes = sunriseHour * 60 + sunriseMinute
        let sunriseAngle = Angle.degrees(360 * (Double(sunriseMinutes) / totalMinutes) - 90)

        let sunsetHour = Calendar.current.component(.hour, from: sunsetTime)
        let sunsetMinute = Calendar.current.component(.minute, from: sunsetTime)
        let sunsetMinutes = sunsetHour * 60 + sunsetMinute
        let sunsetAngle = Angle.degrees(360 * (Double(sunsetMinutes) / totalMinutes) + 90)

        let angle = Angle.degrees(360 * (currentMinutes / totalMinutes) - 90)
        
        return ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: fullCircleWidth)
            Circle()
                .trim(from: 0, to: CGFloat(currentMinutes / totalMinutes))
                .stroke(Color.blue, lineWidth: TODCircleWidth)
                .rotationEffect(.degrees(-180))
            Image(systemName: "circle.fill")
                .font(.system(size: 7))
                .foregroundColor(.blue)
                .rotationEffect(-sunriseAngle + .degrees(90))
                .offset(x: 0, y: -50)
                .rotationEffect(sunriseAngle)
            Image(systemName: "circle.fill")
                .font(.system(size: 7))
                .foregroundColor(.blue)
                .rotationEffect(-sunsetAngle + .degrees(90))
                .offset(x: 0, y: 50)
                .rotationEffect(sunsetAngle)
            Image(systemName: "sun.max")
                .foregroundColor(.orange)
                .offset(x: 0, y: -50)
                .rotationEffect(angle)
        }.rotationEffect(.degrees(-90))
    }
}

// this is currently just a clock
// sunrise and sunset images would either need to be adjusted,
// or we need a new method

// could put a line thru???
