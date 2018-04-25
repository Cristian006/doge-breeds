//
//  GradientImageView.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/24/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView
{
    let myGradientLayer: CAGradientLayer
    
    override var image: UIImage? {
        didSet {
            self.setup()
        }
    }
    
    override init(frame: CGRect)
    {
        myGradientLayer = CAGradientLayer()
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        myGradientLayer = CAGradientLayer()
        super.init(coder: aDecoder)
    }
    
    func setup()
    {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor]
        
        let aspectRatio = (self.image?.size.width)! / (self.image?.size.height)!
        let requiredHeight = self.bounds.size.width / aspectRatio
        
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: 0, y: (self.bounds.minY - (requiredHeight - self.bounds.maxY)), width: self.bounds.size.width, height: requiredHeight)
        
        self.layer.mask = maskLayer
        self.layer.addSublayer(gradient)
    }
    
    override func layoutSubviews()
    {
        myGradientLayer.frame = self.layer.bounds
    }
}
