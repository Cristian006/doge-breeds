//
//  PetFinderDecoder.swift
//  Doge Breeds
//
//  Created by Cristian Ponce on 4/24/18.
//  Copyright © 2018 Cristian Ponce. All rights reserved.
//
import UIKit
import Foundation
import SwiftyJSON
import ChameleonFramework

struct ContactInfo {
    var phone: String?
    var state: String?
    var address1: String?
    var address2: String?
    var email: String?
    var city: String?
    var zip: String?
    var fax: String?
}

struct Photo {
    var size: String?
    var url: String?
    var id: String?
}
struct Media {
    var photos: [Photo]?
}

struct Pet {
    var options: [String]?
    var status: String?
    var contact: ContactInfo?
    var age: String?
    var size: String?
    var media: Media?
    var id: String?
    var shelterPetID: String?
    var breeds: [String]?
    var name: String?
    var sex: String?
    var description: String?
    var mix: String?
    var shelterID: String?
    var lastUpdate: String?
    var animal: String?
    var color: UIColor?
}

struct PetFinder {
    var lastOffset: Int?
    var pets: [Pet]?
}

extension Pet {
    func getImg() -> UIImage {
        var img: UIImage? = nil
        if self.media?.photos != nil,
            (self.media?.photos?.count)! > 0,
            let url = self.media?.photos!.filter({ (Photo) -> Bool in
                return Photo.size == "x"
            })[0].url {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                img = UIImage(data: data)
            }
        }
        return img ?? UIImage(named: "dogie_circle")!
    }
    
    func getGenderIcon() -> UIImage {
        return UIImage(named: (self.sex == "M" ? "gender-male" : "gender-female"))!
    }
    
    func getLocationLabel() -> String {
        var locationStr = ""
        if let city = self.contact?.city {
            locationStr += "\(city), "
        }
        if let state = self.contact?.state {
            locationStr += state
        }
        return locationStr
    }
    
    func getSubLabel() -> String {
        var sub = ""
        if let age = self.age {
            sub += "\(age) · "
        }
        if let breeds = self.breeds {
            sub += breeds.joined(separator: " & ")
        }
        return sub
    }
}

class PetFinderDecoder {
    static func decode(petFinder: JSON) -> PetFinder {
        var finder = PetFinder()
        if let offset = petFinder["petfinder", "lastOffset", "$t"].int {
            finder.lastOffset = offset
        }
        finder.pets = [Pet]()
        if let pets = petFinder["petfinder", "pets", "pet"].array {
            var p = Pet()
            for pet in pets {
                p.options = [String]()
                if let ops = pet["options"].array {
                    for op in ops {
                        if let o = op["$t"].string {
                            p.options?.append(o)
                        }
                    }
                }
                if let status = pet["status", "$t"].string {
                    p.status = status
                }
                let contact = pet["contact"]
                if contact != JSON.null {
                    p.contact = ContactInfo(
                        phone: contact["phone", "$t"].string,
                        state: contact["state", "$t"].string,
                        address1: contact["address1", "$t"].string,
                        address2: contact["address2", "$t"].string,
                        email: contact["email", "$t"].string,
                        city: contact["city", "$t"].string,
                        zip: contact["zip", "$t"].string,
                        fax: contact["fax", "$t"].string
                    )
                } else {
                    p.contact = ContactInfo()
                }
                
                if let age = pet["age", "$t"].string {
                    p.age = age
                }
                
                if let size = pet["size", "$t"].string {
                    p.size = size
                }
                let media = pet["media"]
                if media != JSON.null {
                    p.media = Media(photos: [Photo]())
                    if let photos = media["photos", "photo"].array {
                        for photo in photos {
                            p.media?.photos?.append(Photo(
                                size: photo["@size"].string,
                                url: photo["$t"].string,
                                id: photo["@id"].string
                            ))
                        }
                    }
                }
                
                if let id = pet["id", "$t"].string {
                    p.id = id
                }
                
                if let shelterPetId = pet["shelterPetId", "$t"].string {
                    p.shelterPetID = shelterPetId
                }

                p.breeds = [String]()
                if let breeds = pet["breeds", "breed"].array {
                    for breed in breeds {
                        if let b = breed["$t"].string {
                            p.breeds?.append(b)
                        }
                    }
                } else if let breeds = pet["breeds", "breed"].dictionary {
                    if let b = breeds["$t"]?.string {
                        p.breeds?.append(b)
                    }
                }
                
                if let name = pet["name", "$t"].string {
                    p.name = name
                }
                
                if let sex = pet["sex", "$t"].string {
                    p.sex = sex
                }
                
                if let description = pet["description", "$t"].string {
                    p.description = description
                }
                
                if let mix = pet["mix", "$t"].string {
                    p.mix = mix
                }
                
                if let shelterId = pet["shelterId", "$t"].string {
                    p.shelterID = shelterId
                }
                
                if let lastUpdate = pet["lastUpdate", "$t"].string {
                    p.lastUpdate = lastUpdate
                }
                
                if let animal = pet["animal", "$t"].string {
                    p.animal = animal
                }
                p.color = RandomFlatColorWithShade(shade: .light)
                finder.pets?.append(p)
            }
        }
        return finder
    }
}
