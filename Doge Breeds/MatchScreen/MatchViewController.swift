//
//  MatchViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/22/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {
    
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    
    @IBAction func SwipeRightButton(_ sender: Any) {
        swipeableCardView.autoSwipe(direction: SwipeDirection.right)
    }
    
    @IBAction func SwipeLeftButton(_ sender: Any) {
        swipeableCardView.autoSwipe(direction: SwipeDirection.left)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeableCardView.dataSource = self
        swipeableCardView.delegate = self
    }
    
}

// MARK: - SwipeableCardViewDataSource

extension MatchViewController : SwipeableCardViewDataSource {
    
    func numberOfCards() -> Int {
        return viewModels.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        let viewModel = viewModels[index]
        let cardView = MatchCardView()
        cardView.viewModel = viewModel
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

extension MatchViewController {
    
    var viewModels: [MatchCardViewModel] {
        
        let hamburger = MatchCardViewModel(title: "McDonalds",
                                                     subtitle: "Hamburger",
                                                     color: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0),
                                                     image: UIImage(named: "corgi"))
        
        let panda = MatchCardViewModel(title: "Panda",
                                                 subtitle: "Animal",
                                                 color: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0),
                                                 image: UIImage(named: "corgi"))
        
        let puppy = MatchCardViewModel(title: "Puppy",
                                                 subtitle: "Pet",
                                                 color: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0),
                                                 image: UIImage(named: "corgi"))
        
        let poop = MatchCardViewModel(title: "Poop",
                                                subtitle: "Smelly",
                                                color: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0),
                                                image: UIImage(named: "corgi"))
        
        let robot = MatchCardViewModel(title: "Robot",
                                                 subtitle: "Future",
                                                 color: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0),
                                                 image: UIImage(named: "corgi"))
        
        let clown = MatchCardViewModel(title: "Clown",
                                                 subtitle: "Scary",
                                                 color: UIColor(red:0.83, green:0.82, blue:0.69, alpha:1.0),
                                                 image: UIImage(named: "corgi"))
        
        return [hamburger, panda, puppy, poop, robot, clown,
                hamburger, panda, puppy, poop, robot, clown,
                hamburger, panda, puppy, poop, robot, clown]
    }
    
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

//}
