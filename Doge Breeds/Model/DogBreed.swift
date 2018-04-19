//
//  DogBreed.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/19/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//

struct factsStructure {
    var height: String
    var life: String
    var size: String
    var weight: String
}

struct specialDetails {
    var exersise: String
    var grooming: String
}

struct detailStructure {
    var aka: String
    var group: String
    var health: String
    var history: String
    var origin: String
    var role: String
    var temparment: String
    var special: specialDetails
}

class DogBreed
{
    var name: String
    var link: String
    var img: String
    var facts: factsStructure
    var details: detailStructure
    
    init(name: String, link: String, img: String, facts: factsStructure, details: detailStructure) {
        self.name = name
        self.link = link
        self.img = img
        self.facts = facts
        self.details = details
    }
}
