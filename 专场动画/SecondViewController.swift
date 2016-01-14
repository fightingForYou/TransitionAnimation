//
//  MyViewController.swift
//  专场动画
//
//  Created by lok on 16/1/12.
//  Copyright © 2016年 lok. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var myImage: UIImageView!
    
    var percentDrive: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "update:")
        edgeGesture.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(edgeGesture)
        

        // Do any additional setup after loading the view.
    }
    
    func update(gesture: UIScreenEdgePanGestureRecognizer) {
        
        var progress = gesture.translationInView(self.view).x / self.view.frame.width
        progress = min(1, max(0, progress))
        
        switch gesture.state {
        case .Began:
            self.percentDrive = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        case .Changed:
            self.percentDrive?.updateInteractiveTransition(progress)
        case .Ended, .Cancelled:
            if progress > 0.5 {
                self.percentDrive?.finishInteractiveTransition()
            } else {
                self.percentDrive?.cancelInteractiveTransition()
            }
            self.percentDrive = nil
        default:
            break
        }
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC.isKindOfClass(FirstViewController.self) {
            return LokPopAnimation()
        } else {
            return nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController.isKindOfClass(LokPopAnimation.self) {
        return self.percentDrive
        }
        return nil
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.delegate = nil;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
