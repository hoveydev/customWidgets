import Foundation
import SwiftUI
import UIKit
import Combine

struct Results: Codable {
    
    let results: SunsetSunriseData
    
}

struct SunsetSunriseData: Codable {

    let sunrise: String
    let sunset: String

}

class apiCall {
    func getSunriseSunsetData(completion:@escaping (Results) -> ()) {
        guard let url = URL(string: "https://api.sunrisesunset.io/json?lat=42.990929&lng=-71.463089&timezone=EST&date=today") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let finalData = try! JSONDecoder().decode(Results.self, from: data!)
            // print(finalData)
            
            DispatchQueue.main.async {
                completion(finalData)
            }
        }
        .resume()
    }
}
