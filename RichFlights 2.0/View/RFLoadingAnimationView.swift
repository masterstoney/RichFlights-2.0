//
//  RFLoadingAnimationView.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/5/21.
//

import UIKit

class RFLoadingAnimationView: UIView {

    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        animate()
    }
    
    //MARK: Properties
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "airplane")
        view.tintColor = .black
        return view
    }()
    
    private var radius: CGFloat = 25.0
    private var lineWidth: CGFloat = 2.0
    
    //MARK: Methods
    
    private func setupView() {
  
        backgroundColor = .secondarySystemBackground
        
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        
    }
    
    private func animate() {
        
        //MARK: Circle Layer & Path creation
        
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath()
        circlePath.move(to: CGPoint(x: 50, y: 50 - radius))
        circlePath.addArc(withCenter: CGPoint(x: 50, y: 50), radius: radius, startAngle: -.pi / 2, endAngle:  1.5 * .pi, clockwise: true)
        circlePath.lineWidth = lineWidth
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = nil
        circleLayer.strokeColor = UIColor.black.cgColor
        
        self.layer.addSublayer(circleLayer)
        self.bringSubviewToFront(imageView)
        
        //MARK: Image Animations
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = circlePath.cgPath
        positionAnimation.duration = 2.5
        positionAnimation.calculationMode = .paced
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2 * CGFloat.pi
        rotationAnimation.duration = 2.5
        
        let imageAnimationsGroup = CAAnimationGroup()
        imageAnimationsGroup.animations = [positionAnimation,rotationAnimation]
        imageAnimationsGroup.duration = 2.5
        imageAnimationsGroup.repeatCount = .infinity
        
        imageView.layer.add(imageAnimationsGroup, forKey: "animation")

        //MARK: Circle Animations
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        strokeEndAnimation.duration = 2.5
        strokeEndAnimation.beginTime = 0.0
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0.0
        strokeStartAnimation.toValue = 1.0
        strokeStartAnimation.duration = 1.5
        strokeStartAnimation.beginTime = 1.0
        
        var colors: [CGColor] = [UIColor.green.cgColor, UIColor.yellow.cgColor, UIColor.red.cgColor]
        colors.shuffle()
        colors.append(UIColor.black.cgColor) //black color should always be the last since its the actual color
        
        let colorAnimations = colors.enumerated().map { (index, color) -> CABasicAnimation in
            let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
            colorAnimation.fromValue = index == 0 ? circleLayer.strokeColor : colors[index - 1]
            colorAnimation.toValue = color
            colorAnimation.duration = 2.5
            colorAnimation.beginTime = Double(index) * 2.5
            return colorAnimation
        }
        
        let colorAnimationsGroup = CAAnimationGroup()
        colorAnimationsGroup.animations = colorAnimations
        colorAnimationsGroup.duration = 10.0
        
        let strokeAnimationsGroup = CAAnimationGroup()
        strokeAnimationsGroup.animations = [strokeEndAnimation,strokeStartAnimation]
        strokeAnimationsGroup.duration = 2.5
        strokeAnimationsGroup.repeatCount = .infinity
        
        let circleAnimationsGroup = CAAnimationGroup()
        circleAnimationsGroup.animations = [strokeAnimationsGroup,colorAnimationsGroup]
        circleAnimationsGroup.duration = 10.0
        circleAnimationsGroup.repeatCount = .infinity
        
        circleLayer.add(circleAnimationsGroup, forKey: "drawLineAnimation")
        
    }
    
    
    
    

}
