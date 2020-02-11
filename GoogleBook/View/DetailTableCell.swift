//
//  DetailTableCell.swift
//  GoogleBook
//
//  Created by Consultant on 2/9/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

class DetailTableCell: UITableViewCell {


    @IBOutlet weak var detailBookImage: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailAuthorsLabel: UILabel!
    @IBOutlet weak var detailPublishedDateLabel: UILabel!
    @IBOutlet weak var detailPublisherLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    static let identifier = "DetailTableCell"
    
    var volume: Volume! {
        didSet {
            detailTitleLabel.text = volume.bookInfo.title
            detailAuthorsLabel.text = volume.bookInfo.authors.joined(separator: ",")
            detailPublishedDateLabel.text = volume.bookInfo.publishedDate
            detailPublisherLabel.text = volume.bookInfo.publisher
            // need to fix this
            detailDescriptionLabel.text = volume.bookInfo.description ?? " This book does not contain a description!"
            guard let url = URL(string: volume.bookInfo.imageLinks.thumbnail ?? "No image URL for this volume") else { return }
            url.downloadImage { image in
                self.detailBookImage.image = image
            }
        }
    }
  
    
}
