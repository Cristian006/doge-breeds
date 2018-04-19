//
//  Colors.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/19/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    static let a = CGFloat(0.6)
    static let colors = [
        UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: a),
        UIColor(red: 184/255.0, green: 243/255.0, blue: 249/255.0, alpha: a),
        UIColor(red: 161/255.0, green: 237/255.0, blue: 144/255.0, alpha: a),
        UIColor(red: 249/255.0, green: 159/255.0, blue: 188/255.0, alpha: a),
        UIColor(red: 234/255.0, green: 142/255.0, blue: 96/255.0, alpha: a),
        UIColor(red: 177/255.0, green: 197/255.0, blue: 249/255.0, alpha: a),
        UIColor(red: 201/255.0, green: 80/255.0, blue: 84/255.0, alpha: a),
    ]
    
    static func getRandomColor() -> UIColor {
        return colors[Int(arc4random_uniform(UInt32(colors.count)))]
    }
}
