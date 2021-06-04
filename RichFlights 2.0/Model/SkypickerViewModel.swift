//
//  SkypickerViewModel.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 6/1/21.
//

import UIKit

class SkypickerViewModel {
    
    //MARK: Initializers
    
    init(rawData: SkypickerTrip, returnTrip: Bool) {
        self.rawData = rawData
        self.returnTrip = returnTrip
        configureTripLegs()
    }
    
    //MARK: Properties
    
    var rawData: SkypickerTrip
    var returnTrip: Bool
    var departureLegs: [SkypickerRoute] = []
    var returnLegs: [SkypickerRoute] = []
    
    //MARK: Methods
    
    private func configureTripLegs() {
        
       // var departureAirport = rawData.flyFrom
        let arrivalAirport = rawData.flyTo
        
        guard var destinationIndex = rawData.route.firstIndex(where: {$0.flyTo == arrivalAirport}) else {return}
        
        for index in 0...destinationIndex {
            departureLegs.append(rawData.route[index])
        }
        
        destinationIndex += 1
        
        for index in destinationIndex..<rawData.route.count {
            returnLegs.append(rawData.route[index])
        }
        
    }
    
    
    
    
}
