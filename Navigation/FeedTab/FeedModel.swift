//
//  FeedModel.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 08.09.2022.
//

import Foundation

class FeedModel {
    private let secret = "Ddd"
    
    func check(word: String) -> Bool {
         word == secret 
    }
}

struct PlanetInfo: Decodable {
    var name: String
    var dayLength: String
    var residents: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case dayLength = "orbital_period"
        case residents
    }
}

struct PeopleName: Decodable {
    var name: String
}

func getTODOItem(completion: ((_ todoItemTitle: String?) -> ())?) {
    getData(url: URL(string: "https://jsonplaceholder.typicode.com/todos/55")!) { data in
        guard let data else { return }
        
        do {
            let answer  = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            if let todoItemTitle = answer?["title"] as? String {
                completion?(todoItemTitle)
            }
        } catch {
            print(error)
            completion?(nil)
        }
    }
}

func getPlanetDayLength(completion: ((_ planetItem: PlanetInfo?) -> ())?) {
    getData(url: URL(string: "https://swapi.dev/api/planets/1")!) { data in
        guard let data else { return }
        
        do {
            let answer = try JSONDecoder().decode(PlanetInfo.self, from: data)
            completion?(answer)
            return
        } catch {
            print(error)
            completion?(nil)
        }
    }
}

func getPlanetResidentName(peopleURL: String, completion: ((_ peopleName: PeopleName?) -> ())?) {
    getData(url: URL(string: peopleURL)!) { data in
        guard let data else { return }
        
        do {
            let answer = try JSONDecoder().decode(PeopleName.self, from: data)
            completion?(answer)
            return
        } catch {
            print(error)
            completion?(nil)
        }
    }
}

private func getData(url: URL, completion: ((_ data: Data?) -> ())?) {
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let error {
            print(error.localizedDescription)
            completion?(nil)
            return
        }
        
        if (response as! HTTPURLResponse).statusCode != 200 {
            print("Status code != 200, statusCode = \((response as! HTTPURLResponse).statusCode)")
            completion?(nil)
            return
        }
        
        guard let data else {
            print("data = nil")
            completion?(nil)
            return
        }
        completion?(data)
    }
    task.resume()
}
