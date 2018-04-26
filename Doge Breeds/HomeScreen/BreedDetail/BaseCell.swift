//
//  BaseCell.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/23/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    var useNib: Bool{
        get {
            return true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (useNib){
            loadView()
        }
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if (useNib){
            loadView()
        }
        setupViews()
    }
    
    func loadView() {
        let contentView = loadViewFromNib()
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    fileprivate func loadViewFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Cannot instantiate a UIView from the nib for class \(type(of: self))")
        }
        return view
    }
    
    func setupViews() {
        
    }
}
