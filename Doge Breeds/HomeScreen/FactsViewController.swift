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
    var cellScaling: CGFloat = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DogFact.fetchFacts(callback: self.recivedDogFacts)
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        //let insetX = (view.bounds.width - cellWidth) / 2.0
        //let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        /*
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        */
        collectionView?.dataSource = self
    }
    
    func recivedDogFacts(f: [String]) -> Void {
        print(f)
        for fa in f {
            dogFacts.append(DogFact(
                title: "Fun Fact",
                fact: fa,
                featuredImage: UIImage(named: "corgi")!,
                color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)
            ))
            collectionView!.reloadData()
        }
        print(collectionView.reloadItems(at: [IndexPath(index: 0)]))
        print(collectionView.numberOfItems(inSection: 0))
    }
}

extension FactsViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /*if dogFacts != nil && !dogFacts.isEmpty {
            return (dogFacts.count)
        }*/
        print(dogFacts.count)
        return dogFacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        print(indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FactCell", for: indexPath) as! FactCollectionViewCell
        
        cell.setFact(df: dogFacts[indexPath.item])
        
        return cell
    }
}
