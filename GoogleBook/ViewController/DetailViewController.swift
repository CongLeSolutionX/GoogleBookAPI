//
//  DetailViewController.swift
//  GoogleBook
//
//  Created by Consultant on 2/9/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTabelView: UITableView!
    var favoriteSignal = false
    
    var viewModel: ViewModel! // dependency injection
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailView()
        setupFavoriteButton()
    }
    
    private func setupDetailView() {
        detailTabelView.dataSource = self as UITableViewDataSource
        // detailTabelView.delegate = self as? UITableViewDelegate
        // viewModel.delegate = self
        detailTabelView.tableFooterView = UIView(frame: .zero)
    }
    
    func setupFavoriteButton(){
        let addToMyFavorite = UIBarButtonItem(title: "Add to favorite",
                                              style: .plain,
                                              target: self,
                                              action: #selector(addToFavoriteTapped))
        navigationItem.rightBarButtonItems = [addToMyFavorite]
        
    }
    
    @objc func addToFavoriteTapped(){
        // save into CoreData
        // open the list of current favorite books
   
    }
    
    
    
    
    
    
}



//MARK: Additonal functionality
extension DetailViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // safely unwrap the optional object
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableCell.identifier, for: indexPath)
            as? DetailTableCell else {
                fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }
        
        // fetching the Volume data
        cell.volume = viewModel.currentVolume
        return cell
        
    }
}

