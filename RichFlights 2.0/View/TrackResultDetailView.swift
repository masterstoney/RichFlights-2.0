//
//  TrackResultDetailView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 6/2/21.
//

import SwiftUI

struct TrackResultDetailView: View {
    
    var trackedFlight: AviationStackData
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Image(trackedFlight.airline.iata)
                            .resizable()
                            .frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text(trackedFlight.airline.name)
                                .font(.headline)
                            Text("\(trackedFlight.flight.iata) / \(trackedFlight.flight.icao)")
                                .font(.subheadline)
                            Text(trackedFlight.flight_status)
                                .padding(.top, 10)
                        }
                        Spacer()
                    }
                    .padding(.all, 16)
                    HStack {
                        RFTrackedAirportSnippetView(info: trackedFlight.departure, dateOfFlight: dateOfFlight(time:dateFormat:))
                        Spacer()
                        VStack {
                            Text("TO")
                                .font(.headline)
                            Text(flightDuration(departure: trackedFlight.departure, arrival: trackedFlight.arrival))
                                .font(.subheadline)
                        }
                        Spacer()
                        RFTrackedAirportSnippetView(info: trackedFlight.arrival, dateOfFlight: dateOfFlight(time:dateFormat:))
                    }
                    if let liveInfo = trackedFlight.live {
                        RFTrackedFlightLiveInfoView(info: liveInfo, dateOfFlight: dateOfFlight(time:dateFormat:))
                    }
                    if let aircraftInfo = trackedFlight.aircraft {
                        RFTrackedFlightAircraftInfoView(info: aircraftInfo)
                    }
                    RFTrackedAirportInfoView(info: trackedFlight.departure, departure: true, dateOfFlight: dateOfFlight(time:dateFormat:))
                        .padding(.vertical, 16)
                    RFTrackedAirportInfoView(info: trackedFlight.arrival, departure: false, dateOfFlight: dateOfFlight(time:dateFormat:))
                        .padding(.vertical, 16)
                    Spacer()
                }
            }
        }
    }
    
    
    private func dateOfFlight(time: String, dateFormat: String) -> String {
        let correctedTime = TrackedFlightStatusModel.utcCorrection(time: time)
        let isoDateFormatter = ISO8601DateFormatter()
        guard let date = isoDateFormatter.date(from: correctedTime) else {return "N/A"}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    private func flightDuration(departure: AviationStackAirportInfo, arrival: AviationStackAirportInfo) -> String {
        
        guard let departureZone = TimeZone(identifier: departure.timezone ?? "") else {return "N/A"}
        guard let arrivalZone = TimeZone(identifier: arrival.timezone ?? "") else {return "N/A"}
        
        let controlDate = Date()
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = departureZone
        let departureControlhour = calendar.component(.hour, from: controlDate)
        calendar.timeZone = arrivalZone
        let arrivalControlhour = calendar.component(.hour, from: controlDate)
        
        let timezoneDifference = ((departureControlhour - arrivalControlhour) * 3600)
        
        let correctedDeparture = TrackedFlightStatusModel.utcCorrection(time: departure.scheduled ?? "")
        let correctedArrival = TrackedFlightStatusModel.utcCorrection(time: arrival.scheduled ?? "")
        let isoDateFormatter = ISO8601DateFormatter()
        guard let departureDate = isoDateFormatter.date(from: correctedDeparture) else {return "N/A"}
        guard let arrivalDate = isoDateFormatter.date(from: correctedArrival) else {return "N/A"}
        let difference = departureDate.distance(to: arrivalDate) + TimeInterval(timezoneDifference)
        return Date.timeAsString(duration: difference)
    }
    
}

struct TrackResultDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TrackResultDetailView(trackedFlight: ASDTest.data)
    }
}

struct RFTrackResultInfoRow: View {
    
    var title: String
    var details: String
    var oddRow: Bool
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(details)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(oddRow ? Color(.secondarySystemBackground) : Color(.white))
    }
}

struct RFTrackedAirportInfoView: View {
    
    var info: AviationStackAirportInfo
    var departure: Bool
    var dateOfFlight: (String,String) -> String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(departure ? "Departure" : "Arrival") Info")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(red: 0.137, green: 0.690, blue: 0.741, opacity: 1.000))
            VStack(spacing: 0) {
                RFTrackResultInfoRow(title: "Terminal", details: info.terminal ?? "N/A", oddRow: false)
                RFTrackResultInfoRow(title: "Gate", details: info.gate ?? "N/A", oddRow: true)
                RFTrackResultInfoRow(title: "Delay", details: "\(info.delay ?? 0)", oddRow: false)
                if !departure {
                    RFTrackResultInfoRow(title: "Baggage claim", details: info.baggage ?? "N/A", oddRow: true)
                }
                RFTrackResultInfoRow(title: departure ? "Scheduled terminal departure" : "Scheduled touch down time", details: departure ? dateOfFlight(info.scheduled ?? "", "hh:mm a") : dateOfFlight(info.actual_runway ?? "","hh:mm a"), oddRow: departure)
                RFTrackResultInfoRow(title: departure ? "Scheduled takeoff time" : "Scheduled terminal arrival time", details: departure ? dateOfFlight(info.actual_runway ?? "","hh:mm a") : dateOfFlight(info.scheduled ?? "","hh:mm a"), oddRow: !departure)
            }
        }
    }
    
    
}

struct RFTrackedAirportSnippetView: View {
    
    var info: AviationStackAirportInfo
    var dateOfFlight: (String,String) -> String
    
    var body: some View {
        VStack {
            Text(info.iata)
                .font(.largeTitle)
            Text(citynameForAirport(iataCode: info.iata))
                .font(.subheadline)
            Text(dateOfFlight(info.scheduled ?? "","dd-MM-YYYY"))
                .font(.subheadline)
            Text(dateOfFlight(info.scheduled ?? "","hh:mm a"))
                .font(.subheadline)
        }
        .padding(.horizontal, 16)
    }
    
    private func citynameForAirport(iataCode: String) -> String {
        let airports = AirportsData.shared.data
        let airport = airports.first(where: {$0.airportCode == iataCode})
        return airport?.cityName ?? "N/A"
    }
    
}

struct RFTrackedFlightLiveInfoView: View {
    
    var info: AviationStackLiveInfo
    var dateOfFlight: (String,String) -> String
    
    var body: some View {
        VStack {
            HStack {
                Text("Live Flight info")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(red: 0.137, green: 0.690, blue: 0.741, opacity: 1.000))
            VStack(spacing: 0) {
                RFTrackResultInfoRow(title: "Altitude", details: "\(info.altitude)", oddRow: false)
                RFTrackResultInfoRow(title: "Speed (mph)", details: "\(info.speed_horizontal)", oddRow: true)
                RFTrackResultInfoRow(title: "Last updated", details: dateOfFlight(info.updated,"hh:mm a"), oddRow: false)
            }
        }
        .padding(.vertical, 16)
    }
    
}

struct RFTrackedFlightAircraftInfoView: View {
    
    var info: AviationStackAircraft
    
    var body: some View {
        VStack {
            HStack {
                Text("Aircraft info")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color(red: 0.137, green: 0.690, blue: 0.741, opacity: 1.000))
            VStack(spacing: 0) {
                RFTrackResultInfoRow(title: "Registration", details: info.registration, oddRow: false)
                RFTrackResultInfoRow(title: "IATA type", details: info.iata, oddRow: true)
            }
        }
        .padding(.vertical, 16)
    }
}
