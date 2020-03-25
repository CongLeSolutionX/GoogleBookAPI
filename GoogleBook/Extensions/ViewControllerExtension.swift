//
//  ViewControllerExtension.swift
//  GoogleBook
//
//  Created by Consultant on 2/9/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import UIKit

extension UIViewController {
    func goToDetail(with vm: ViewModel) {
        // swiftlint:disable:next force_cast
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.viewModel = vm
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
