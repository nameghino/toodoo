//
//  ToDoItem.swift
//  TooDooApp
//
//  Created by Nicolas Ameghino on 9/6/14.
//  Copyright (c) 2014 Nicolas Ameghino. All rights reserved.
//

import Foundation
import CoreData

class ToDoItem: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var createdOn: NSDate
    @NSManaged var dueDate: NSDate
    @NSManaged var list: ToDoList

}
