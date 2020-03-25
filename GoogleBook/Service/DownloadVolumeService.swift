//
//  BookService.swift
//  GoogleBook
//
//  Created by Consultant on 2/7/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import Foundation

typealias VolumeHandler = ([Volume]) -> Void

// making a singleton
let volumeServiceShared = DownloadVolumeService.shared

final class DownloadVolumeService {
    static let shared = DownloadVolumeService()
    private init() {}
    
    func getVolumes(for name: String, completion: @escaping VolumeHandler ) {
        guard let name = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)else {
            completion([])
            return
        }
        // get url for the book
        guard let url = GoogleBookAPI(name).volumeUrl else {
            completion([])
            return
        }
        
        //API request
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                print(error.localizedDescription)
                completion([])
                return
            }
            
            if let data = dat {
                do {
                    // Parse JSON into array of VolumeResponse struct using JSONDecoder
                    guard let response = try JSONDecoder().decode(VolumeResponse?.self, from: data) else {
                        print("Error: Couldn't decode data into Volume array")
                           return
                    }
                    completion(response.results)
                } catch {
                    print(error.localizedDescription)
                    completion([])
                    return
                }
            }
                        
        }.resume() // data task starts in  SUSPENDED state, MUST reusme for it to work
                
    }
}
