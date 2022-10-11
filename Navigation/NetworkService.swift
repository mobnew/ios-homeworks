//
//  NetworkService.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 10.10.2022.
//

import Foundation


enum AppConfiguration: String {
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"
    
    static var allCases: [AppConfiguration] {
        return [.url1, .url2, .url3]
    }
}

var appConfiguration: AppConfiguration?

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: configuration.rawValue)!) { data, responce, error in
            
            if let error {
                print(error.localizedDescription)
                return
            }
            
            if (responce as! HTTPURLResponse).statusCode != 200 {
                print("Status code != 200, statusCode = \((responce as! HTTPURLResponse).statusCode)")
                return
            }
            
            guard let data else {
                print("data = nil")
                return
            }
            
            do {
                let answer = try JSONSerialization.jsonObject(with: data)
                print(answer)
                print("--------------")
                print((responce as! HTTPURLResponse).statusCode)
                print("--------------")
                print((responce as! HTTPURLResponse).allHeaderFields)
                
                //                Error message:
                //                The Internet connection appears to be offline.
                return
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
