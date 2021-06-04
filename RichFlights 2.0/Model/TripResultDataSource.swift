//
//  TripResultDataSource.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/13/21.
//

import UIKit

class TripResultDataSource: NSObject, UICollectionViewDataSource {
    
    //MARK: Properties
    
    var data: [SkypickerViewModel] = []
    
    //MARK: Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! RFTripResultCollectionViewCell
        cell.populateCell(trip: data[indexPath.item])
        return cell
    }
    
    
    
}
