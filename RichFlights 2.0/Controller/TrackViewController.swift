//
//  TrackViewController.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/11/21.
//

import UIKit

class TrackViewController: UIViewController {

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trackView.searchButton.addTarget(self, action: #selector(searchForFlight), for: .touchUpInside)
    }
    
    override func loadView() {
        self.view = trackView
    }
    
    //MARK: Properties
    
    let trackView = TrackView()
    
    //MARK: Methods
    
    @objc func searchForFlight() {
        
        let flightCode = trackView.entryTextField.text
        trackView.entryTextField.resignFirstResponder()
        let presentedController = TrackedFlightViewController()
        presentedController.iataFlightCode = flightCode
        self.navigationController?.pushViewController(presentedController, animated: true)
        
    }
    
    
    

}
