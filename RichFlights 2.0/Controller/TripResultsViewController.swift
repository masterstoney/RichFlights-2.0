//
//  TripResultsViewController.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/19/21.
//

import UIKit

class TripResultsViewController: UIViewController {

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tripResultsView.collectionView.delegate = self
        tripResultsView.collectionView.dataSource = dataSource
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .done, target: self, action: #selector(presentFilters))
        
        if let trip = trip {
            
            self.navigationItem.title = "\(trip.source) - \(trip.destination)"
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
            self.navigationController?.navigationBar.prefersLargeTitles = true
            
            
            skypickerManager.search(trip: trip) { (skypickerData, error) in
                if error != nil {
                    print(error?.localizedDescription)
                }
                guard let data = skypickerData.data else {return}
                DispatchQueue.main.async {
                    self.dataSource.data = data.map { SkypickerViewModel(rawData: $0, returnTrip: self.returnTrip!) }
                    self.tripResultsView.collectionView.reloadData()
                    UIView.animate(withDuration: 0.25) {
                        self.tripResultsView.loadingAnimationView.isHidden = true
                        self.tripResultsView.collectionView.isHidden = false
                    }
                }
            }
        }
        
    }
    
    override func loadView() {
        self.view = tripResultsView
    }
    
    //MARK: Properties
    
    private let tripResultsView = TripResultsView()
    private let dataSource = TripResultDataSource()
    private let skypickerManager = SkypickerSearchManager()
    var trip: Trip?
    var returnTrip: Bool?
    
    //MARK: Methods
      
    
    @objc private func presentFilters() {
        
        
    }

}


    //MARK: UICollectionView Delegate Methods
extension TripResultsViewController: UICollectionViewDelegateFlowLayout {
    
}
