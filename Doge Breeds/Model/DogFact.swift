import UIKit

class DogFact
{
    var title = "Doggie Fact"
    var fact = ""
    var featuredImage: UIImage
    var color: UIColor
    
    typealias dogFactCallback = (_ f: [String]) -> Void
    
    init(title: String?, fact: String?, featuredImage: UIImage, color: UIColor) {
        self.title = title!
        self.fact = fact!
        self.featuredImage = featuredImage
        self.color = color
    }
    
    static func fetchFacts(callback: dogFactCallback!) {
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
}
