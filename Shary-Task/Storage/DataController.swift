//
//  DataController.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 09/11/2021.
//

import Foundation
import CoreData

class DataController{
    
    private init() {
        persistentContainer = NSPersistentContainer(name:"Shary_Task")
        load()
    }
    
    class func sharedInstance()->DataController{
        struct Singleton{
            static var shared = DataController()
        }
        return Singleton.shared
    }
    
    let persistentContainer : NSPersistentContainer
    
    //Create an object context to deal with attributes
    var viewContext : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    //Intialize a persistent container with our data model name
    
    //Load data from persistent store
    func load(completion:(()->Void)?=nil){
        persistentContainer.loadPersistentStores(){(storeDescription,error) in
            guard error == nil else{
                print("There is error with loading data:\(String(describing: error?.localizedDescription))")
                return
            }
            completion?()
        }
    }
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Someting went wrong saving data:")
            }
        }
    }
    
    
    
    func saveProduct(product:Product,imageData:Data){
        let productEntity = ProductEntity(context: viewContext)
        productEntity.id = Int32((product.id ?? 0))
        productEntity.title = product.title
        productEntity.price = product.price ?? 0.0
        productEntity.category = product.category
        productEntity.rating = product.rating?.rate ?? 0.0
        productEntity.count = Int32((product.rating?.count ?? 0))
        productEntity.desc = product.description
        productEntity.image = imageData
        
        saveContext()
    }
    
    func deleteProducts(){
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = ProductEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(batchDeleteRequest)
        } catch {
            print("Someting went wrong saving data:")
        }
    }
    
    
}
