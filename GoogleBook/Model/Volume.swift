//
//  Book.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import Foundation
import CoreData

class VolumeResponse: Decodable {
    var results: [Volume]
    private enum CodingKeys: String, CodingKey {
        case results = "items"
    }
}

class Volume: Decodable {
    var id: String?
    var bookInfo: Book
    enum CodingKeys: String, CodingKey {
        case id
        case bookInfo = "volumeInfo"
    }
    init(coreBook: CoreBookStorage) {
        id = coreBook.id!
        bookInfo = Book(coreBook)
    }
}

class Book: Decodable {
    var title: String?
    var publisher: String?
    var publishedDate: String?
    var authors: [String]
    // var categories: [String]
    var pageCount: Int?
    // var previewLink: String?
    var description: String?
    var imageLinks: ImageLinks
    private enum CodingKeys: CodingKey {
        case title
        case publisher
        case publishedDate
        case authors
        //  case categories
        //  case previewLink
        case pageCount
        case description
        case imageLinks
    }
    init(_ coreBook: CoreBookStorage) {
        title = coreBook.title ?? "No title"
        authors = [coreBook.authors ?? "No authors"]
        description = coreBook.desc ?? "No desctiption"
        imageLinks = ImageLinks(coreBook)
    }
}
class ImageLinks: Decodable {
    var smallThumbnail: String?
    var thumbnail: String?
    init(_ coreBook: CoreBookStorage) {
        thumbnail = coreBook.imageUrl ?? "No image link"
    }
}
