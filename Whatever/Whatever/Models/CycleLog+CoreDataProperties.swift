//
//  CycleLog+CoreDataProperties.swift
//  Whatever
//
//  Created by sei on 2023/06/11.
//
//

import Foundation
import CoreData


extension CycleLog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CycleLog> {
        return NSFetchRequest<CycleLog>(entityName: "CycleLog")
    }

    @NSManaged public var flowLevel: Int64
    @NSManaged public var padType: Int64
    @NSManaged public var timestamp: Date?

}

extension CycleLog : Identifiable {

}
