//
//  MatchHeader.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/25/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol MatchHeaderViewDelegate {
    func onBackButtonPressed(_ sender: Any)
    func onBookmarkButtonPressed(_ sender: Any)
}

class MatchHeader: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    var delegate: MatchHeaderViewDelegate?
    
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
    
    var pet: Pet? {
        didSet {
            if let p = pet {
                backgroundImage.backgroundColor = p.color
                backgroundImage.image = p.getImg()
                nameLabel.text = p.name
                subLabel.text = p.getSubLabel()
            } else {
                backgroundImage.image = nil
                nameLabel.text = "Doge"
                subLabel.text = "good doge"
            }
        }
    }

}

extension MatchHeader {
    
    /// Initializes the view from a xib
    /// file and configure initial constrains.
    func xibSetup() {
        backgroundColor = .clear
        let lv = loadViewFromNib()
        addSubview(lv)
        layoutIfNeeded()
        lv.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero)
        //setNeedsLayout()
    }
    
    /// Loads a view from it's xib file.
    ///
    /// - Returns: an instantiated view from the Nib file of the same class name.
    fileprivate func loadViewFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Cannot instantiate a UIView from the nib for class \(type(of: self))")
        }
        return view
    }
    
}
