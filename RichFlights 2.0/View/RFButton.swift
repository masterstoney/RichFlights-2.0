//
//  RFButton.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/12/21.
//

import UIKit

class RFButton: UIButton {

    //MARK: Initializers
    
    override init(frame: CGRect) {
        self.title = String()
        self.systemImageName = String()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, systemImageName: String) {
        self.init()
        self.title = title
        self.systemImageName = systemImageName
        setupButton()
    }
    
    //MARK: Properties
    
    private var title: String
    private var systemImageName: String
    
    
    //MARK: Methods
    
    private func setupButton() {
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)
        let config = UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .headline))
        let image = UIImage(systemName: systemImageName, withConfiguration: config)?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        layer.cornerRadius = 10
        imageView?.tintColor = .white
        backgroundColor = .black
        
    }
    
    
    
    

}
