//
//  CoreDataStack.swift
//  BifocalPrototype3
//
//  Created by Henry Lightfoot on 16/09/2025.
//
import CoreData
import Foundation

class CoreDataStack: ObservableObject {
    static let shared = CoreDataStack()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to retrieve a persistent store description.")
        }
        
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        
        guard let storeURL = description.url else {
            fatalError("Failed to load persistent store URL.")
        }
        
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: storeURL.path) {
                    if let preloadedURL = Bundle.main.url(forResource: "Model", withExtension: "sqlite") {
                        let shmURL = preloadedURL.deletingPathExtension().appendingPathExtension("sqlite-shm")
                        let walURL = preloadedURL.deletingPathExtension().appendingPathExtension("sqlite-wal")
                        
                        do {
                            try fileManager.copyItem(at: preloadedURL, to: storeURL)
                            try fileManager.copyItem(at: shmURL, to: storeURL.deletingPathExtension().appendingPathExtension("sqlite-shm"))
                            try fileManager.copyItem(at: walURL, to: storeURL.deletingPathExtension().appendingPathExtension("sqlite-wal"))
                            print("success")
                        } catch {
                            print("error")
                        }
                    }
                }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        
        return container
    } ()
    
    init() { }
    
    func save() {
            guard persistentContainer.viewContext.hasChanges else { return }
            
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("Failed to save the context:", error.localizedDescription)
            }
        }
}
