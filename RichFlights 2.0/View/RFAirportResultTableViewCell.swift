//
//  RFAirportResultTableViewCell.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/13/21.
//

import UIKit

class RFAirportResultTableViewCell: UITableViewCell {

    //MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Properties
    
    private var airportNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Methods
    
    private func setupView() {
        
        backgroundColor = .white
        
        addSubview(airportNameLabel)
        airportNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        airportNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        airportNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        airportNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
       
    }
    
    func populateCell(searchText: String, airport: Airport) {
        
        
        
//        guard let subrange = displayText.lowercased().range(of: searchText) else {print("bye"); return}
//        let attributedText = NSMutableAttributedString(string: displayText, attributes: [.foregroundColor : UIColor.black, .font : UIFont.preferredFont(forTextStyle: .body)])
//        attributedText.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: NSRange(subrange, in: displayText))
//        airportNameLabel.attributedText = attributedText
        airportNameLabel.text = airport.displayText
    }
    

}
