//
//  ToDoItem-Human.swift
//  TooDooApp
//
//  Created by Nicolas Ameghino on 9/7/14.
//  Copyright (c) 2014 Nicolas Ameghino. All rights reserved.
//

import Foundation

extension ToDoItem: Printable {
    override var description: String {
        get {
            var s = ""
            s += "ToDo Item:\n"
            s += "\tContent:\n\t\t\(self.content)\n"
            s += "\tCreated on: \(self.createdOn)\n"
            s += "\tDue date: \(self.dueDate)\n"
            s += "\n"
            return s
        }
    }
}

extension ToDoItem {
    func play() {
        NSLog("fafafa")
    }
}

