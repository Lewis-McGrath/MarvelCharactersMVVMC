//
//  CharacterListViewModel.swift
//  Marvel MVVMC
//
//  Created by Lewis McGrath on 08/11/2019.
//  Copyright © 2019 Lewis McGrath. All rights reserved.
//

import Foundation

class CharacterListViewModel {
    
    let dataSession = URLSession.shared
    var dataTask: URLSessionDataTask?
    
    let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=ff3d4847092294acc724123682af904b&hash=412b0d63f1d175474216fadfcc4e4fed&limit=25&orderBy=-modified")!
    
    
    
    func getCharacterList() {
        let task = dataSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: [])
                let jsonDecoder = JSONDecoder()
                
                
                let character = try jsonDecoder.decode(Result.self, from: jsonResponse)
                print(character.name)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
//JUST WANT NAME AND RESULT DESCRIPTION inside of RESULT STRUCT.
