//
//  NutItem.swift
//  Nutter
//
//  Created by Shawon Ashraf on 23.04.20.
//  Copyright © 2020 Shawon Ashraf. All rights reserved.
//

import Foundation
import CoreData

public class NutItem: NSManagedObject, Identifiable {
    @NSManaged public var createdAt: Date?
}

extension NutItem {
    static func getAllNuts() -> NSFetchRequest<NutItem> {
        let req = NutItem.fetchRequest() as! NSFetchRequest<NutItem>
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        req.sortDescriptors = [sortDescriptor]
        
        return req
    }
}
