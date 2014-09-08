//
//  ToDoList.swift
//  TooDooApp
//
//  Created by Nicolas Ameghino on 9/6/14.
//  Copyright (c) 2014 Nicolas Ameghino. All rights reserved.
//

import Foundation
import CoreData

class ToDoList: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var items: NSOrderedSet

}
