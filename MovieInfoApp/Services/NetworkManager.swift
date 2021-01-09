//
//  NetworkManager.swift
//  MovieInfoApp
//
//  Created by Ibragim Akaev on 09/01/2021.
//

import UIKit
import Alamofire

class NetworkManager {
    
    func fetchMovie(searchText: String, competion: @escaping (MovieResult?) -> Void)  {
        
        let url = "https://www.omdbapi.com/?apikey=1074629&type=movie&s=\(searchText)"
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received requestiong data: \(error.localizedDescription)")
                competion(nil)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(MovieResult?.self, from: data)
                competion(objects)
                
            } catch let jsonError {
                print("Failed to decode JSON:", jsonError)
                competion(nil)
            }
        }
    }
}
