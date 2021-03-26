//
//  StorageService.swift
//  TranslatorApp
//
//  Created by Alexey Kirpichnikov on 2021/3/20.
//

import UIKit
import CoreData

protocol StorageServiceProtocol {
    func add(translation: Translation)
    func getWordsFromDB() -> [Translation]?
    func deleteAllTheWordsFromDB()
    func fetchWords(by key: String) -> [Translation]?
}

class StorageService: StorageServiceProtocol {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext!
    
    init() {
        context = appDelegate.persistentContainer.viewContext
    }
    
    func add(translation: Translation) {
        guard let entity = NSEntityDescription.entity(forEntityName: CoreData.enityName, in: context) else {
            return
        }
        
        let newTranslation = NSManagedObject(entity: entity, insertInto: context)
        newTranslation.setValue(translation.input, forKey: CoreData.inputKey)
        newTranslation.setValue(translation.translation, forKey: CoreData.translationKey)
        
        appDelegate.saveContext()
    }
    
    func getWordsFromDB() -> [Translation]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreData.enityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject],
                  result.count > 0 else {
                return nil
            }
            
            var words = [Translation]()
            result.forEach { x in
                guard let input = x.value(forKey: CoreData.inputKey) as? String else {
                    return
                }
                
                guard let translation = x.value(forKey: CoreData.translationKey) as? String else {
                    return
                }
                
                words.append(Translation(input: input, translation: translation))
            }
            return words
        } catch {
            return nil
        }
    }
    
    func deleteAllTheWordsFromDB() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreData.enityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Ошибка при удалении")
        }
    }
    
    func fetchWords(by key: String) -> [Translation]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreData.enityName)
        
        fetchRequest.predicate = NSPredicate(format: "input CONTAINS[cd] %@ OR translation CONTAINS[cd] %@", key, key)
        
        do {
            
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject],
                  result.count > 0 else {
                return nil
            }
            
            var words = [Translation]()
            result.forEach { x in
                guard let input = x.value(forKey: CoreData.inputKey) as? String else {
                    return
                }
                
                guard let translation = x.value(forKey: CoreData.translationKey) as? String else {
                    return
                }
                
                words.append(Translation(input: input, translation: translation))
            }
            return words
            
        } catch {
            return nil
        }
    }
    
}
