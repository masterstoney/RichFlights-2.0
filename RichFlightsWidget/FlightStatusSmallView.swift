//
//  FlightStatusSmallView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 4/29/21.
//

import SwiftUI
import WidgetKit

struct FlightStatusSmallView: View {
    
    var info: TrackedFlightStatusModel
    var date: Date
    
    var body: some View {
        VStack {
            HStack {
                Text(info.eta)
                    .font(.headline)
                Spacer()
            }
            .padding()
            Spacer()
            HStack {
                Text(info.flightNo)
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text(info.departurePort)
                    .font(.subheadline)
                Image(systemName: "arrow.right")
                    .font(.subheadline)
                Text(info.arrivalPort)
                    .font(.subheadline)
                Spacer()
            }
            .padding([.horizontal,.bottom])
        }
    }
}

struct FlightStatusSmallView_Previews: PreviewProvider {
    static var previews: some View {
        FlightStatusSmallView(info: TrackedFlightStatusModel(), date: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
