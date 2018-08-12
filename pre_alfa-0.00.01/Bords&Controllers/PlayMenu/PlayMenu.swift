//
//  Menu.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 24.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class PlayMenu: UIViewController {
    
    static func storyboardInstance() -> PlayMenu? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PlayMenu
    }
    var a = 0
    
    func addSwipe() {
        let direction = UISwipeGestureRecognizerDirection.down
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        gesture.direction = direction
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .down {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor! = UIColor.white.withAlphaComponent(0.6)
        addSwipe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}