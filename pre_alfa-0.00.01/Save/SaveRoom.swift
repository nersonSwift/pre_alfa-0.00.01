//
//  SavaRooms.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 23.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit
import RealmSwift

class SaveRoom: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var firstVisitingTriger = true
    @objc dynamic var close = false
    
    @objc dynamic var x = 0
    @objc dynamic var y = 0
    
    @objc dynamic var up    = ""
    @objc dynamic var right = ""
    @objc dynamic var down  = ""
    @objc dynamic var left  = ""
    
    @objc dynamic var enemy0 = ""
    @objc dynamic var enemy1 = ""
    @objc dynamic var enemy2 = ""
    
    
    
}
