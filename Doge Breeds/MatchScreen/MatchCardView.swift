//
//  MatchCellView.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/22/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit
import CoreMotion

class MatchCardView: SwipeableCardViewCard {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var sexImage: UIImageView!
    
    @IBOutlet weak var imageBackgroundColorView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundContainerView: UIView!
    
    /// Core Motion Manager
    private let motionManager = CMMotionManager()
    
    /// Shadow View
    private weak var shadowView: UIView?
    
    /// Inner Margin
    private static let kInnerMargin: CGFloat = 20.0
    
    var pet: Pet? {
        didSet {
            configure(pet: pet)
        }
    }

    private func configure(pet: Pet?) {
        if let p = pet {
            titleLabel.text = p.name
            subtitleLabel.text = p.getSubLabel()
            imageView.backgroundColor = pet?.color ?? Colors.getRandomColor()
            imageView.image = p.getImg()
            locationLabel.text = p.getLocationLabel()
            sexImage.image = p.getGenderIcon()
            backgroundContainerView.layer.cornerRadius = 14.0
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureShadow()
    }
    
    // MARK: - Shadow
    
    private func configureShadow() {
        // Shadow View
        self.shadowView?.removeFromSuperview()
        let shadowView = UIView(frame: CGRect(x: MatchCardView.kInnerMargin,
                                              y: MatchCardView.kInnerMargin,
                                              width: bounds.width - (2 * MatchCardView.kInnerMargin),
                                              height: bounds.height - (2 * MatchCardView.kInnerMargin)))
        insertSubview(shadowView, at: 0)
        self.shadowView = shadowView
        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
    }
    
    private func applyShadow(width: CGFloat, height: CGFloat) {
        if let shadowView = shadowView {
            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 8.0
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
            shadowView.layer.shadowOpacity = 0.15
            shadowView.layer.shadowPath = shadowPath.cgPath
        }
    }
    
}
