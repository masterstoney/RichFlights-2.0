//
//  AirportSelectionView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/13/21.
//

import UIKit

class AirportSelectionView: UIView {

    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    var backgroundCardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.0
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    var departurePickerView: RFAirportPickerView = RFAirportPickerView(icon: UIImage(systemName: "circle")!, placeholderText: "Where from?", bottomLines: true)
    
    var destinationPickerView: RFAirportPickerView = RFAirportPickerView(icon: UIImage(systemName: "airplane")!, placeholderText: "Where to?")
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 44
        tableView.backgroundColor = .white
        tableView.register(RFAirportResultTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(RFAirportResultHeaderViewCell.self, forHeaderFooterViewReuseIdentifier: "headerReuseId")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var dismissButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 28)
        let image = UIImage(systemName: "chevron.down.circle.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .systemGray
        return button
    }()
    
    var routeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter Route"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var tableViewBottomConstraint: NSLayoutConstraint!
    
    
    //MARK: Methods
    
    private func setupView() {
        
        backgroundColor = .clear
        
        addSubview(backgroundCardView)
        addSubview(dismissButton)
        addSubview(routeLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(departurePickerView)
        stackView.addArrangedSubview(destinationPickerView)
        addSubview(resultsTableView)
        
        backgroundCardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        backgroundCardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundCardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundCardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        dismissButton.topAnchor.constraint(equalTo: backgroundCardView.topAnchor, constant: 16).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor, constant: -16).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        routeLabel.centerYAnchor.constraint(equalTo: dismissButton.centerYAnchor).isActive = true
        routeLabel.centerXAnchor.constraint(equalTo: backgroundCardView.centerXAnchor).isActive = true
        routeLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        
        stackView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        resultsTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        resultsTableView.leadingAnchor.constraint(equalTo: backgroundCardView.leadingAnchor).isActive = true
        resultsTableView.trailingAnchor.constraint(equalTo: backgroundCardView.trailingAnchor).isActive = true
        tableViewBottomConstraint = resultsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        tableViewBottomConstraint.isActive = true
        
    }
    
    func updateBottomConstraint(height: CGFloat) {
        tableViewBottomConstraint.isActive = false
        tableViewBottomConstraint = resultsTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(height + 20))
        tableViewBottomConstraint.isActive = true
        layoutIfNeeded()
    }
  

}
