//
//  DetailView.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/23/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit
import Foundation

class DetailsView: BaseCell {

    override var useNib: Bool{
        get {
            return false
        }
    }
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        tv.isEditable = false
        return tv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: textView)
        addConstraintsWithFormat(format: "V:|-4-[v0]-4-|", views: textView)
    }
}
