//
//  BreedTableViewCell.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/19/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class BreedTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
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
            //backgroundOverlay.backgroundColor = fact.color
            let data = try? Data(contentsOf: URL(string: (breed.img!))!)
            breedImage.image = UIImage(data: data!)!
        } else {
            breedLabel.text = nil
            originLabel.text = nil
            breedImage.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
