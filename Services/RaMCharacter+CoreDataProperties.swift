//
//  RaMCharacter+CoreDataProperties.swift
//  
//
//  Created by MacBook Pro on 10.07.2023.
//
//

import Foundation
import CoreData


extension RaMCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RaMCharacter> {
        return NSFetchRequest<RaMCharacter>(entityName: "RaMCharacter")
    }

    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var gender: String?
    @NSManaged public var location: String?
    @NSManaged public var image: String?

}
