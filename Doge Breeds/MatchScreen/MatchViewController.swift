//
//  MatchViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/22/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MatchViewController: UIViewController {
    
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    
    @IBAction func SwipeRightButton(_ sender: Any) {
        swipeableCardView.autoSwipe(direction: SwipeDirection.right)
    }
    
    @IBAction func SwipeLeftButton(_ sender: Any) {
        swipeableCardView.autoSwipe(direction: SwipeDirection.left)
    }
    
    var finder: PetFinder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://api.petfinder.com/pet.find?key=bff52105ec92481be5e1ab488642c737&animal=dog&location=94303&output=full&format=json").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.finder = PetFinderDecoder.decode(petFinder: json)
                self.swipeableCardView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        swipeableCardView.dataSource = self
        swipeableCardView.delegate = self
    }
    
}

// MARK: - SwipeableCardViewDataSource

extension MatchViewController : SwipeableCardViewDataSource {
    
    func numberOfCards() -> Int {
        if let pets = finder?.pets {
            return pets.count
        }
        return 0
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let cardView = MatchCardView()
        if let pets = finder?.pets {
            var img: UIImage? = nil
            if pets[index].media?.photos != nil,
                (pets[index].media?.photos?.count)! > 0,
                let url = pets[index].media?.photos!.filter({ (Photo) -> Bool in
                    return Photo.size == "x"
                })[0].url {
                if let data = try? Data(contentsOf: URL(string: url)!) {
                    img = UIImage(data: data)
                }
            }
            // (pets[index].contact?.city!)!
            let viewModel = MatchCardViewModel(
                title: pets[index].name!,
                subtitle: "\(pets[index].age ?? "") · \(pets[index].breeds?.joined(separator: " & ") ?? "")",
                location: "\(pets[index].contact?.city ?? ""), \(pets[index].contact?.state ?? "")",
                color: Colors.getRandomColor(alpha: 1.0),
                image: img ?? UIImage(named: "dogie_circle"),
                sex: pets[index].sex
            )
            cardView.viewModel = viewModel
        }
        return cardView
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
}

extension MatchViewController : SwipeableCardViewDelegate {
    
    func didSwipe(card: SwipeableCardViewCard, direction: SwipeDirection, atIndex index: Int) {
        print("Swiped Card \(index) to the \(direction)")
    }
    
    func didSelect(card: SwipeableCardViewCard, atIndex index: Int) {
        print("Selected Card \(index)")
    }
    
}
