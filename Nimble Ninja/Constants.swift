//
//  Constants.swift
//  Nimble Ninja
//
//  Created by Gautham Kumar on 13/06/16.
//  Copyright © 2016 Gautham Kumar. All rights reserved.
//

import Foundation
import UIKit

let kGKMovingGround: CGFloat = 20
var kDefaultXtoMovePerSecond: CGFloat = 400
let COLOR_ONE: UIColor = UIColor(red: 88/255, green: 148/255, blue: 87/255, alpha: 1)
let COLOR_TWO: UIColor = UIColor(red: 120/255, green: 195/255, blue: 118/255, alpha: 1)
let NUMBER_OF_SEGMENTS = 20
let CLOUD_WIDTH: CGFloat = 125
let CLOUD_HEIGHT: CGFloat = 55
let WALL_WIDTH: CGFloat = 30
let WALL_HEIGHT: CGFloat = 50

//Categories for collision

let wallCategory: UInt32 = 0x1 << 0
let heroCategory: UInt32 = 0x1 << 1


