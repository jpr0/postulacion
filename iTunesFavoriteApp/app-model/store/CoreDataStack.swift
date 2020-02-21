//
//  CoreDataStack.swift
//  iTunesFavoriteApp
//
//  Created by Juan Pablo on 21-02-20.
//  Copyright © 2020 slacker. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    func saveContext() {
        guard managedContext.hasChanges else { return }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
