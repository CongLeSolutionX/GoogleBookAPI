//
//  HomeTableViewCell.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listMainLabel: UILabel!
    @IBOutlet weak var listSubLabel: UILabel!
    
    // Table view cells are reused and should be dequeued using a cell identifier.
    static let identifier = "HomeTableViewCell"

    var volume: Volume! {
        didSet{
            listMainLabel.text = volume.bookInfo.title
            listSubLabel.text = volume.bookInfo.authors.first
            
            guard let url = URL(string: volume.bookInfo.imageLinks.thumbnail ?? "No image URL for this Volume") else {return}
            url.downloadImage{ [weak self] result in
                self?.listImage.image = result
            }
        }
    }
    
    
}
