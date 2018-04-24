//
//  FactsCollectionViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/10/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var dogBreedCollectionView: UICollectionView!
    
    var dogBreeds: [DogBreed]! = [DogBreed]()
    
    let FactParentCellID = "FactsParentCell"
    let BreedCellID = "BreedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DogBreed.dogBreedOperations(SingleCallback: self.receiveDogBreed)
        
        let f = (dogBreedCollectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        
        f.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        dogBreedCollectionView?.dataSource = self
        dogBreedCollectionView?.delegate = self
    }
    
    func showBreedDetailFor(breed: DogBreed) {
        let layout = UICollectionViewFlowLayout()
        let breedDetailController = BreedDetailViewController(collectionViewLayout: layout)
        breedDetailController.breed = breed
        navigationController?.pushViewController(breedDetailController, animated: true)
    }
    
    func receiveDogBreed(_ d: DogBreed) -> Void {
        dogBreeds.append(d)
        let indexPath = IndexPath(
            item: self.dogBreeds.count - 1,
            section: 1
        )
        
        dogBreedCollectionView?.performBatchUpdates({
            self.dogBreedCollectionView?.insertItems(at: [indexPath])
        }, completion: nil)
    }
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0) {
            return 1
        } else {
            return dogBreeds.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactParentCellID, for: indexPath) as! FactsParentCell
            cell.setup()
            return cell
        }
        
        let cell = dogBreedCollectionView.dequeueReusableCell(withReuseIdentifier: BreedCellID, for: indexPath) as! BreedCollectionViewCell
        cell.breed = dogBreeds[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0) {
            return CGSize(width: view.bounds.width, height: 230)
        } else {
            let w = view.bounds.width * 0.9 / 2
            return CGSize(width: w, height: 300)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(section == 0) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            let insetX = ((view.bounds.width * 0.1)) / 4
            return UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 1) {
            if let dogBreed = self.dogBreeds?[indexPath.item] {
                self.showBreedDetailFor(breed: dogBreed)
            }
        }
    }
}

class FactsParentCell: UICollectionViewCell {
    @IBOutlet weak var dogFactCollectionView: UICollectionView!
    let FactCellID = "FactCell"
    
    var dogFacts: [DogFact]! = [DogFact]()
    var started = false
    var cellScaling: CGFloat = 0.9
    
    func setup() {
        print("SETUP")
        if !started {
            DogFact.dogFetchOperations(singleCallback: self.recivedDogFact)
            started = true
        }
        let layout = dogFactCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling) // scale card width to be 90% of screen width
        let cellHeight = layout.itemSize.height
        
        // padding for left and right to be able to center the cards in the middle
        let insetX = (screenSize.width - cellWidth) / 2.0
        let insetY = CGFloat(0.0) // we don't want any inset on top or bottom
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        dogFactCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        dogFactCollectionView?.dataSource = self
        dogFactCollectionView?.delegate = self
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

extension FactsParentCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dogFacts.count)
        return dogFacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCellID, for: indexPath) as! FactCollectionViewCell
        
        cell.fact = dogFacts[indexPath.item]
        
        return cell
    }
}

extension FactsParentCell : UIScrollViewDelegate, UICollectionViewDelegate {
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
