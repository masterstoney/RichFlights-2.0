//
//  ViewController.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 4/27/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        homeView.statusButton.addTarget(self, action: #selector(presentTrackVC), for: .touchUpInside)
        homeView.priceButton.addTarget(self, action: #selector(presentBookingVC), for: .touchUpInside)
        
        let _ = AirportsData.shared
        
    }
    
    
    override func loadView() {
        self.view = homeView
    }
    
    //MARK: Properties

    private let homeView = HomeView()
    
    
    //MARK: Methods
    
    @objc func presentTrackVC() {
        
        let trackingVC = TrackViewController()
        let presentedController = UINavigationController(rootViewController: trackingVC)
        presentedController.navigationBar.isHidden = true
        self.present(presentedController, animated: true, completion: nil)
        
    }
    
    @objc func presentBookingVC() {
        
        let presentedController = TripSearchViewController()
        self.present(presentedController, animated: true, completion: nil)
        
    }

}

