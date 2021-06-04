//
//  TrackedFlightViewController.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 6/2/21.
//

import UIKit
import SwiftUI

class TrackedFlightViewController: UIViewController {

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let iataCode = iataFlightCode else {return}
        setupView()
        self.navigationItem.title = iataFlightCode
        aviationStackManager.fetch(flightDetails: TrackedFlight(flight_iata: iataCode)) { [weak self] (data, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            
            
            
            guard let self = self else {return}
            guard let data = data else {return}
            guard let trackedFlight = data.data.first else {return}
            self.hostingController = UIHostingController(rootView: TrackResultDetailView(trackedFlight: trackedFlight))
            DispatchQueue.main.async {
                self.hostingController?.view.translatesAutoresizingMaskIntoConstraints = false
                self.addChild(self.hostingController!)
                self.view.addSubview(self.hostingController!.view)
                self.hostingController?.didMove(toParent: self)
                
                self.hostingController?.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
                self.hostingController?.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                self.hostingController?.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                self.hostingController?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    

    //MARK: Properties
    
    var iataFlightCode: String?
    
    private var loadingAnimationView: RFLoadingAnimationView = {
        let view = RFLoadingAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var hostingController: UIHostingController<TrackResultDetailView>?
    private var aviationStackManager = AviationStackManager()
    
    //MARK: Methods
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(loadingAnimationView)
        loadingAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingAnimationView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadingAnimationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    

}
