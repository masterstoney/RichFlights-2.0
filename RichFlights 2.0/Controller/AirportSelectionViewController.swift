//
//  AirportSelectionViewController.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/13/21.
//

import UIKit
import Combine

class AirportSelectionViewController: UIViewController {

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustViewForKeyboardHeight(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        airports = airportData.data
        
        airportSelectionView.departurePickerView.airportTextField.delegate = self
        airportSelectionView.destinationPickerView.airportTextField.delegate = self
        
        resultsDataSource = createDataSource()
        airportSelectionView.resultsTableView.dataSource = resultsDataSource
        airportSelectionView.resultsTableView.delegate = self
        
        airportSelectionView.departurePickerView.airportTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        airportSelectionView.destinationPickerView.airportTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        airportSelectionView.dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchDown)
        
        if let firstActiveTextField = firstActiveTextField {
           _ = firstActiveTextField == .departure ? airportSelectionView.departurePickerView.airportTextField.becomeFirstResponder() : airportSelectionView.destinationPickerView.airportTextField.becomeFirstResponder()
        }
        
        setupCombinePipelines()
        
        searchSelectionInteractionController = SearchSelectionInteractionController(viewController: self)
 
    }
    

    override func loadView() {
        self.view = airportSelectionView
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        airportSelectionDelegate?.selectedAirports(departure: departureAirport, destination: destinationAirport)
    }
    
    
    //MARK: Properties
    
    private let airportSelectionView = AirportSelectionView()
    
    @Published private var departureAirportName: String = ""
    @Published private var destinationAirportName: String = ""
    
    private var subscribers: [AnyCancellable] = []
    
    private var airports: [Airport] = []
    private let airportData = AirportsData.shared
    
    //Constraint warnings are given on initial load when animations are on. This flag enables animations after first load when data is now being passed to the tableView.
    private var firstLoadDone: Bool = false
    
    private var resultsDataSource: UITableViewDiffableDataSource<Int,Airport>!
    
    
    enum FirstActiveTextField {
        case departure
        case destination
    }
    
    var firstActiveTextField: FirstActiveTextField?
    
    var departureAirport: Airport? {
        didSet {
            airportSelectionView.departurePickerView.airportTextField.text = departureAirport?.displayText ?? ""
        }
    }
    var destinationAirport: Airport? {
        didSet {
            airportSelectionView.destinationPickerView.airportTextField.text = destinationAirport?.displayText ?? ""
        }
        
    }
    
    weak var airportSelectionDelegate: AirportSelectionDelegate?
    
    var searchSelectionInteractionController: SearchSelectionInteractionController?
    
    
    //MARK: Methods
    
    @objc private func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func adjustViewForKeyboardHeight(notification: Notification) {
        
        let userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let height = keyboardSize.height
        airportSelectionView.updateBottomConstraint(height: height)
        
    }
    
    @objc private func textFieldDidChange(textField: UITextField) {
        
        guard let text = textField.text else {print("empty string??"); return}
        
        if textField == airportSelectionView.departurePickerView.airportTextField {
            departureAirportName = text
        } else {
            destinationAirportName = text
        }
        
    }
    
    
    private func createDataSource() -> UITableViewDiffableDataSource<Int,Airport> {
        return UITableViewDiffableDataSource<Int,Airport>(tableView: airportSelectionView.resultsTableView) { (tableView, indexPath, airport) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! RFAirportResultTableViewCell
            let searchText = self.airportSelectionView.departurePickerView.isFirstResponder ? self.departureAirportName : self.destinationAirportName
            cell.populateCell(searchText: searchText, airport: airport)
            return cell
        }
    }
    
    private func updateSnapshot(airports: ([Airport],[Airport])) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Int,Airport>()
        snapshot.appendSections([0,1])
        snapshot.appendItems(airports.0, toSection: 0)
        snapshot.appendItems(airports.1, toSection: 1)
        resultsDataSource.apply(snapshot, animatingDifferences: firstLoadDone)
        
        firstLoadDone = true
        
    }
    
    /**Returns a tuple of airports with the code or in the city that matches the search input text*/
    private func searchAirports(text: String) -> ([Airport],[Airport]) {
        let citiesMatchingText = self.airports.filter { (airport) -> Bool in
            airport.cityName.contains(text)
        }
        let codesMatchingText = self.airports.filter { (airport) -> Bool in
            airport.airportCode.contains(text.uppercased())
        }
        //to remove duplicates
        return (Array(Set(citiesMatchingText)),Array(Set(codesMatchingText)))
    }
    
    
    private func setupCombinePipelines() {
        
        $departureAirportName
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .map {self.searchAirports(text: $0)}
            .receive(on: DispatchQueue.main)
            .sink {self.updateSnapshot(airports: $0)}
            .store(in: &subscribers)
        
        $destinationAirportName
            .receive(on: DispatchQueue.global(qos: .userInitiated))
            .map {self.searchAirports(text: $0)}
            .receive(on: DispatchQueue.main)
            .sink {self.updateSnapshot(airports: $0)}
            .store(in: &subscribers)
    }
    
}


    //MARK:- UITextField Delegate Methods
extension AirportSelectionViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == airportSelectionView.departurePickerView.airportTextField {
            airportSelectionView.departurePickerView.isSelected = true
        } else {
            airportSelectionView.destinationPickerView.isSelected = true
        }
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == airportSelectionView.departurePickerView.airportTextField {
            airportSelectionView.departurePickerView.isSelected = false
        } else {
            airportSelectionView.destinationPickerView.isSelected = false
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    
}



    //MARK:- UITableView Delegate Methods
extension AirportSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedAirport = self.resultsDataSource.itemIdentifier(for: indexPath) else {return}
        if airportSelectionView.departurePickerView.airportTextField.isFirstResponder {
            airportSelectionView.departurePickerView.airportTextField.resignFirstResponder()
            departureAirport = selectedAirport
            self.updateSnapshot(airports: ([],[]))
            airportSelectionView.destinationPickerView.airportTextField.becomeFirstResponder()
            //save the airport choice somewhere around here and check the other
        } else {
            airportSelectionView.destinationPickerView.airportTextField.resignFirstResponder()
            destinationAirport = selectedAirport
            if departureAirport == nil {
                self.updateSnapshot(airports: ([],[]))
                airportSelectionView.departurePickerView.airportTextField.becomeFirstResponder()
                return
            }
            self.dismiss(animated: true, completion: nil)
            //save the airport choice somewhere around here and check the other
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerReuseId") as! RFAirportResultHeaderViewCell
        view.headerLabel.text = section == 0 ? "City" : "Airport"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
