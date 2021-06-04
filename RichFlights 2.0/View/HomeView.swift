//
//  HomeView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/5/21.
//

import UIKit

class HomeView: UIView {

    //MARK: Initializers & Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientMask.frame = self.frame
        gradientMaskView.layer.addSublayer(gradientMask)
        
        let topInset = self.safeAreaInsets.top

        
    }
    
    //MARK: Properties
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "seaplane")
        return imageView
    }()
    
    var priceButton: RFButton = {
        let button = RFButton(title: "Book", systemImageName: "creditcard.fill")
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    
    var statusButton: RFButton = {
        let button = RFButton(title: "Track", systemImageName: "clock.arrow.2.circlepath")
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    
    private var profileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 28)
        button.setImage(UIImage(systemName: "figure.wave.circle.fill", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.isHidden = true
        return button
    }()
    
    private var gradientMask: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.lightGray.cgColor, UIColor.lightGray.cgColor]
        layer.locations = [0.0, 0.7, 1.0]
        return layer
    }()
    
    private var gradientMaskView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Methods
    
    private func setupView() {
        
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(gradientMaskView)
        addSubview(profileButton)
        addSubview(priceButton)
        addSubview(statusButton)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        gradientMaskView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gradientMaskView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        gradientMaskView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        gradientMaskView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        profileButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        priceButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        priceButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        priceButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8).isActive = true
        priceButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        statusButton.bottomAnchor.constraint(equalTo: priceButton.bottomAnchor).isActive = true
        statusButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8).isActive = true
        statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        statusButton.heightAnchor.constraint(equalTo: priceButton.heightAnchor).isActive = true
        
        
    }
    
    
    
}
