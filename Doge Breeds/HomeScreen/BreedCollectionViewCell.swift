//
//  BreedTableViewCell.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/19/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class BreedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundOverlay: UIView!
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var breed: DogBreed? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        if let breed = breed {
            breedLabel.text = breed.name
            originLabel.text = breed.details?.origin
            infoLabel.text = breed.details?.history
            backgroundOverlay.backgroundColor = Colors.getRandomColor()
            let data = try? Data(contentsOf: URL(string: (breed.img!))!)
            breedImage.image = UIImage(data: data!)!
        } else {
            breedLabel.text = nil
            originLabel.text = nil
            infoLabel.text = nil
            breedImage.image = nil
            backgroundOverlay.backgroundColor = nil
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
