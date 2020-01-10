//
//  CharacterListService.swift
//  Marvel MVVMC
//
//  Created by Lewis McGrath on 08/11/2019.
//  Copyright © 2019 Lewis McGrath. All rights reserved.
//

import UIKit

class CharacterListService {
    
    let dataSession: URLSession
    var dataTask: URLSessionDataTask?
    
    let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=ff3d4847092294acc724123682af904b&hash=412b0d63f1d175474216fadfcc4e4fed&limit=25&orderBy=-modified")!
    
    init(dataSession: URLSession = URLSession.shared) {
        self.dataSession = dataSession
    }
    
    // MARK: Full Response Call
    
    func getCharacterDataResponse(completion: @escaping (Response?) -> Void ) {
        let task = dataSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(nil)
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let responseModel = try decoder.decode(Response.self, from: data)
                    completion(responseModel)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    
    // MARK: Image Call
    func getCharacterImageResponse(from thumbnailImageUrl: String, completion: @escaping (UIImage) -> Void ) {
        let url = URL(string: thumbnailImageUrl)!
        let task = dataSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("********HELLO*******", error?.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Invalid data from image thumbnail")
            }
        }
        task.resume()
    }}
