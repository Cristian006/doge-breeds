//
//  BreedDetailViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/22/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class BreedDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let headerID = "headerID"
    private let detailsCellID = "detailsCellID"
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var breed: DogBreed? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        self.title = breed?.name ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // HERO STUFF
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(BreedHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        
        collectionView?.register(DetailsView.self, forCellWithReuseIdentifier: detailsCellID)
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
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! BreedHeaderView
        header.delegate = self
        header.breed = breed
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dummySize = CGSize(width: view.frame.width - 16 - 16, height: 10000)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let rect = descriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
        
        return CGSize(width: view.frame.width, height: rect.height + 24)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailsCellID, for: indexPath) as! DetailsView
        cell.textView.attributedText = descriptionAttributedText()
        cell.textView.sizeToFit()
        cell.textView.isScrollEnabled = false
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension BreedDetailViewController: BreedHeaderViewDelegate {
    func onBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // navigationController?.popViewController(animated: true)
    }
    
    func onBookmarkButtonPressed(_ sender: Any) {
        print("bookmarked")
    }
}
