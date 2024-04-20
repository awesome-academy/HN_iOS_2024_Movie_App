//
//  CoreDataManager.swift
//  MovieHub
//
//  Created by nguyen.van.duyb on 4/16/24.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    private init() {}
    
    func save<T: NSManagedObject>(object: T, completion: @escaping(Result<Void, Error>) -> Void) {
        let context = persistentContainer.viewContext
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete<T: NSManagedObject>(object: T, completion: @escaping(Result<Void, Error>) -> Void) {
        let context = persistentContainer.viewContext
        context.delete(object)
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>, completion: @escaping(Result<[T], Error>) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let fetchedData = try context.fetch(request)
            completion(.success(fetchedData))
        } catch {
            completion(.failure(error))
            
        }
    }
    
    func isObjectExists<T: NSManagedObject>(request: NSFetchRequest<T>) -> Bool {
        let context = persistentContainer.viewContext
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Error checking if object exists: \(error)")
            return false
        }
    }
    
    func getPersistentContainer() -> NSPersistentContainer {
        return persistentContainer
    }
}
