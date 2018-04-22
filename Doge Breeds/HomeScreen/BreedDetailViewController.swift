//
//  BreedDetailViewController.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/22/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

import UIKit

class BreedDetailViewController: UIViewController {

    var breed: DogBreed? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        print(breed?.name ?? "EMPTY BREED")
        self.title = breed?.name ?? "Dogie"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
