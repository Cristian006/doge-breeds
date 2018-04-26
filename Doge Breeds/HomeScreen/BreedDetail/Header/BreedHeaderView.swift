//
//  BreedHeaderView.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/23/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

protocol BreedHeaderViewDelegate {
    func onBackButtonPressed(_ sender: Any)
    func onBookmarkButtonPressed(_ sender: Any)
}

class BreedHeaderView: BaseCell {

    var delegate: BreedHeaderViewDelegate?
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var book: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBAction func backButton(_ sender: Any) {
        delegate?.onBackButtonPressed(sender)
    }

    @IBAction func bookmarkButton(_ sender: Any) {
        delegate?.onBookmarkButtonPressed(sender)
    }

    var breed: DogBreed? {
        didSet {
            if let data = try? Data(contentsOf: URL(string: (breed?.img)!)!) {
                backgroundImage.image = UIImage(data: data)
            }
            nameLabel.text = breed?.name
            subLabel.text = breed?.details?.group
        }
    }
    
    override func setupViews() {
        super.setupViews()
        book.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        back.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        back.imageView?.contentMode = .scaleAspectFit
    }
}

/*
 addSubview(imageView)
 
 imageView.translatesAutoresizingMaskIntoConstraints = false
 imageView.backgroundColor = UIColor.yellow
 imageView.clipsToBounds = true
 
 addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
 addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
 
 addSubview(breedName)
 
 addSubview(breedType)
 
 addSubview(breedBookmarked)
 
 addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v1]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": breedName]))
 
 addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v1]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": breedType]))
 
 addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v1(40)]-0-[v2(30)]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v1": breedName, "v2": breedType]))
 
 
 addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v1]-8-|", options: .alignAllRight, metrics: nil, views: ["v1": breedBookmarked]))
 
 addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v1]", options: .alignAllRight, metrics: nil, views: ["v1": breedBookmarked]))
*/
