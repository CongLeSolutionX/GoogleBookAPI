//
//  ListViewController.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    var viewModel: ViewModel! //dependency injection 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
       
    }
    private func setupList() {
        NotificationCenter.default.addObserver(forName: Notification.Name.VolumeId, object: nil, queue: .main) { [weak self] _ in
            self?.listTableView.reloadData()
            
        }
        listTableView.tableFooterView = UIView(frame: .zero)
    }
    
}

// MARK: Additional Functionality

extension ListViewController: UITableViewDataSource {
    // number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.volumes.count
        
    }
 
    // configure a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // downcast the returned object from the UITableViewCell class to an optional HomeTableViewCell object
       // safely unwrap the optional object
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath)
            as? HomeTableViewCell else {
                fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }
        // fetching the Volume data
        let volume = viewModel.volumes[indexPath.row]
        cell.volume = volume
        
        return cell
    }

}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentVolume = viewModel.volumes[indexPath.row]
        viewModel.currentVolume = currentVolume
        goToDetail(with: viewModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 80
      }
}
