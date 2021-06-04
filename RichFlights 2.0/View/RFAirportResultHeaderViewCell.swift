//
//  RFAirportResultHeaderViewCell.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/13/21.
//

import UIKit

class RFAirportResultHeaderViewCell: UITableViewHeaderFooterView {

    //MARK: Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header"
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .callout)
        label.backgroundColor = .white
        return label
    }()
    
    //MARK: Methods
    
    private func setupView() {
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        headerLabel.widthAnchor.constraint(equalToConstant: 155).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    

}

