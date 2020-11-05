//
//  NetworkService.swift
//  MVP-LevelOne
//
//  Created by Dima Khymych on 29.09.2020.
//

import Foundation

protocol NetworkServiceProtocol {
    func getComments(_ completion: @escaping (Result<[Comment]?,Error>) -> Void)
}

class NetworkService:NetworkServiceProtocol {
   
    func getComments(_ completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                let obj = try JSONDecoder().decode([Comment].self, from: data!)
                completion(.success(obj))
            } catch{
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
    
}
