//
//  TripSearchViewController.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/12/21.
//

import UIKit

class TripSearchViewController: UIViewController {

    //MARK: Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        departurePickerGestureRecognizer.numberOfTapsRequired = 1
        departurePickerGestureRecognizer.addTarget(self, action: #selector(presentAirportSelection(sender:)))
        
        destinationPickerGestureRecognizer.numberOfTapsRequired = 1
        destinationPickerGestureRecognizer.addTarget(self, action: #selector(presentAirportSelection(sender:)))
        
        tripSearchView.departurePickerView.addGestureRecognizer(departurePickerGestureRecognizer)
        tripSearchView.destinationPickerView.addGestureRecognizer(destinationPickerGestureRecognizer)
        
        tripSearchView.departureDatePicker.datePicker.addTarget(self, action: #selector(departureDateChanged), for: .valueChanged)
        
        tripSearchView.searchButton.addTarget(self, action: #selector(searchTrips), for: .touchUpInside)
        
    }
    
    override func loadView() {
        self.view = tripSearchView
    }
    
    //MARK: Properties
    
    private let tripSearchView = TripSearchView()
    
    private var departurePickerGestureRecognizer = UITapGestureRecognizer()
    private var destinationPickerGestureRecognizer = UITapGestureRecognizer()
    
    
    private var departureAirport: Airport? {
        didSet {
            tripSearchView.departurePickerView.airportTextField.text = departureAirport?.displayText ?? ""
        }
    }
    
    private var destinationAirport: Airport? {
        didSet {
            tripSearchView.destinationPickerView.airportTextField.text = destinationAirport?.displayText ?? ""
        }
    }
    
    
    
    //MARK: Methods
    
    @objc private func presentAirportSelection(sender: UITapGestureRecognizer) {
    
        let presentedController = AirportSelectionViewController()
        presentedController.airportSelectionDelegate = self
        presentedController.departureAirport = departureAirport
        presentedController.destinationAirport = destinationAirport
        
        if sender == departurePickerGestureRecognizer {
            //activate the departure textField
            presentedController.firstActiveTextField = .departure
        } else {
            presentedController.firstActiveTextField = .destination
        }
    
        presentedController.transitioningDelegate = self
        self.present(presentedController, animated: true, completion: nil)
        
    }
    
    
    
    @objc private func searchTrips() {
        
        guard let departureCode = departureAirport?.airportCode else {return}
        guard let destinationCode = destinationAirport?.airportCode else {return}
        let departureDate = tripSearchView.departureDatePicker.datePicker.date.skypickerDate
        let returnDate = tripSearchView.returnDatePicker.datePicker.date.skypickerDate
        let returnTrip = tripSearchView.roundTripSegmentedControl.selectedSegmentIndex == 0
        
        let trip = Trip(source: departureCode, destination: destinationCode, passengers: 1, departureDate: departureDate, returnDate: returnDate, returnTrip: returnTrip)
        
        let tripResultsVC = TripResultsViewController()
        tripResultsVC.trip = trip
        tripResultsVC.returnTrip = returnTrip
        let presentedController = UINavigationController(rootViewController: tripResultsVC)
        self.present(presentedController, animated: true, completion: nil)
        
    }
    
    
    @objc private func departureDateChanged() {
        
        tripSearchView.returnDatePicker.datePicker.minimumDate = tripSearchView.departureDatePicker.datePicker.date
    }

}


    //MARK: Airport Selection Delegate Method
extension TripSearchViewController: AirportSelectionDelegate {
    
    func selectedAirports(departure: Airport?, destination: Airport?) {
        
        self.departureAirport = departure
        self.destinationAirport = destination
    }
    
}


    //MARK: UIViewControllerTransitioningDelegate Methods
extension TripSearchViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SearchSelectionPresentationAnimator()
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let airportsVC = dismissed as? AirportSelectionViewController else {
            return nil
        }
        return SearchSelectionDismissalAnimator(interactionController: airportsVC.searchSelectionInteractionController)
    }
    
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? SearchSelectionDismissalAnimator,
              let interactionController = animator.interactionController,
              interactionController.interactionInProgress else {
            return nil
        }
        return interactionController
    }
    
}
