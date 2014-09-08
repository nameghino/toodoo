//
//  ListsTableViewController.swift
//  TooDooApp
//
//  Created by Nicolas Ameghino on 9/7/14.
//  Copyright (c) 2014 Nicolas Ameghino. All rights reserved.
//

import UIKit
import CoreData

class ListsTableViewController: UITableViewController {
    let moc: NSManagedObjectContext
    lazy var selectedList: ToDoList = {
        let entity = NSEntityDescription.entityForName("ToDoList", inManagedObjectContext: self.moc)
        let request = NSFetchRequest()
        request.entity = entity
        var errorPointer: NSError?
        let result = self.moc.executeFetchRequest(request, error: &errorPointer)
        if let error = errorPointer {
            NSLog("Error fetching entity: \(error.localizedDescription)")
        }
        
        if let resultArray = result {
            if  resultArray.count > 0 {
                return resultArray.first as ToDoList
            }
        }
        
        let list = NSEntityDescription.insertNewObjectForEntityForName("ToDoList", inManagedObjectContext: self.moc) as ToDoList
        list.name = "test list"
        self.moc.save(&errorPointer)
        if let error = errorPointer {
            NSLog("Error inserting entity: \(error.localizedDescription)")
        }
        return list
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        moc = ((UIApplication.sharedApplication().delegate as AppDelegate?)?.managedObjectContext)!
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        moc = ((UIApplication.sharedApplication().delegate as AppDelegate?)?.managedObjectContext)!
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "ItemCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addItem:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func addItem(sender: AnyObject) {
        let item = NSEntityDescription.insertNewObjectForEntityForName("ToDoItem", inManagedObjectContext: self.moc) as ToDoItem
        item.content = "Inserted item \(unsafeBitCast(item, Int.self))"
        let days = Double(arc4random()) / Double(UInt32.max) * 1.0 / 24.0
        item.dueDate = NSDate(timeIntervalSinceNow: 86400 * days)
        item.createdOn = NSDate()
        item.list = self.selectedList
        
        var errorPointer: NSError?
        self.moc.save(&errorPointer)
        if let error = errorPointer {
            NSLog("error saving item: \(error.localizedDescription)")
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Helpers
    func colorForItem(item: ToDoItem) -> UIColor {
        let lifespan = item.dueDate.timeIntervalSince1970 - item.createdOn.timeIntervalSince1970
        let elapsed = NSDate().timeIntervalSinceDate(item.createdOn)
        let red = CGFloat(elapsed/lifespan) * 25.0
        let color = UIColor(red: red, green: 0, blue: 0, alpha: 1)
        return color
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedList.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as UITableViewCell
        let item = self.selectedList.items[indexPath.row] as ToDoItem
        cell.textLabel?.text = item.content
        cell.textLabel?.textColor = self.colorForItem(item)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = self.selectedList.items[indexPath.row] as ToDoItem
        NSLog("\(item.description)")
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "\(self.selectedList.items.count) items on your list"
    }
}
