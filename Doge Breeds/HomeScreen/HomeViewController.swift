//
//  FactsCollectionViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/10/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var dogFactCollectionView: UICollectionView!
    @IBOutlet weak var dogBreedTableView: UITableView!
    
    var dogFacts: [DogFact]! = [DogFact]()
    var dogBreeds: [DogBreed]! = [DogBreed]()
    var cellScaling: CGFloat = 0.9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DogFact.dogFetchOperations(singleCallback: self.recivedDogFact)
        
        DogBreed.dogBreedOperations(SingleCallback: self.receiveDogBreed)
        
        let layout = dogFactCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling) // scale card width to be 90% of screen width
        let cellHeight = layout.itemSize.height
        
        // padding for left and right to be able to center the cards in the middle
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = CGFloat(0.0) // we don't want any inset on top or bottom
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        dogFactCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        dogBreedTableView?.dataSource = self
        dogBreedTableView?.delegate = self
        
        dogFactCollectionView?.dataSource = self
        dogFactCollectionView?.delegate = self
    }
    
    func receiveDogBreeds(_ breeds: [DogBreed]) -> Void {
        dogBreeds = breeds
        dogBreedTableView!.reloadData()
    }
    
    func receiveDogBreed(_ d: DogBreed) -> Void {
        dogBreeds.append(d)
        let indexPath = IndexPath(
            item: self.dogBreeds.count - 1,
            section: 0
        )
        
        dogBreedTableView?.performBatchUpdates({
            self.dogBreedTableView?.insertRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }
    
    func recivedDogFacts(_ facts: [DogFact]) -> Void {
        dogFacts = facts
        dogFactCollectionView!.reloadData()
    }
    
    func recivedDogFact(_ fact: DogFact) -> Void {
        dogFacts.append(fact)
        let indexPath = IndexPath(
            item: self.dogFacts.count - 1,
            section: 0
        )
        
        dogFactCollectionView?.performBatchUpdates({
            self.dogFactCollectionView?.insertItems(at: [indexPath])
        }, completion: nil)
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogBreeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dogBreedTableView.dequeueReusableCell(withIdentifier: "BreedHomeCell") as! BreedTableViewCell
        
        cell.breed = dogBreeds[indexPath.item]
        
        return cell
    }
}

extension HomeViewController : UICollectionViewDataSource
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

extension HomeViewController : UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.dogFactCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
    }
}
