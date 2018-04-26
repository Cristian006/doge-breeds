//
//  BreedDetailViewController+descriptionFormat.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/24/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit
import Foundation

extension BreedDetailViewController {
    internal func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
        
        attributedText.append(NSMutableAttributedString(string: "Facts\n\n", attributes: [
            kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 18)
            ]))
        
        
        if let origin = breed?.details?.origin {
            
            attributedText.append(NSMutableAttributedString(string: "Origin\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            
            attributedText.append(NSMutableAttributedString(string: origin, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        if let height = breed?.facts?.height {
            attributedText.append(NSMutableAttributedString(string: "\nHeight\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: height, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let life = breed?.facts?.life {
            attributedText.append(NSMutableAttributedString(string: "\nLife Span\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: life, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let size = breed?.facts?.size {
            attributedText.append(NSMutableAttributedString(string: "\nSize\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: size, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let weight = breed?.facts?.weight {
            attributedText.append(NSMutableAttributedString(string: "\nWeight\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: weight, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        attributedText.append(NSMutableAttributedString(string: "\n\nDescription\n\n", attributes: [
            kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 18)
            ]))

        if let aka = breed?.details?.aka {
            attributedText.append(NSMutableAttributedString(string: "Also Known As\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: aka, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let history = breed?.details?.history {
            attributedText.append(NSMutableAttributedString(string: "\nHistory\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: history, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let temper = breed?.details?.role {
            attributedText.append(NSMutableAttributedString(string: "\nTemperament\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: temper, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        if let role = breed?.details?.role {
            attributedText.append(NSMutableAttributedString(string: "\nToday's Role\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: role, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        if let exercise = breed?.details?.special?.exersise {
            attributedText.append(NSMutableAttributedString(string: "\nExercise\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: exercise, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let grooming = breed?.details?.special?.grooming {
            attributedText.append(NSMutableAttributedString(string: "\nGrooming\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: grooming, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        return attributedText
    }
}
