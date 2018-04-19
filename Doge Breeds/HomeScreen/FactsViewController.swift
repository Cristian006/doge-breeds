//
//  FactsCollectionViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/10/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dogFacts: [DogFact]! = [DogFact]()
    var cellScaling: CGFloat = 0.9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DogFact.dogFetchOperations(singleCallback: self.recivedDogFact)
        //DogFact.fetchFacts(callback: self.recivedDogFacts)
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling) // scale card width to be 90% of screen width
        let cellHeight = layout.itemSize.height
        
        // padding for left and right to be able to center the cards in the middle
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = CGFloat(0.0) // we don't want any inset on top or bottom
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    func recivedDogFacts(_ facts: [DogFact]) -> Void {
        dogFacts = facts
        collectionView!.reloadData()
    }
    
    func recivedDogFact(_ fact: DogFact) -> Void {
        dogFacts.append(fact)
        let indexPath = IndexPath(
            item: self.dogFacts.count - 1,
            section: 0
        )
        
        collectionView?.performBatchUpdates({
            self.collectionView?.insertItems(at: [indexPath])
        }, completion: nil)
    }
}

extension FactsViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogFacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FactCell", for: indexPath) as! FactCollectionViewCell
        
        cell.fact = dogFacts[indexPath.item]
        
        return cell
    }
}

extension FactsViewController : UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
    }
}
