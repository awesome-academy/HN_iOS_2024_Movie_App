//
//  APICaller.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/16/24.
//

import Foundation
import UIKit

enum AppError: Error {
    case noInternet
    case normalError(String)
    
    var description: String {
        switch self {
        case .noInternet:
            return "No internet connection."
        case .normalError(let message):
            return message
        }
    }
}

protocol APIServiceProtocol {
    func get<T: Decodable>(urlString: String, completion: @escaping(Result<T, Error>) -> Void)
    func loadImageFromUrl(urlString: String, completion: @escaping (UIImage?, Error?) -> Void)
}

class APIService: APIServiceProtocol {
    static let shared = APIService()
    let cache = NSCache<NSString, UIImage>()
    private init() {}
    
    func get<T: Decodable>(urlString: String, completion: @escaping((Result<T, Error>) -> ())) {
         guard NetWorkMonitor.shared.isConnected else {
             completion(.failure(AppError.noInternet))
             return
         }
         guard let url = URL(string: urlString) else {
             completion(.failure(AppError.normalError("Invalid URL")))
             return
         }
         
         URLSession.shared.dataTask(with: url) { data, _, error in
             let decoder = JSONDecoder()
             
             do {
                 guard let data = data else { return }
                 let result = try decoder.decode(T.self, from: data)
                 completion(.success(result))
             } catch let error {
                 completion(.failure(error))
             }
         }.resume()
     }
  
    func loadImageFromUrl(urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image, nil)
            return
        }
        guard let url = URL(string: urlString) else {
            completion(nil, AppError.normalError("Invalid URL"))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil, AppError.normalError("Failed to load image"))
                return
            }
            cache.setObject(image, forKey: cacheKey)
            completion(image, nil)
        }
        task.resume()
    }
}
