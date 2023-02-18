//
//  CalendarWidgetBundle.swift
//  CalendarWidget
//
//  Created by Robert Alec Hovey on 2/18/23.
//

import WidgetKit
import SwiftUI

@main
struct CalendarWidgetBundle: WidgetBundle {
    var body: some Widget {
        CalendarWidget()
        CalendarWidgetLiveActivity()
    }
}
