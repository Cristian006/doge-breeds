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
    static let fadedColors = [
        UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: a),
        UIColor(red: 184/255.0, green: 243/255.0, blue: 249/255.0, alpha: a),
        UIColor(red: 161/255.0, green: 237/255.0, blue: 144/255.0, alpha: a),
        UIColor(red: 249/255.0, green: 159/255.0, blue: 188/255.0, alpha: a),
        UIColor(red: 234/255.0, green: 142/255.0, blue: 96/255.0, alpha: a),
        UIColor(red: 177/255.0, green: 197/255.0, blue: 249/255.0, alpha: a),
        UIColor(red: 201/255.0, green: 80/255.0, blue: 84/255.0, alpha: a),
    ]
    
    static let colors = [
        UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0),
        UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0),
        UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0),
        UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0),
        UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0),
        UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0),
    ]
    
    static func getRandomColor(alpha: Double = 1.0) -> UIColor {
        return colors[Int(arc4random_uniform(UInt32(colors.count)))].withAlphaComponent(CGFloat(alpha))
    }
    
    static func getRandomColor() -> UIColor {
        return fadedColors[Int(arc4random_uniform(UInt32(fadedColors.count)))]
    }
}
