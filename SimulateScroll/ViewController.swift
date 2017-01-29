//
//  ViewController.swift
//  SimulateScroll
//
//  Created by frndev on 29/1/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addPanGesture()
    
    }
    
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didScroll))
        self.scrollView.addGestureRecognizer(panGesture)
    }
    
    func didScroll(sender : UIPanGestureRecognizer) {
        if sender.state == .recognized {
            
            let translation = sender.translation(in: self.scrollView).y
            let y = self.scrollView.frame.origin.y
            let scrollViewSize = self.scrollView.frame.size.height
            let viewSize = self.view.frame.size.height
            var newY = y + translation
            
            // These conditions avoids scrollView to leave the screen
            
            if newY > 0 {
                newY = 0
            } else if newY + scrollViewSize <  viewSize {
                newY = -scrollViewSize + viewSize
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.scrollView.frame = CGRect(x: 0,
                                            y: newY,
                                            width: self.scrollView.frame.width,
                                            height: scrollViewSize)
             })
        }
    }
}
