//
//  ModelHandeller.swift
//  RealmTest
//
//  Created by Sushant on 12/13/16.
//  Copyright © 2016 Sushant. All rights reserved.
//

import UIKit
import RealmSwift
class ModelHandeller: NSObject {
    static var sharedModelHandeller = ModelHandeller();
     var realm: Realm!
    func getSortedToDos()->Results<ToDo>{
           self.realm = try! Realm()
            let unsortedObjects = realm.objects(ToDo.self)
            let sortedObjects = unsortedObjects.sorted(byProperty: "date", ascending: true)
            return sortedObjects ;
    }
    func updateToDo(todoObj:ToDo, newTitle:String, newDate:Date){
        try! realm.write {
            todoObj.date = newDate;
            todoObj.title = newTitle;
        }
      }
    func addToDo(title:String, date:Date){
        try! realm.write {
        let todoObj = self.realm.create(ToDo.self);
            todoObj.title = title;
            todoObj.date = date;
        }
    }
    func deleteToDo(todoObj:ToDo){
        try! realm.write {
            realm.delete(todoObj)
        }
    }
}
