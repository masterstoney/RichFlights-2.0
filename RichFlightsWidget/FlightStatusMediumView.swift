//
//  FlightStatusMediumView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 4/29/21.
//

import SwiftUI
import WidgetKit

struct FlightStatusMediumView: View {
    
    var info: TrackedFlightStatusModel
    var date: Date
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FlightStatusMediumView_Previews: PreviewProvider {
    static var previews: some View {
        FlightStatusMediumView(info: TrackedFlightStatusModel(), date: Date())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
