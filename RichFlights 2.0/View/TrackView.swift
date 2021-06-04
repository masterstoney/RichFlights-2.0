//
//  TrackView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/11/21.
//

import UIKit

class TrackView: UIView {

    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "paperplane")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = NSMutableAttributedString(attributedString: NSAttributedString(string: "Track Flight\n", attributes: [.font : UIFont.preferredFont(forTextStyle: .headline).withSize(23), .foregroundColor : UIColor.black]))
        text.append(NSAttributedString(string: "Enter the flight number in IATA format\n", attributes: [.font : UIFont.preferredFont(forTextStyle: .subheadline).withSize(16), .foregroundColor : UIColor.black]))
        text.append(NSAttributedString(string: "e.g AA001", attributes: [.font : UIFont.preferredFont(forTextStyle: .subheadline).withSize(16), .foregroundColor : UIColor.secondaryLabel]))
        label.attributedText = text
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    var entryTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "AA001"
        textfield.padding(side: .both, size: 10)
        textfield.backgroundColor = .secondarySystemBackground
        textfield.layer.cornerRadius = 10
        textfield.clearButtonMode = .whileEditing
        textfield.autocapitalizationType = .allCharacters
        textfield.autocorrectionType = .no
        textfield.textContentType = UITextContentType(rawValue: "")
        return textfield
    }()
    
    var searchButton: RFButton = RFButton(title: "Search", systemImageName: "magnifyingglass")
    
    //MARK: Methods
    
    private func setupView() {
        
        backgroundColor = .white
        
        addSubview(iconImageView)
        addSubview(instructionLabel)
        addSubview(entryTextField)
        addSubview(searchButton)
        
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        instructionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
     //   instructionLabel.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        entryTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10).isActive = true
        entryTextField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        entryTextField.widthAnchor.constraint(equalToConstant: 230).isActive = true
        entryTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        
        searchButton.topAnchor.constraint(equalTo: entryTextField.bottomAnchor, constant: 10).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 155).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
    }


}
