//
//  BookAPI.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import Foundation

struct GoogleBookAPI {
    var searchTerm: String!
    var volume: Volume!
    
    let base = "https://www.googleapis.com/books/v1/volumes?q="
    let googleAPIKey = "&key=AIzaSyA4uK_cz3fjD1ry39e5Fzy_nQtgRWR9AgA" // for tracking requests
    init(_ value: String) {
        self.searchTerm = value
    }
    init(_ volume: Volume) {
        self.volume = volume
    }
    var volumeUrl: URL? {
        return URL(string: base + searchTerm + googleAPIKey)
    }
}
