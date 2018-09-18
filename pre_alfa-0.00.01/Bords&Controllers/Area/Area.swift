//
//  ViewController.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 02.07.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit



class Area: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    private var second = -1
    
    
    static func storyboardInstance() -> Area? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? Area
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    var brain = BrainArea()
    
    var stopButton: UIButton!
    var countRoom: UILabel!
    
    
    var roomView: UIView!
    var newRoomView: UIView!
    
    var atackButton: UIButton!
    var atackView: UIView?
    
    var doorUp: UIView!
    var doorRight: UIView!
    var doorDown: UIView!
    var doorLeft: UIView!

    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case .down:  brain.step(dir: .Up, area: self)
                case .left:  brain.step(dir: .Right, area: self)
                case .up:    brain.step(dir: .Down, area: self)
                case .right: brain.step(dir: .Left, area: self)
            default: break
            }
        }
    }


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
   @objc func fight(_ sender: UIButton) {
        if !brain.thisRoom.enemys.isEmpty{
            if let nextViewController = FightAren.storyboardInstance() {
                nextViewController.brain.castPlayer = brain.castPlayer
                nextViewController.brain.room = brain.thisRoom
                nextViewController.brain.fightAren = nextViewController
                self.present(nextViewController, animated: true, completion: nil)
            }
           atackButton.removeFromSuperview()
        }
    }
    
    
    @objc func menu(_ sender: UIButton) {
        if let nextViewController = PlayMenu.storyboardInstance() {
            nextViewController.modalPresentationStyle = .custom
            nextViewController.scene = brain.castPlayer.map.map3D.scene
            nextViewController.player = brain.castPlayer.player
            self.present(nextViewController, animated: true, completion: nil)
        }
    }
    
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
    
    func createRoomView(){
        
        let widthRoom   = self.view.frame.width
        let heightRoom  = self.view.frame.height
        
        let widthDoor   = self.view.frame.width/10
        let heightDoor  = widthDoor
        
        newRoomView = UIView(frame: self.view.bounds)
        self.view.addSubview(newRoomView)
        
        let doorUpFrame = CGRect(x:  widthRoom / 2 - widthDoor / 2, y: heightDoor / 2, width: widthDoor, height: heightDoor)
        doorUp = UIView(frame: doorUpFrame)
        newRoomView.addSubview(doorUp)
        
        let doorDownFrame = CGRect(x: widthRoom / 2 - widthDoor / 2, y: heightRoom - heightDoor * 1.5, width: widthDoor, height: heightDoor)
        doorDown = UIView(frame: doorDownFrame)
        newRoomView.addSubview(doorDown)
        
        let doorRightFrame = CGRect(x:  widthRoom - widthDoor * 1.5, y: heightRoom / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doorRight = UIView(frame: doorRightFrame)
        newRoomView.addSubview(doorRight)
        
        let doorLeftFrame = CGRect(x: heightDoor / 2, y: heightRoom / 2 - heightDoor / 2, width: widthDoor, height: heightDoor)
        doorLeft = UIView(frame: doorLeftFrame)
        newRoomView.addSubview(doorLeft)
        
        let countRoomFrame = CGRect(x: widthRoom / 2 - widthDoor*1.5, y: heightDoor * 2, width: widthDoor*3, height: heightDoor)
        countRoom = UILabel(frame: countRoomFrame)
        countRoom.font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 0), size: 40)
        countRoom.text = "24"
        countRoom.textAlignment = .center
        newRoomView.addSubview(countRoom)
        
        stopButton = UIButton(frame: self.view.bounds)
        stopButton.addTarget(self, action: #selector(menu), for: .touchDownRepeat)
        newRoomView.addSubview(stopButton)
        
        if !brain.thisRoom.enemys.isEmpty{
            
            let atackViewFrame = CGRect(x:  self.view.frame.width/2 - widthDoor * 7 / 2 , y: -widthDoor * 7, width: widthDoor * 7, height: widthDoor * 7)
            atackView = UIView(frame: atackViewFrame)
            atackView!.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            atackView?.isHidden = true
            
            
            let atackFrame = CGRect(x:  atackView!.frame.width/2 - widthDoor / 2, y: atackView!.frame.height/2 - heightDoor / 2, width: widthDoor, height: heightDoor)
            atackButton = UIButton(frame: atackFrame)
            
            atackButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            atackButton.addTarget(self, action: #selector(fight), for: .touchUpInside)
            
            atackView!.addSubview(atackButton)
            newRoomView.addSubview(atackView!)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRoomView()
        roomView = newRoomView
        
        brain.startView(area: self)
        if atackView != nil{
            atackView!.isHidden = false
        }
        addSwipe()
        
        
    }
    
    @IBAction func unwindToArea (sender: UIStoryboardSegue){}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
}
