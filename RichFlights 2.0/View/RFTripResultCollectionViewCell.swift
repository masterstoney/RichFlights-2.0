//
//  RFTripResultCollectionViewCell.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/19/21.
//

import UIKit

class RFTripResultCollectionViewCell: UICollectionViewCell {
    
    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    private var departureArrivalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Departure - Arrival"
        label.font = .preferredFont(forTextStyle: .headline)
   //     label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return label
    }()
    
    private var timesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18:30 - 21:35"
        label.font = .preferredFont(forTextStyle: .subheadline)
   //     label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return label
    }()
    
    private var durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3h 05min"
        label.font = .preferredFont(forTextStyle: .subheadline)
   //     label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return label
    }()
    
    private var numberOfStopsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
   //     label.text = "Nonstop"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return label
    }()
    
    private var priceAndTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var priceAndTypeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private var operatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    private var verticalComponentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
        return stackView
    }()
    
    //MARK: Methods
    
    private func setupView() {
        
        backgroundColor = .white
        layer.cornerRadius = 10.0
        
        verticalComponentsStackView.addArrangedSubview(departureArrivalLabel)
        verticalComponentsStackView.addArrangedSubview(timesLabel)
        verticalComponentsStackView.addArrangedSubview(durationLabel)
        verticalComponentsStackView.addArrangedSubview(numberOfStopsLabel)
        verticalComponentsStackView.addArrangedSubview(operatingStackView)
        
        priceAndTypeStackView.addArrangedSubview(priceAndTypeLabel)
        
        addSubview(verticalComponentsStackView)
        addSubview(priceAndTypeStackView)
        
        
        verticalComponentsStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalComponentsStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        verticalComponentsStackView.trailingAnchor.constraint(equalTo: priceAndTypeStackView.leadingAnchor).isActive = true
        verticalComponentsStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        priceAndTypeStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        priceAndTypeStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        priceAndTypeStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        priceAndTypeStackView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    
    func populateCell(trip: SkypickerViewModel) {
        
        let departureAndDestinationString = "\(trip.rawData.cityFrom) - \(trip.rawData.cityTo)"
        let departureAndArrivalTime = "\(Date.localizedDateString(timestamp: trip.rawData.local_departure, utcProper: false)) - \(Date.localizedDateString(timestamp: trip.rawData.local_arrival, utcProper: false))"
        let tripDuration = Date.timeAsString(duration: trip.rawData.duration.departure)
        
        let departureLegStops = trip.departureLegs.count
        let numberOfStops = departureLegStops > 1 ? "\(departureLegStops - 1) Stop\(departureLegStops - 1 > 1 ? "s" : "")" : "Nonstop"
        
        departureArrivalLabel.text = departureAndDestinationString
        durationLabel.text = tripDuration
        numberOfStopsLabel.text = numberOfStops
        
        
        operatingStackView.removeFullyAllArrangedSubviews()
        trip.rawData.airlines.forEach { airline in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: airline)
            imageView.contentMode = .scaleAspectFill
            imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            operatingStackView.addArrangedSubview(imageView)
        }
        
        
        
        let timesAttributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: departureAndArrivalTime, attributes: [.foregroundColor : UIColor.black, .font : UIFont.preferredFont(forTextStyle: .body)]))
        let dayDifference = Date.dayDifference(trip.rawData.local_departure, with: trip.rawData.local_arrival)
        if dayDifference != 0 {
            timesAttributedText.append(NSAttributedString(string: "+\(dayDifference)", attributes: [.foregroundColor : UIColor.black, .font : UIFont.preferredFont(forTextStyle: .caption1), .baselineOffset : 10]))
        }
        
        timesLabel.attributedText = timesAttributedText
        
        let priceAttributedText = NSMutableAttributedString(string: "$\(trip.rawData.price)", attributes: [.foregroundColor : UIColor.black, .font : UIFont.boldSystemFont(ofSize: 21)])
        priceAttributedText.append(NSAttributedString(string: trip.returnTrip ? "\nReturn" : "\nOne-way", attributes: [.foregroundColor : UIColor.black, .font : UIFont.preferredFont(forTextStyle: .subheadline)]))
        priceAndTypeLabel.attributedText = priceAttributedText
        
    }
    
    
}

