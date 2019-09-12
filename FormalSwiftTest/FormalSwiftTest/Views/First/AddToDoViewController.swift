//
//  AddToDoViewController.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/12.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    fileprivate let todoSubject = PublishSubject<ToDoItem>()
    var todo:Observable<ToDoItem>{
        return  todoSubject.asObserver()
    }
    
    var todoItem : ToDoItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let todoItem = todoItem {
            
        }
        else{
            
            todoItem = ToDoItem()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
