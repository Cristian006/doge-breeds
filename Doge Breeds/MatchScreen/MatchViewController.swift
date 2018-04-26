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

    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var leftButton: UIButton!
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(16, 16, 16, 16);
        leftButton.imageEdgeInsets = UIEdgeInsetsMake(16, 16, 16, 16);

        rightButton.layer.cornerRadius = 40
        leftButton.layer.cornerRadius = 40
        
        
        leftButton.layer.masksToBounds = false
        leftButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        leftButton.layer.shadowRadius = 8.0
        leftButton.layer.shadowColor = UIColor.black.cgColor
        leftButton.layer.shadowOpacity = 0.15
        
        rightButton.layer.masksToBounds = false
        rightButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        rightButton.layer.shadowRadius = 8.0
        rightButton.layer.shadowColor = UIColor.black.cgColor
        rightButton.layer.shadowOpacity = 0.15
    }
    
    func showMatchCardDetail(pet: Pet, heroId: String) {
        let matchDetailController = MatchDetailsView()
        matchDetailController.pet = pet
        
        matchDetailController.hero.isEnabled = true
        
        matchDetailController.matchHeaderView.hero.id = "card\(heroId)"
        matchDetailController.matchHeaderView.backgroundImage.hero.id = "card_image\(heroId)"
        matchDetailController.matchHeaderView.nameLabel.hero.id = "card_title\(heroId)"
        matchDetailController.matchHeaderView.subLabel.hero.id = "card_sub\(heroId)"
        matchDetailController.view.hero.modifiers = [.spring(stiffness: 250, damping: 30)]
        //matchDetailController.matchHeaderView.backgroundImage.hero.modifiers = [.fade]
        matchDetailController.matchHeaderView.nameLabel.hero.modifiers = [.spring(stiffness: 250, damping: 30)]
        matchDetailController.matchHeaderView.subLabel.hero.modifiers = [.spring(stiffness: 250, damping: 30)]
        present(matchDetailController, animated: true)
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
            cardView.hero.id = "card\(pets[index].name ?? String(index))"
            cardView.imageView.hero.id = "card_image\(pets[index].name ?? String(index))"
            cardView.titleLabel.hero.id = "card_title\(pets[index].name ?? String(index))"
            cardView.subtitleLabel.hero.id = "card_sub\(pets[index].name ?? String(index))"
            cardView.pet = pets[index]
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
        if let pets = finder?.pets {
            showMatchCardDetail(pet: pets[index], heroId: "\(pets[index].name ?? String(index))")
        }
    }
    
}
