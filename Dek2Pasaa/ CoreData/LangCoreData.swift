//
//  LangCoreData.swift
//  Dek2Pasaa
//
//  Created by Android on 7/4/2562 BE.
//  Copyright © 2562 MelonDev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LangCoreData {
    
    private var appDelegate :AppDelegate? = nil
    private var managedContext :NSManagedObjectContext? = nil
    private var langEntity :NSEntityDescription? = nil
    private let entityName :String = "Config"
    
    enum Language {
        case Thai
        case English
    }
    
    init() {
        guard let appDelegates = UIApplication.shared.delegate as? AppDelegate else { return }
        self.appDelegate = appDelegates
        self.managedContext = self.appDelegate?.persistentContainer.viewContext
        self.langEntity = NSEntityDescription.entity(forEntityName: self.entityName, in: managedContext!)
    }
    
    
    /*func create() {
     
     
     }
     */
    
    
    func now() -> Language{
        if(count() == 0){
            create(lang: Language.Thai)
        }
        
        return read()!
    }
    
    func update(lang :Language) {
        if(count() == 0){
            create(lang: lang)
        }else {
            updateData(lang: lang)
        }
    }
    
    private func updateData(lang :Language) {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
        
        do {
            let array = try managedContext!.fetch(fetchRequest)
            
            let objectUpdate = array.first as! NSManagedObject
            objectUpdate.setValue(getStringLang(lang: lang), forKey: "lang")
            
            save()
        }
        catch {
            print(error)
        }
        
    }
    
    private func create(lang :Language) {
        let langs = NSManagedObject(entity: langEntity!, insertInto: self.managedContext!)
        langs.setValue(getStringLang(lang: lang), forKeyPath: "lang")
        
        save()
        
    }
    
    private func save(){
        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func getStringLang(lang :Language) -> String{
        if(lang == .Thai){
            return "Thai"
        } else {
            return "English"
        }
    }
    
    private func getLangFromString(str :String) -> Language {
        if(str.contains("Thai")){
            return Language.Thai
        }else {
            return Language.English
        }
    }
    
    private func read() -> Language?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let managedContext = self.managedContext
        
        do {
            let result = try managedContext!.fetch(fetchRequest)
            
            let datas = result.first as! NSManagedObject
            
            return getLangFromString(str: datas.value(forKey: "lang") as! String)
            
            /*for data in result as! [NSManagedObject] {
             print(data.value(forKey: "username") as! String)
             }
             */
            
        } catch {
            return nil
            //print("Failed")
        }
    }
    
    private func count() -> Int?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let managedContext = self.managedContext
        
        do {
            let result = try managedContext!.fetch(fetchRequest)
            
            return result.count
            
        } catch {
            
            return nil
        }
    }
    
}
