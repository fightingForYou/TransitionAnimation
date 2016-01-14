//
//  ViewController.swift
//  专场动画
//
//  Created by lok on 16/1/12.
//  Copyright © 2016年 lok. All rights reserved.
//

import UIKit

class FirstViewController: UICollectionViewController, UINavigationControllerDelegate {

    
    var index: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC.isKindOfClass(SecondViewController.self) {
            return LokPushAnimation()
        } else {
            
            return nil
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
    }
    
}

