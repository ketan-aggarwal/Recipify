//
//  SavedRecipe+CoreDataProperties.swift
//  
//
//  Created by Ketan Aggarwal on 13/02/24.
//
//

import Foundation
import CoreData


extension SavedRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedRecipe> {
        return NSFetchRequest<SavedRecipe>(entityName: "SavedRecipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var calories: Int16
    @NSManaged public var image: String?
    @NSManaged public var id: Int64
    @NSManaged public var prepTime: String?

}
