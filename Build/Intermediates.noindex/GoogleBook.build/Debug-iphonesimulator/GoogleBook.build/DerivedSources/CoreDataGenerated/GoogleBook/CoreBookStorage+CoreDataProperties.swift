//
//  CoreBookStorage+CoreDataProperties.swift
//  
//
//  Created by Cong Le on 3/9/20.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension CoreBookStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreBookStorage> {
        return NSFetchRequest<CoreBookStorage>(entityName: "CoreBookStorage")
    }

    @NSManaged public var authors: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?

}
