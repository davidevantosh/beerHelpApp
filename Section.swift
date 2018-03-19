//
//  Section.swift
//  beerhelp
//
//  Created by David Tosh on 30/08/17.
//  Copyright © 2017 David Tosh. All rights reserved.
//

import Foundation

struct Section {
    var type: String!
    var item: [String]!
    var expanded: Bool!
    
    init(type: String, item: [String], expanded: Bool) {
        self.type = type
        self.item = item
        self.expanded = expanded
    }
}
