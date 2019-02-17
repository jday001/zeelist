//
//  ListItem.swift
//  ZeeList
//
//  Created by Jeff Day on 2/16/19.
//  Copyright © 2019 JDay Apps, LLC. All rights reserved.
//

import UIKit
import CoreLocation


struct ListItem: Equatable {
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    let quantity: Int
    var photo: UIImage?
    var location: CLLocationCoordinate2D?
}
