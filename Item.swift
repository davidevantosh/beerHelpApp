//
//  Item.swift
//  beerhelp
//
//  Created by David Tosh on 20/09/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
}

@NSManaged public var ingredientName: String?
@NSManaged public var type: String?

}

