import UIKit
import SwiftyJSON

class DogFact
{
    var title = "Doggie Fact"
    var fact = ""
    var featuredImage: UIImage? = nil
    var color: UIColor
    
    typealias dogFactStringCallback = (_ f: [String]) -> Void
    typealias dogImageCallback = (_ i: UIImage) -> Void
    typealias dogFactsCallback = (_ facts: [DogFact]) -> Void
    typealias dogFactCallback = (_ fact: DogFact) -> Void
    
    init(title: String?, fact: String?, color: UIColor, image: UIImage?) {
        self.title = title!
        self.fact = fact!
        self.color = color
        self.featuredImage = image
    }
    
    static func fetchRandomImage(callback: dogImageCallback!) {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    let json = try? JSON(data: urlContent)
                    if let message = json?["message"].string {
                        if let url = URL(string: message) {
                            let data = try? Data(contentsOf: url)
                            DispatchQueue.main.async {
                                callback(UIImage(data: data!)!)
                            }
                        }
                    } else {
                        callback(UIImage(named: "corgi")!)
                    }
                }
            }
        }
        task.resume()
    }
    
    static func fetchFacts(callback: dogFactStringCallback!) {
        // dog fact api for random dog fact
        let url = URL(string: "http://dog-api.kinduff.com/api/facts?number=5")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        if let dogFact = jsonResult["facts"] {
                            DispatchQueue.main.async {
                                callback((dogFact as! [String]))
                            }
                        } else {
                            callback([])
                        }
                    } catch {
                        print ("Json Processing Failed")
                    }
                }
            }
        }
        task.resume()
    }
    
    // returns an array of dog facts
    static func dogFetchOperations(callback: dogFactsCallback!){
        let opQueue = OperationQueue()
        
        var dFacts: [DogFact]! = [DogFact]()
        
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            group.enter()
            fetchFacts(callback: { (facts) in
                for f in facts {
                    group.enter()
                    fetchRandomImage(callback: { (image) in
                        dFacts.append(DogFact(
                            title: "Doggie Fact",
                            fact: f,
                            color: Colors.getRandomColor(),
                            image: image
                        ))
                        group.leave()
                    })
                    
                }
                group.leave()
            })

            group.wait()
            DispatchQueue.main.async {
                callback(dFacts)
            }
        }
        
        opQueue.addOperation(operation1)
    }
    
    // returns an array of dogfacts one at a time
    static func dogFetchOperations(singleCallback: dogFactCallback!){
        let opQueue = OperationQueue()
        
        let operation1 = BlockOperation {
            let group = DispatchGroup()
            group.enter()
            fetchFacts(callback: { (facts) in
                for f in facts {
                    group.enter()
                    fetchRandomImage(callback: { (image) in
                        DispatchQueue.main.async {
                            singleCallback(DogFact(
                                title: "Doggie Fact",
                                fact: f,
                                color: Colors.getRandomColor(),
                                image: image
                            ))
                        }
                        group.leave()
                    })
                    
                }
                group.leave()
            })
            group.wait()
        }
        
        opQueue.addOperation(operation1)
    }
}
