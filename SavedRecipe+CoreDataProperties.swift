//
//  SavedRecipe+CoreDataProperties.swift
//  
//
//  Created by Ketan Aggarwal on 04/03/24.
//
//

import Foundation
import CoreData


extension SavedRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedRecipe> {
        return NSFetchRequest<SavedRecipe>(entityName: "SavedRecipe")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var calories: Int64
    @NSManaged public var image: String?
    @NSManaged public var prepTime: Int64

}
