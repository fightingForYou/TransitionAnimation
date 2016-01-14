//
//  LokAnimation.swift
//  专场动画
//
//  Created by lok on 16/1/12.
//  Copyright © 2016年 lok. All rights reserved.
//

import UIKit

class LokPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
       
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! FirstViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! SecondViewController
        let cell = fromVC.collectionView?.cellForItemAtIndexPath((fromVC.collectionView?.indexPathsForSelectedItems()?.first)!) as! MyCell
        let containerView = transitionContext.containerView()
        let shotView = cell.image.snapshotViewAfterScreenUpdates(false)
        
        fromVC.index = fromVC.collectionView?.indexPathsForSelectedItems()?.first
        
        shotView.frame = (containerView?.convertRect(cell.image.frame, fromView: cell.image.superview))!
        toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
        
        cell.image.hidden = true
        toVC.myImage.hidden = true
        toVC.view.alpha = 0
        
        containerView?.addSubview(toVC.view)
        containerView?.addSubview(shotView)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            containerView?.layoutIfNeeded()
            toVC.view.alpha = 1
            shotView.frame = toVC.myImage.frame
            
            }) { (_) -> Void in
                cell.image.hidden = false
                toVC.myImage.hidden = false
                shotView.removeFromSuperview()
                transitionContext.completeTransition(true)
        }
        
    }
}
