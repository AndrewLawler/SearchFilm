//
//  NetworkManager.swift
//  SearchFilm-iOS
//
//  Created by Andrew Lawler on 13/03/2020.
//  Copyright © 2020 andrewlawler. All rights reserved.
//

import Foundation

// Error case

enum FilmError: String, Error {
    case errorSearching    = "There has been an error while searching. Please try again."
}

class NetworkManager {
    
    // Singleton pattern
    static let shared = NetworkManager()
    let baseURL = "http://www.omdbapi.com/?t="
    let withYear = "&y="
    let APIKey = "&apikey=YOUR KEY"
    
    private init() {}
    
    // function to get from API
    func getFilm(for filmName: String, year: Int?, completed: @escaping (Result<Film, FilmError>) -> Void) {
        
        let newFilmName = filmName.replacingOccurrences(of: " ", with: "+")
        
        // add year if we have it, if not just search anyway
        var endpoint = baseURL + newFilmName
        if (year != nil) {
            endpoint += withYear + "\(String(year!))"
        }
        endpoint += APIKey
        
        guard let url = URL(string: endpoint) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // handle all cases
            
            if let _ = error {
                completed(.failure(.errorSearching))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.errorSearching))
                return
            }
            
            guard let data = data else {
                completed(.failure(.errorSearching))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let user = try decoder.decode(Film.self, from: data)
                completed(.success(user))
                
            } catch {
                completed(.failure(.errorSearching))
            }
            
        }
        
        task.resume()
        
    }
    
}
