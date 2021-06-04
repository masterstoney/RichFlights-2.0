//
//  RichFlightsWidget.swift
//  RichFlightsWidget
//
//  Created by Tendaishe Gwini on 4/29/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    private let manager = AviationStackManager()
    
    func placeholder(in context: Context) -> FlightStatusEntry {
        FlightStatusEntry(date: Date(), flightInfo: TrackedFlightStatusModel(), configuration: IATACodeIntent())
    }

    func getSnapshot(for configuration: IATACodeIntent, in context: Context, completion: @escaping (FlightStatusEntry) -> ()) {
        
        let date = Date()
        let entry: FlightStatusEntry
        
        if context.isPreview && manager.mostRecentWidgetInfo == nil {
            entry = FlightStatusEntry(date: date, flightInfo: TrackedFlightStatusModel(), configuration: configuration)
        } else {
            entry = FlightStatusEntry(date: date, flightInfo: manager.mostRecentWidgetInfo ?? TrackedFlightStatusModel(), configuration: configuration)
        }
        
        completion(entry)
    }

    func getTimeline(for configuration: IATACodeIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        

        let date = Date()
        
        let flightCode = configuration.code ?? "aa100"
        
        manager.fetch(flightDetails: TrackedFlight(flight_iata: flightCode)) { (data, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            
            //you changed the widget time to month dont forget
            
            
            let flightStatus = TrackedFlightStatusModel(data: data?.data.first)
            let entry = FlightStatusEntry(date: date, flightInfo: flightStatus, configuration: configuration)
            let nextUpdateDate = Calendar.current.date(byAdding: .month, value: 5, to: date)!
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))

            completion(timeline)
        }
        
        
    }
}

struct FlightStatusEntry: TimelineEntry {
    let date: Date
    let flightInfo: TrackedFlightStatusModel
    let configuration: IATACodeIntent
}

struct RichFlightsWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: Provider.Entry

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall: FlightStatusSmallView(info: entry.flightInfo, date: entry.date)
        case .systemMedium: FlightStatusMediumView(info: entry.flightInfo, date: entry.date)
        default: FlightStatusSmallView(info: entry.flightInfo, date: entry.date)
        }
    }
}

@main
struct RichFlightsWidget: Widget {
    let kind: String = "RichFlightsWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: IATACodeIntent.self, provider: Provider()) { entry in
            RichFlightsWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Flight Status")
        .description("Shows the status of a flight.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct RichFlightsWidget_Previews: PreviewProvider {
    static var previews: some View {
        RichFlightsWidgetEntryView(entry: FlightStatusEntry(date: Date(), flightInfo: TrackedFlightStatusModel(), configuration: IATACodeIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        RichFlightsWidgetEntryView(entry: FlightStatusEntry(date: Date(), flightInfo: TrackedFlightStatusModel(), configuration: IATACodeIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
