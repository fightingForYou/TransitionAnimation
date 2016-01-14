//
//  LokPopAnimation.swift
//  专场动画
//
//  Created by lok on 16/1/14.
//  Copyright © 2016年 lok. All rights reserved.
//

import UIKit

class LokPopAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! SecondViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! FirstViewController
        let containView = transitionContext.containerView()
        
        let shotView = fromVC.myImage.snapshotViewAfterScreenUpdates(false)
        shotView.frame  = (containView?.convertRect(fromVC.myImage.frame, fromView: fromVC.view))!
        fromVC.myImage.hidden = true
        
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        toVC.view.alpha = 0
        
        let cell = toVC.collectionView?.cellForItemAtIndexPath(toVC.index!) as! MyCell
        let toFrame = containView?.convertRect(cell.image.frame, fromView: cell.image.superview)
        containView?.addSubview(toVC.view)
        containView?.addSubview(shotView)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            
            containView?.layoutIfNeeded()
            shotView.frame = toFrame!
            toVC.view.alpha = 1
            
            }) { (_) -> Void in
                fromVC.myImage.hidden = false
                shotView.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
    }
}
