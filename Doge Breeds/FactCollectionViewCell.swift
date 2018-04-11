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
    
    func setFact(df: DogFact?) {
        print("SET ME")
        fact = df
        self.updateUI()
    }
    
    private func updateUI() {
        print("UPDATE")
        if let fact = fact {
            print(fact.fact)
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
        
        layer.cornerRadius = 3.0
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
}
