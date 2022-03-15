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
        persistentContainer = NSPersistentContainer(name: "Database")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize CD Stack \(error)")
            }
        }
    }
    
    
    func getToDoByID(tid: NSManagedObjectID) -> InfoModel? {
        do{
            return try viewContext.existingObject(with: tid) as? InfoModel
        } catch {
            return nil
        }
    }
    
    //Main Functionst
    func save(){
        do{
            try viewContext.save()
        } catch {
            viewContext.rollback()
        }
    }
    
    
    func getAllDates() -> [InfoModel]{
        //make a request
        let request = NSFetchRequest<InfoModel>(entityName: "InfoModel")
        //execute request
        do{
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    func updateToDo(t: InfoModel ){
        save()
    }
    
    func deleteToDo(t: InfoModel){
        viewContext.delete(t)
        save()
    }
}
