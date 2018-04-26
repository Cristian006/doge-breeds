//
//  ViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/25/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class MatchDetailsView: UIViewController, MatchHeaderViewDelegate {
    
    var matchHeaderView = MatchHeader()
    
    var pet: Pet? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let p = pet {
            matchHeaderView.pet = p
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(matchHeaderView)
        matchHeaderView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        matchHeaderView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: CGSize(width: 0, height: 300))
        matchHeaderView.setNeedsLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MatchDetailsView {
    
    func onBackButtonPressed(_ sender: Any) {
        self.hero.dismissViewController()
    }
    
    func onBookmarkButtonPressed(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
