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
    
    private func descriptionAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
        
        attributedText.append(NSMutableAttributedString(string: "Facts\n\n", attributes: [
            kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 18)
            ]))
        
        
        if let origin = breed?.details?.origin {
            
            attributedText.append(NSMutableAttributedString(string: "Origin\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            
            attributedText.append(NSMutableAttributedString(string: origin, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        if let height = breed?.facts?.height {
            attributedText.append(NSMutableAttributedString(string: "\nHeight\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: height, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let life = breed?.facts?.life {
            attributedText.append(NSMutableAttributedString(string: "\nLife Span\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: life, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let size = breed?.facts?.size {
            attributedText.append(NSMutableAttributedString(string: "\nSize\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: size, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let weight = breed?.facts?.weight {
            attributedText.append(NSMutableAttributedString(string: "\nWeight\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: weight, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        attributedText.append(NSMutableAttributedString(string: "\n\nDescription\n\n", attributes: [
            kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 18)
            ]))
        
        
        
        if let aka = breed?.details?.aka {
            attributedText.append(NSMutableAttributedString(string: "Also Known As\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: aka, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let history = breed?.details?.history {
            attributedText.append(NSMutableAttributedString(string: "\nHistory\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: history, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let temper = breed?.details?.role {
            attributedText.append(NSMutableAttributedString(string: "\nTemperament\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: temper, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        if let role = breed?.details?.role {
            attributedText.append(NSMutableAttributedString(string: "\nToday's Role\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: role, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        
        if let exercise = breed?.details?.special?.exersise {
            attributedText.append(NSMutableAttributedString(string: "\nExercise\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: exercise, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        
        if let grooming = breed?.details?.special?.grooming {
            attributedText.append(NSMutableAttributedString(string: "\nGrooming\n", attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.boldSystemFont(ofSize: 16)
                ]))
            attributedText.append(NSMutableAttributedString(string: grooming, attributes: [
                kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 14),
                kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.darkGray
                ]))
        }
        return attributedText
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension BreedDetailViewController: BreedHeaderViewDelegate {
    func onBackButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func onBookmarkButtonPressed(_ sender: Any) {
        print("bookmarked")
    }
}
