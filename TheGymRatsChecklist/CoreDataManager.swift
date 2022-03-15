//
//  CoreDataManager.swift
//  TheGymRatsChecklist
//
//  Created by Abdullah Ridwan on 3/14/22.
//

import Foundation
import CoreData



class CoreDataManager{
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoAppModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize CD Stack \(error)")
            }
        }
    }
    
    //Helper Functions
    
//    func getToDoByID(tid: NSManagedObjectID) -> ToDoItem? {
//        do{
//            return try viewContext.existingObject(with: tid) as? ToDoItem
//        } catch {
//            return nil
//        }
//    }
    
    //Main Functions
    func save(){
        do{
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
    
    
    func getAllDates() -> [ToDoItem]{
        //make a request
        let request = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
        //execute request
        do{
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    
    func updateToDo(t: ToDoItem){
        //update the ToDoItem based on its nsmanagedobjectid
        //save view context
        save()
    }
    func deleteToDo(t: ToDoItem){
        viewContext.delete(t)
        save()
    }
}
