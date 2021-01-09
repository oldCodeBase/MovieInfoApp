//
//  MovieResult.swift
//  MovieInfoApp
//
//  Created by Ibragim Akaev on 09/01/2021.
//

import Foundation

struct MovieResult: Codable {
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movie: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    private enum CodingKeys: String, CodingKey {
        case title = "Title",
             year = "Year",
             imdbID = "imdbID",
             type = "Type",
             poster = "Poster"
    }
}
