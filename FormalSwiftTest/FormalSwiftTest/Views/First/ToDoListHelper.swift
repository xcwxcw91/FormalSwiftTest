//
//  ToDoListHelper.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/16.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

enum SaveTodoError: Error {
    case cannotSaveToLocalFile
    case iCloudIsNotEnabled
    case cannotReadLocalFile
    case cannotCreateFileOnCloud
}

extension FirstViewController {
    
    func documentsDirectory() -> URL {
        let path = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        
        return path[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("TodoList.plist")
    }
    
    func ubiquityURL(_ filename: String) -> URL? {
        let ubiquityURL =
            FileManager.default.url(forUbiquityContainerIdentifier: nil)
        
        if ubiquityURL != nil {
            return ubiquityURL!.appendingPathComponent(filename)
        }
        
        return nil
    }
    
   func syncTodoToCloud() -> Observable<URL> {
        
        return Observable.create({ observer in
            guard let cloudUrl = self.ubiquityURL("Documents/TodoList.plist") else {
                observer.onError(SaveTodoError.iCloudIsNotEnabled)
                return Disposables.create()
            }
            
            guard let localData = NSData(contentsOf: self.dataFilePath()) else {
                observer.onError(SaveTodoError.cannotReadLocalFile)
                return Disposables.create()
            }
            
            let plist = PlistDocument(fileURL: cloudUrl, data: localData)
            
            plist.save(to: cloudUrl, for: .forOverwriting, completionHandler: {
                (success: Bool) -> Void in
                
                if success {
                    observer.onNext(cloudUrl)
                    observer.onCompleted()
                } else {
                    observer.onError(SaveTodoError.cannotCreateFileOnCloud)
                }
            })
            
            return Disposables.create()
        })
    }
    
//    @objc func syncToCloud(){
//
//        _ = syncTodoToCloud().subscribe(
////            onNext: {
//
////                self.flash(title: "Success",
////                           message: "All todos are synced to: \($0)")
////        },
//            onError: {
////                self.flash(title: "Failed",
////                           message: "Sync failed due to: \($0.localizedDescription)")
//        },
//            onDisposed: {
//                print("SyncOb disposed")
//        }
//        )
//
////        print("RC: \(RxSwift.Resources.total)")
//    }
    
    @objc func saveTodoList (){
    
        _ = saveTodoItems().subscribe(
        
            onNext:{

                [weak self] element in

                print(element)
        },
            onError: {
                
                [weak self] error in
                print(error)
//                self?.flash(title: "Success",
//                            message: error.localizedDescription)
            },
            onCompleted: { [weak self] in
                print("complete")
//                self?.flash(title: "Success",
//                            message: "All Todos are saved on your phone.")
            },
            onDisposed: { print("SaveOb disposed") }
        )
        
//        print("RC: \(RxSwift.Resources.total)")
    }
    
    
    func saveTodoItems() -> Observable<Void> {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(todoItems.value, forKey: "TodoItems")
        archiver.finishEncoding()
        
        return Observable.create({ observer in
            
            let result = data.write(
                to: self.dataFilePath(), atomically: true)
            
            if !result {
                observer.onError(SaveTodoError.cannotSaveToLocalFile)
            }
            else {
                print("save to local completed")
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
    }
    
    func loadTodoItems() {
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            todoItems.value = unarchiver.decodeObject(forKey: "TodoItems") as! [ToDoItem]
            
            unarchiver.finishDecoding()
            print("load local data succeed")
        }
    }
}


class PlistDocument: UIDocument {
    var plistData: NSData!
    
    init(fileURL: URL, data: NSData) {
        super.init(fileURL: fileURL)
        
        self.plistData = data
    }
    
    override func contents(forType typeName: String) throws -> Any {
        return plistData
    }
    
    override func load(fromContents contents: Any,
                       ofType typeName: String?) throws {
        if let userContent = contents as? NSData {
            plistData = userContent
        }
    }
}

