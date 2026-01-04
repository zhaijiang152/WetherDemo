//
//  CityEntity+CoreDataProperties.swift
//  
//
//  Created by gaoang on 2025/3/25.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var tem: String?
    @NSManaged public var temRange: String?
    @NSManaged public var weather: String?
    @NSManaged public var backIden: String?
    @NSManaged public var now: Data?
    @NSManaged public var future: Data?
    @NSManaged public var today: Data?

}
