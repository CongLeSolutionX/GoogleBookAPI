//
//  GridViewController.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    @IBOutlet weak var gridCollectionView: UICollectionView!
    
    var viewModel: ViewModel! //dependency injection 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGrid()

  
    }
    
    private func setupGrid() {
        NotificationCenter.default.addObserver(forName: Notification.Name.VolumeId, object: nil, queue: .main){ [weak self] _ in
            self?.gridCollectionView.reloadData()
        }
    }


}

//MARK: Additional functionality
extension GridViewController: UICollectionViewDataSource{
    
    // number of grid cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.volumes.count
    }

    // render each grid cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of HomeTableViewCell.")
        }
        // fetching the book data
        let volume = viewModel.volumes[indexPath.row]
        cell.volume = volume
        
        return cell
        
    }
    
}


extension GridViewController: UICollectionViewDelegateFlowLayout {
    //handle size of grid cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 143, height: 244)
    }
    
    //handles touch events
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentVolume = viewModel.volumes[indexPath.row]
        viewModel.currentVolume = currentVolume
        goToDetail(with: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
     }
    
}
