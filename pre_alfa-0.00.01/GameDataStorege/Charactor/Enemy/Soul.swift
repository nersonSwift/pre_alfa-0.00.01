//
//  Soul.swift
//  pre_alfa-0.00.01
//
//  Created by Александр Сенин on 03.08.2018.
//  Copyright © 2018 Александр Сенин. All rights reserved.
//

import UIKit

class Soul: Enemy {
    override init() {
        super.init()
        name = "Soul"
        taunt = false
        fightStats.maxFightHP = 30
        fightStats.attackDmg = 10
    }
    override func dropItem() -> Item? {
        switch arc4random_uniform(100) {
        case 0...49:
            let key = Key()
            key.quantity = 1
            return key
        case 50...99: return nil
            
        default: return nil
        }
    }
}
