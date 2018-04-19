//
//  FactCollectionViewCell.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/10/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class FactCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var backgroundOverlay: UIView!
    @IBOutlet weak var factTitle: UILabel!
    @IBOutlet weak var factLabel: UILabel!
    
    var fact: DogFact? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        if let fact = fact {
            factTitle.text = fact.title
            factLabel.text = fact.fact
            backgroundOverlay.backgroundColor = fact.color
            featuredImageView.image = fact.featuredImage
        } else {
            factTitle.text = nil
            factLabel.text = nil
            backgroundOverlay.backgroundColor = nil
            featuredImageView.image = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
}
