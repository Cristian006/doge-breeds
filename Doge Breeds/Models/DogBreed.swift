//
//  DogBreed.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/19/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//
import UIKit
import SwiftyJSON
import ChameleonFramework

struct factsStructure {
    var height: String?
    var life: String?
    var size: String?
    var weight: String?
}

struct specialDetails {
    var exersise: String?
    var grooming: String?
}

struct detailStructure {
    var aka: String?
    var group: String?
    var health: String?
    var history: String?
    var origin: String?
    var role: String?
    var temparment: String?
    var special: specialDetails?
}

class DogBreed
{
    var name: String?
    var link: String?
    var img: String?
    var facts: factsStructure?
    var details: detailStructure?
    var color: UIColor?
    
    typealias receiveDogBreed = (_ d: DogBreed) -> Void
    typealias receiveDogBreeds = (_ d: [DogBreed]) -> Void
    
    init(name: String, link: String, img: String, color: UIColor,facts: factsStructure, details: detailStructure) {
        self.name = name
        self.link = link
        self.img = img
        self.color = color
        self.facts = facts
        self.details = details
    }
    
    init() {
        self.name = ""
        self.link = ""
        self.img = nil
        self.facts = nil
        self.details = nil
    }
    
    static func dogBreedOperations(SingleCallback: receiveDogBreed!) -> Void {
        let path = Bundle.main.path(forResource: "Breeds", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        let opQueue = OperationQueue()
        
        let operation1 = BlockOperation {
            do {
                let data = try Data(contentsOf: url)
                let breeds = try? JSON(data: data)
                
                for (_, json):(String, JSON) in breeds! {
                    // Do something you want
                    let c = RandomFlatColorWithShade(shade: .light).withAlphaComponent(CGFloat(0.6))
                    
                    let breed = DogBreed(
                        name: (json["name"].string)!,
                        link: (json["link"].string)!,
                        img: (json["img"].string)!,
                        color: c,
                        facts: factsStructure(
                            height: json["facts", "height"].string,
                            life: json["facts", "life"].string,
                            size: json["facts", "size"].string,
                            weight: json["facts", "weight"].string
                        ),
                        details: detailStructure(
                            aka: json["details", "aka"].string,
                            group: json["details", "group"].string,
                            health: json["details", "health"].string,
                            history: json["details", "history"].string,
                            origin: json["details", "origin"].string,
                            role: json["details", "role"].string,
                            temparment: json["details", "temparment"].string,
                            special: specialDetails(
                                exersise: json["details", "exersise"].string,
                                grooming: json["details", "grooming"].string
                            )
                        )
                    )
                    DispatchQueue.main.async {
                        SingleCallback(breed)
                    }
                }
            } catch {
                print("ERROR READING JSON")
            }
        }
        
        opQueue.addOperation(operation1)
    }
    
    static func dogBreedOperations(callback: receiveDogBreeds!) -> Void {
        let path = Bundle.main.path(forResource: "Breeds", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        let opQueue = OperationQueue()
        
        let operation1 = BlockOperation {
            var breedObjs = [DogBreed]()
            do {
                let data = try Data(contentsOf: url)
                if let breeds = try ((JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray)) {
                    for obj in breeds {
                        let breed: DogBreed?
                        if let dic = obj as? NSDictionary {
                            breed = DogBreed()
                            for (key, value) in dic {
                                switch (key as! String) {
                                case "details":
                                    if let d = value as? [String: Any]{
                                        var specialObj: specialDetails? = specialDetails()
                                        
                                        if let s = value as? [String: Any] {
                                            specialObj = specialDetails(exersise: s["exercise"] as? String, grooming: s["grooming"] as? String)
                                        }
                                        
                                        breed?.details = detailStructure(aka: d["aka"] as? String, group: d["group"] as? String, health: d["health"] as? String, history: d["history"] as? String, origin: d["origin"] as? String, role: d["role"] as? String, temparment: d["temparment"] as? String, special: specialObj)
                                    }
                                case "img":
                                    if let i = value as? String {
                                        breed?.img = i
                                    }
                                case "name":
                                    if let i = value as? String {
                                        breed?.name = i
                                    }
                                case "link":
                                    if let i = value as? String {
                                        breed?.link = i
                                    }
                                case "facts":
                                    if let f = value as? [String: Any]{
                                        breed?.facts = factsStructure(height: f["height"] as? String, life: f["life"] as? String, size: f["size"] as? String, weight: f["weight"] as? String)
                                    }
                                default:
                                    print("WE NEED THIS VALUE")
                                    print(key)
                                }
                            }
                            
                            breedObjs.append(breed!)
                        }
                    }
                }
            } catch {
                print("ERROR READING JSON")
            }
            DispatchQueue.main.async {
                callback(breedObjs)
            }
        }
    
        opQueue.addOperation(operation1)
    }
}
