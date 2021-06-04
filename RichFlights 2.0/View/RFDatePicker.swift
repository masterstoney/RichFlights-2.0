//
//  RFDatePicker.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/12/21.
//

import UIKit

class RFDatePicker: UIView {

    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init()
        label.text = title
        setupView()
    }
    
    //MARK: Properties
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private var pickerNormalHeightAnchor: NSLayoutConstraint!
    private var pickerZeroHeightAnchor: NSLayoutConstraint!
    
    //MARK: Methods
    
    private func setupView() {
        
        addSubview(label)
        addSubview(datePicker)
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: -16).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: 150).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        pickerNormalHeightAnchor = datePicker.heightAnchor.constraint(equalToConstant: 35)
        pickerZeroHeightAnchor = datePicker.heightAnchor.constraint(equalToConstant: 0)
        pickerNormalHeightAnchor.isActive = true
        
    }
    
    func viewHeight(zero: Bool) {
        
        if zero {
            pickerNormalHeightAnchor.isActive = false
            pickerZeroHeightAnchor.isActive = true
            datePicker.isHidden = true
        } else {
            pickerZeroHeightAnchor.isActive = false
            datePicker.isHidden = false
            pickerNormalHeightAnchor.isActive = true
            
        }
        
    }
    

}
