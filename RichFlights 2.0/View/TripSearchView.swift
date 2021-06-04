//
//  TripSearchView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/12/21.
//

import UIKit

class TripSearchView: UIView {

    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        roundTripSegmentedControl.addTarget(self, action: #selector(showReturnDate), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties

    var roundTripSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Round Trip", "One Way"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    var departurePickerView: RFAirportPickerView = {
        let pickerView = RFAirportPickerView(icon: UIImage(systemName: "circle")!, placeholderText: "Where from?", bottomLines: true)
        pickerView.airportTextField.isUserInteractionEnabled = false
        return pickerView
    }()
    
    var destinationPickerView: RFAirportPickerView = {
        let pickerView = RFAirportPickerView(icon: UIImage(systemName: "airplane")!, placeholderText: "Where to?")
        pickerView.airportTextField.isUserInteractionEnabled = false
        return pickerView
    }()
    
    var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.cornerCurve = .continuous
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.803510274)
        view.layer.shadowRadius = 15.0
        view.layer.shadowOpacity = 0.8
        return view
    }()
    
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    var departureDatePicker: RFDatePicker = {
        let datePicker = RFDatePicker(title: "Departure Date")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    var returnDatePicker: RFDatePicker = {
        let datePicker = RFDatePicker(title: "Return Date")
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    var dragToExitBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 2.5
        view.layer.cornerCurve = .circular
        return view
    }()
    
    var searchButton: RFButton = RFButton(title: "Search", systemImageName: "magnifyingglass")
    
    private var normalReturnHeightConstraint: NSLayoutConstraint!
    private var zeroReturnHeightConstraint: NSLayoutConstraint!
    
    //MARK: Methods
    
    private func setupView() {
        
        backgroundColor = .clear
        
        addSubview(cardView)
        addSubview(dragToExitBar)
        addSubview(roundTripSegmentedControl)
        addSubview(stackView)
        stackView.addArrangedSubview(departurePickerView)
        stackView.addArrangedSubview(destinationPickerView)
        addSubview(departureDatePicker)
        addSubview(returnDatePicker)
        addSubview(searchButton)
        
        
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        dragToExitBar.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -10).isActive = true
        dragToExitBar.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        dragToExitBar.widthAnchor.constraint(equalToConstant: 80).isActive = true
        dragToExitBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        roundTripSegmentedControl.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16).isActive = true
        roundTripSegmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        roundTripSegmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        roundTripSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        stackView.topAnchor.constraint(equalTo: roundTripSegmentedControl.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        departureDatePicker.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        departureDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        departureDatePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        returnDatePicker.topAnchor.constraint(equalTo: departureDatePicker.bottomAnchor, constant: 10).isActive = true
        returnDatePicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        returnDatePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: returnDatePicker.bottomAnchor, constant: 20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 155).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
    }
    
    @objc private func showReturnDate() {
        
        
        
        if roundTripSegmentedControl.selectedSegmentIndex == 0 {
            returnDatePicker.viewHeight(zero: false)
        } else {
            returnDatePicker.viewHeight(zero: true)
        }
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
        
        
        
    }
    

}
