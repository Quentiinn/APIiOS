//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct PhotoInfo {
    var id: Int
    var name: String
    var age: Int
    var point: Double
    var capitaine: Bool
    
    
    init?(json: [String: String]){
        //guard -> if qui permet de tester si ca plante pas sinon return nil
        guard let id = json["id"],
            let name = json["name"],
            let age = json["age"],
            let point = json["point"],
        let capitaine = json["capitaine"] else {return nil}
        self.id = Int(id)!
        self.name = name
        self.age = Int(age)!
        self.point = Double(point)!
        self.capitaine = ((capitaine == "1" ) ? Bool("true")! : Bool("false")!)
        
    }
}

extension URL{
    func withQueries(_ queries: [String: String])-> URL?{
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap {URLQueryItem(name: $0.0 , value: $0.1)}
        return components?.url
        
    }
}

func fetchPhotoInfo(completion: @escaping (PhotoInfo) -> Void){
    let baseURL = URL(string: "http://quentindev.ovh/player/player.php")!
    
    
    let query: [String: String] = [
        "todo": "select",
        "id" : "2"
    ]
    
    let url = baseURL.withQueries(query)!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        //completion handler
        if let data = data,
            let rawjson = try? JSONSerialization.jsonObject(with: data),
            let json = rawjson as? [String: String],
            let photoInfo = PhotoInfo(json: json){
            completion(photoInfo)
        }
        
    }
    task.resume()
}

fetchPhotoInfo{(fetchedInfo) in
    print(fetchedInfo)
}




