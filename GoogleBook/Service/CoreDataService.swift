//
//  CoreDataService.swift
//  GoogleBook
//
//  Created by Consultant on 2/10/20.
//  Copyright © 2020 Enhance IT. All rights reserved.
//

import Foundation
import CoreData

// making a singleton
let coreDataServiceShared = CoreDataService.shared

final class CoreDataService {
    static var shared = CoreDataService()
    private init() { }
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    //container to store core entities
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoogleBook")
        container.loadPersistentStores { (storeDescrip, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    // load all the volumes
    func loadVolume() -> [Volume] {
        let fetchingRequest = NSFetchRequest<CoreBookStorage>(entityName: "CoreBookStorage")
        var volumes = [Volume]()
        do {
            let coreVolumes = try context.fetch(fetchingRequest)
            coreVolumes.forEach({
                let coreVolume = Volume(coreBook: $0)
                volumes.append(coreVolume)
            })
        } catch {
            print(error.localizedDescription)
        }
        print("Volume Counts  \(volumes.count) ")
        return volumes
    }
    func saveVolume(_ volume: Volume) {
        let entity = NSEntityDescription.entity(forEntityName: "CoreBookStorage", in: context)!
        let coreBookStorage = CoreBookStorage(entity: entity, insertInto: context)
        coreBookStorage.id = volume.id
        coreBookStorage.title = volume.bookInfo.title
        coreBookStorage.authors = volume.bookInfo.authors[0]
        coreBookStorage.desc = volume.bookInfo.description
        coreBookStorage.imageUrl = volume.bookInfo.imageLinks.thumbnail
        saveContext() //persist the data
        print("just saved \(volume.bookInfo.title ?? "couldnt save book title")" )
    }
    // save all the data into CoreData
    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error in saving the context to CoreData")
        }
    }
    // remove volume in CoreData
    func removeVolume(_ volume: Volume) {
        //since we have saved the unique id, use that to delete
        let fetchingRequest = NSFetchRequest<CoreBookStorage>(entityName: "CoreBookStorage")
        let idPredicate = NSPredicate(format: "id==%@", volume.id ?? "no idPredicate when removing a volume")
        fetchingRequest.predicate = idPredicate
        do {
            //use the fetch request to get back volumes matching the predicate
            let coreVolumes = try context.fetch(fetchingRequest)
            if let coreVolume = coreVolumes.first {
                context.delete(coreVolume) //delete the core data object
                print("Deleted data from CoreData: \(String(describing: volume.bookInfo.title))")
            }
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: check for a volume
    func checkForVolume(_ volume: Volume) -> Bool {
        let fetchingRequest = NSFetchRequest<CoreBookStorage>(entityName: "CoreBookStorage")
        let idPredicate = NSPredicate(format: "id==%@", volume.id ?? "No idPredicate when checking for a volume ")
        fetchingRequest.predicate = idPredicate
        do {
            let coreVolumes = try context.fetch(fetchingRequest)
            if coreVolumes.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
