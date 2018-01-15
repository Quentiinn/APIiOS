//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let postString = "name=nom&age=20&point=344&capitaine=true"

// create post request
let url = URL(string: "http://quentindev.ovh/player/player.php")!
var request = URLRequest(url: url)
request.httpMethod = "POST"

// insert json data to the request
request.httpBody = postString.data(using: String.Encoding.utf8)


let task = URLSession.shared.dataTask(with: request) { data, response, error in
    print(data)
}

task.resume()
