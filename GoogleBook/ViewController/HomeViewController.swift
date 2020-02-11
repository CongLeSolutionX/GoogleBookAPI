//
//  ViewController.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var listContainer: UIView!
    @IBOutlet weak var gridContainer: UIView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    let viewModel = ViewModel() //dependency injection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
    }
    
    
    
    @IBAction func segmentSwitched(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            listContainer.alpha = 1
            gridContainer.alpha = 0
        } else {
            listContainer.alpha = 0
            gridContainer.alpha = 1
        }
    }
    
    private func setupSearchBar () {
        navigationItem.title = "Google Books"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Type a title here..."
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController?.searchBar.delegate = self
        viewModel.getVolumes("Harry Potter") // a default search term
    }
    
    
    // pass view model to containers via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ListSegue"{
            let listVC = segue.destination as! ListViewController
            listVC.viewModel = viewModel
        } else if segue.identifier == "GridSegue" {
            let gridVC = segue.destination as! GridViewController
            gridVC.viewModel = viewModel
        }
        
    }
    
    
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        viewModel.getVolumes(search)
        
    }
    
}
