//
//  AddToDoViewController.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/12.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    //MARK: - Properties
    fileprivate let todoSubject = PublishSubject<ToDoItem>()
    fileprivate let bag = DisposeBag()
    var todo:Observable<ToDoItem>{
        return todoSubject.asObserver()
    }
    
    var todoItem : ToDoItem!
    
    let nameTf : UITextField = {
      
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    let switcher : UISwitch = {
       
        let switcher = UISwitch()
        return switcher
    }()
    
    //MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.nameTf)
        self.view.addSubview(self.switcher)
        
        self.nameTf.frame = CGRect(x: 20, y: 80, width: 100, height: 40);
        self.switcher.frame = CGRect(x: self.nameTf.frame.maxX + 10, y: self.nameTf.frame.minY, width: 100 , height: 40)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if todoItem != nil {
            
            self.nameTf.text = todoItem.name
            self.switcher.isOn = todoItem.isFinished
        }
        else{
            
            todoItem = ToDoItem()
        }
        self.nameTf.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        todoSubject.onCompleted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        let nameValid = self.nameTf.rx.text.orEmpty.asObservable().map{$0.count > 0}.share(replay:1)
            
        nameValid.bind(to: self.navigationItem.rightBarButtonItem!.rx.isEnabled).disposed(by: bag)
    }
    
    //MARK: - Actions
    @objc func doneAction(){
        
        todoItem.name = self.nameTf.text!
        todoItem.isFinished = self.switcher.isOn
        
        todoSubject.onNext(todoItem)
        self.navigationController?.popViewController(animated: true)
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
