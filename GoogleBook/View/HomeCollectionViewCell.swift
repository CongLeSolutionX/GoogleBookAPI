//
//  HomeCollectionViewCell.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gridImage: UIImageView!
    @IBOutlet weak var gridAuthorLabel: UILabel!
    @IBOutlet weak var gridDateLabel: UILabel!
    static let identifier = "HomeCollectionViewCell"
    var volume: Volume! {
        didSet {
            gridAuthorLabel.text = volume.bookInfo.authors.first ?? "No author"
            gridDateLabel.text = volume.bookInfo.publishedDate
            guard let url = URL(string: volume.bookInfo.imageLinks.thumbnail ?? "No image URL for this volume") else { return }
            url.downloadImage { [weak self] result in
                self?.gridImage.image = result
            }
        }
    }
}
