//
//  RFAirportPickerView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/12/21.
//

import UIKit

class RFAirportPickerView: UIView {

    //MARK: Initializers & Lifecycle
    
    override init(frame: CGRect) {
        self.isSelected = Bool()
        self.bottomLines = Bool()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(icon: UIImage, placeholderText: String, isSelected: Bool = false, bottomLines: Bool = false) {
        self.init()
        self.isSelected = isSelected
        self.bottomLines = bottomLines
        iconImageView.image = icon
        let attributedText = NSAttributedString(string: placeholderText, attributes: [.font : UIFont.preferredFont(forTextStyle: .headline)])
        airportTextField.attributedPlaceholder = attributedText
        setupView()
        setSelected(on: isSelected)
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        let startPoint = CGPoint(x: rect.minX + 27, y: bottomLines ? 35 : 0)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y + 4))
        path.move(to: CGPoint(x: startPoint.x, y: startPoint.y + 7.5))
        path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y + 11.5))
        path.lineWidth = 2.0
        path.lineCapStyle = .round
        
        let color = UIColor.systemGray2
        
        color.setStroke()
        path.stroke()
        
        
        
    }
    
    //MARK: Properties
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray2
        return imageView
    }()
    
    var airportTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .preferredFont(forTextStyle: .headline)
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.textContentType = UITextContentType(rawValue: "")
        return textField
    }()
    
    private var bottomLines: Bool
    
    var isSelected: Bool {
        didSet {
            setSelected(on: isSelected)
        }
    }
    
    //MARK: Methods
    
    private func setupView() {
        
        
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(iconImageView)
        addSubview(airportTextField)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        airportTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        airportTextField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        airportTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        airportTextField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        //these anchors have to be set at 999 priority or else the stackview will complain endlessly. Weirdly, this isn't the axis that its working with
        let iconLeadingAnchor = iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        iconLeadingAnchor.isActive = true
        iconLeadingAnchor.priority = UILayoutPriority(999)
        
        
    }
    
    private func setSelected(on: Bool) {
        
        
        UIView.animate(withDuration: 0.25) {
            self.backgroundColor = on ? .systemGray6 : .white
        }
        
    }
    
    

}
