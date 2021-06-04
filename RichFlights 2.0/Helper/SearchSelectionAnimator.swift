//
//  SearchSelectionAnimator.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/31/21.
//

import UIKit

class SearchSelectionPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    //MARK: Initializers
    
    //MARK: Properties

    private let hapticGenerator = UIImpactFeedbackGenerator()
    
    //MARK: Methods
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to)
        else {return}
        let containerView = transitionContext.containerView
        
        let fromView = fromVC.view as! TripSearchView
        
        guard let snapshotView = fromView.stackView.snapshotView(afterScreenUpdates: false) else {return}
        let originFrame = fromView.stackView.frame.origin
        
        let cardFrame = fromView.cardView.frame
        let cardView = UIView(frame: cardFrame)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10.0
        cardView.layer.cornerCurve = .continuous
        
        toVC.view.frame = containerView.frame
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(cardView)
        containerView.addSubview(snapshotView)
        toVC.view.isHidden = true
        
        
        
        snapshotView.frame.origin = originFrame
        
        let topInsets = containerView.safeAreaInsets.top
        //100 is derived from adding the top constraints and height of button before stackview in AirportSelectionView
        let displacement = originFrame.y - (100 + topInsets)
        
        let cardDestination = CGPoint(x: 0, y: topInsets + 30)
        let cardSize = CGSize(width: containerView.frame.width, height: containerView.frame.height)
        
        
        let duration = transitionDuration(using: transitionContext)
        
        hapticGenerator.prepare()
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0.0,
                                options: .calculationModeCubic) {
            
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 3/3) {
                snapshotView.transform3D = CATransform3DMakeTranslation(16, -displacement, 1)
                cardView.frame = CGRect(origin: cardDestination, size: cardSize)
            }
            
            
        } completion: { _ in
            
            self.hapticGenerator.impactOccurred(intensity: 0.6)
            toVC.view.isHidden = false
            snapshotView.removeFromSuperview()
            cardView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }

}




class SearchSelectionDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    //MARK: Initializers
    
    init(interactionController: SearchSelectionInteractionController?) {
        self.interactionController = interactionController
    }
    
    //MARK: Properties
    
    private let hapticGenerator = UIImpactFeedbackGenerator()
    let interactionController: SearchSelectionInteractionController?
    
    
    //MARK: Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to)
        else {return}
        let containerView = transitionContext.containerView
        
        let fromView = fromVC.view as! AirportSelectionView
        let toView = toVC.view as! TripSearchView
        
        guard let snapshotView = toView.stackView.snapshotView(afterScreenUpdates: true) else {return}
        
        let finalFramePosition = toView.stackView.frame.origin
        
        let originFrame = fromView.stackView.frame.origin
        
        let cardFrame = fromView.backgroundCardView.frame
        let cardView = UIView(frame: cardFrame)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10.0
        cardView.layer.cornerCurve = .continuous
        
        containerView.addSubview(cardView)
        containerView.addSubview(snapshotView)
        fromView.isHidden = true
        
        snapshotView.frame.origin = originFrame
        
        let heightDifference = fromView.frame.height - toView.frame.height
        
        let duration = transitionDuration(using: transitionContext)
        
        hapticGenerator.prepare()
        
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0.0,
                                options: .calculationModeCubic) {

            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 5/5) {

                snapshotView.frame = CGRect(origin: CGPoint(x: finalFramePosition.x, y: finalFramePosition.y + heightDifference), size: snapshotView.frame.size)
                cardView.frame = CGRect(origin: finalFramePosition, size: containerView.frame.size)

            }

        } completion: { _ in
            
            self.hapticGenerator.impactOccurred(intensity: 0.6)
            snapshotView.removeFromSuperview()
            cardView.removeFromSuperview()
            if transitionContext.transitionWasCancelled {
                fromView.isHidden = false
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

    }
    
}



class SearchSelectionInteractionController: UIPercentDrivenInteractiveTransition {
    
    //MARK: Initializers
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
        
    }
    
    //MARK: Properties
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    
    //MARK: Methods
    
    private func prepareGestureRecognizer(in view: UIView) {
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
        
    }
    
    
    @objc private func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.y / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
        
        case .began:
            interactionInProgress = true
            viewController.view.endEditing(true)
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
            
        default:
            break
        
        
        }
    }
    
    
    
    
    
    
}
