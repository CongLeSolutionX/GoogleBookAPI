//
//  ViewModel.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import Foundation



class ViewModel{
    
    
    var currentVolume: Volume!
    
    var volumes = [Volume]() {
        didSet{
            NotificationCenter.default.post(name: Notification.Name.VolumeId, object: nil)
        }
    }
 
    
}


extension ViewModel {
    func getVolumes(_ search: String) {
        volumeServiceShared.getVolumes(for: search){ [weak self] result in
            self?.volumes = result
            print("Volume Counts: \(result.count)")
            
        }
    }
    
 
}