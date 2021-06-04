//
//  AviationStackDataModel.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 4/29/21.
//

import Foundation

//MARK:- AviationStackDataModel
class AviationStackDataModel: Codable {
    
    //MARK: Init
    init() {
        self.data = []
        self.pagination = AviationStackPaginationInfo(limit: 0, offset: 0, count: 0, total: 0)
    }
    
    
    //MARK: Properties
    var data: [AviationStackData]
    var pagination: AviationStackPaginationInfo
    
}

//MARK:- AviationStackPaginationInfo
class AviationStackPaginationInfo: Codable {
    
    //MARK: Initializers
    
    internal init(limit: Int, offset: Int, count: Int, total: Int) {
        self.limit = limit
        self.offset = offset
        self.count = count
        self.total = total
    }
    
    
    //MARK: Properties
    var limit: Int
    var offset: Int
    var count: Int
    var total: Int
}


//MARK:- AviationStackData
class AviationStackData: Codable {
    
    //MARK: Properties
    var flight_date: String
    var flight_status: String
    var departure: AviationStackAirportInfo
    var arrival: AviationStackAirportInfo
    var airline: AviationStackAirline
    var flight: AviationStackFlight
    var aircraft: AviationStackAircraft?
    var live: AviationStackLiveInfo?
    
}

//MARK:- AviationStackAirportInfo
class AviationStackAirportInfo: Codable {
    
    //MARK: Properties
    var airport: String?
    var timezone: String?
    var iata: String
    var icao: String
    var terminal: String?
    var gate: String?
    var delay: Int?
    var scheduled: String?
    var estimated: String?
    var actual: String?
    var estimated_runway: String?
    var actual_runway: String?
    var baggage: String?
    
}

//MARK:- AviationStackAirline
class AviationStackAirline: Codable {
    
    //MARK: Properties
    var name: String
    var iata: String
    var icao: String
    
}

//MARK:- AviationStackFlight
class AviationStackFlight: Codable {
    
    //MARK: Properties
    var number: String
    var iata: String
    var icao: String
    
}

//MARK:- AviationStackAircraft
class AviationStackAircraft: Codable {
    
    //MARK: Properties
    var registration: String
    var iata: String
    var icao: String
    var icao24: String
    
}

//MARK:- AviationStackLiveInfo
class AviationStackLiveInfo: Codable {
    
    //MARK: Properties
    var updated: String
    var latitude: Double
    var longitude: Double
    var altitude: Double
    var direction: Double
    var speed_horizontal: Double
    var speed_vertical: Double
    var is_ground: Bool
    
}



//MARK:- Test Instance For AviationStackDataModel
class ASDTest {
    
    static var data: AviationStackData {
        get {
            let rawJSONString = """
                {
                    "pagination": {
                        "limit": 100,
                        "offset": 0,
                        "count": 2,
                        "total": 2
                    },
                    "data": [
                        {
                            "flight_date": "2021-06-02",
                            "flight_status": "active",
                            "departure": {
                                "airport": "John F Kennedy International",
                                "timezone": "America/New_York",
                                "iata": "JFK",
                                "icao": "KJFK",
                                "terminal": null,
                                "gate": null,
                                "delay": 19,
                                "scheduled": "2021-06-02T18:30:00+00:00",
                                "estimated": "2021-06-02T18:30:00+00:00",
                                "actual": null,
                                "estimated_runway": null,
                                "actual_runway": null
                            },
                            "arrival": {
                                "airport": "Heathrow",
                                "timezone": "Europe/London",
                                "iata": "LHR",
                                "icao": "EGLL",
                                "terminal": null,
                                "gate": null,
                                "baggage": null,
                                "delay": null,
                                "scheduled": "2021-06-03T06:30:00+00:00",
                                "estimated": "2021-06-03T06:30:00+00:00",
                                "actual": null,
                                "estimated_runway": null,
                                "actual_runway": null
                            },
                            "airline": {
                                "name": "British Airways",
                                "iata": "BA",
                                "icao": "BAW"
                            },
                            "flight": {
                                "number": "112",
                                "iata": "BA112",
                                "icao": "BAW112",
                                "codeshared": null
                            },
                            "aircraft": null,
                            "live": null
                        },
                        {
                            "flight_date": "2021-06-01",
                            "flight_status": "active",
                            "departure": {
                                "airport": "John F Kennedy International",
                                "timezone": "America/New_York",
                                "iata": "JFK",
                                "icao": "KJFK",
                                "terminal": null,
                                "gate": null,
                                "delay": 19,
                                "scheduled": "2021-06-01T18:30:00+00:00",
                                "estimated": "2021-06-01T18:30:00+00:00",
                                "actual": "2021-06-01T18:49:00+00:00",
                                "estimated_runway": "2021-06-01T18:49:00+00:00",
                                "actual_runway": "2021-06-01T18:49:00+00:00"
                            },
                            "arrival": {
                                "airport": "Heathrow",
                                "timezone": "Europe/London",
                                "iata": "LHR",
                                "icao": "EGLL",
                                "terminal": "5",
                                "gate": null,
                                "baggage": null,
                                "delay": null,
                                "scheduled": "2021-06-02T06:30:00+00:00",
                                "estimated": "2021-06-02T06:30:00+00:00",
                                "actual": null,
                                "estimated_runway": null,
                                "actual_runway": null
                            },
                            "airline": {
                                "name": "British Airways",
                                "iata": "BA",
                                "icao": "BAW"
                            },
                            "flight": {
                                "number": "112",
                                "iata": "BA112",
                                "icao": "BAW112",
                                "codeshared": null
                            },
                            "aircraft": {
                                "registration": "G-YMMK",
                                "iata": "B772",
                                "icao": "B772",
                                "icao24": "4007F6"
                            },
                            "live": {
                                "updated": "2021-06-01T22:37:20+00:00",
                                "latitude": 40.65,
                                "longitude": -73.78,
                                "altitude": 0,
                                "direction": 120,
                                "speed_horizontal": 14.816,
                                "speed_vertical": 0,
                                "is_ground": true
                            }
                        }
                    ]
                }
            """
            let jsonData = rawJSONString.data(using: .utf8)!
            let decoder = JSONDecoder()
            let aviationStackDataModel = try! decoder.decode(AviationStackDataModel.self, from: jsonData)
            return aviationStackDataModel.data.first!
        }
    }
}
