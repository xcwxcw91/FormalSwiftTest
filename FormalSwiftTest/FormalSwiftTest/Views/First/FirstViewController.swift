//
//  FirstViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

/*
 创建observer的方式：
 1.基础的 Observable.create/Observable.of/ Observable.from
 2.使用 PublishSubject/BehaviorSubject/ReplaySubject/Variable(间接)
 3.RxCocoa 封装了UI控件的创建Observable的方法，比如button.rx.tap/ textfield.rx.text
 ...
 observer订阅的方式：
 1.subcribe{
 
    event in
    print(event.element)
 }
 2.subscribe(
 onNext{
    element in
 print(element)
 },
 onCompleted{
 
 },
 onError{
    error in
    print(error)
 },
 onDisposed{
 
 }
 
 observer发送event的方式
 1.observer.onNext(element) /onError(error)/onCompleted()/onDisposed()
 2.使用variable等的值变化
 )
 
 **/

class FirstViewController: UIViewController {
 
    //Variable本身不是Observable，但是其私有对象 subject是，使用todoItems.asObservable获取到obsevable，订阅
    let todoItems = Variable<[ToDoItem]>([])//Variable需要赋初值，此处初值为[]
    let bag = DisposeBag()
    
    weak var tableView : UITableView!
    weak var addToDoBarBtn : UIBarButtonItem!
    weak var clearToDoBtn : UIButton!
    weak var uploadToCloud : UIButton!
    weak var saveToLocal : UIButton!
    
    

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .white
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight-200), style: .plain)
        self.tableView = tableView
        self.view.addSubview(tableView)
        
        let addToDo = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addToDoItem))
        self.navigationItem.rightBarButtonItem = addToDo
        self.addToDoBarBtn = addToDo
        
        let clear = UIButton.init(frame: CGRect(x: 20, y: tableView.frame.maxY + 20, width: 50, height: 50))
        clear.setImage(UIImage(named: "Delete"), for: .normal)
        clear.addTarget(self, action: #selector(clearToDoItems), for: .touchUpInside)
        self.view.addSubview(clear)
        self.clearToDoBtn = clear
        
        let upload = UIButton.init(frame: CGRect(x: 150, y: tableView.frame.maxY + 20, width: 50, height: 50))
        upload.setImage(UIImage(named: "Sync"), for: .normal)
//        upload.addTarget(self, action: #selector(syncToCloud), for: .touchUpInside)
        self.view.addSubview(upload)
        self.uploadToCloud = upload
        
        let save = UIButton.init(frame: CGRect(x: 250, y: tableView.frame.maxY + 20, width: 50, height: 50))
        save.setImage(UIImage(named: "Save"), for: .normal)
        save.addTarget(self, action:#selector(saveTodoList), for: .touchUpInside)
        self.view.addSubview(save)
        self.saveToLocal = save
    }
    
    func updateUI(todos: [ToDoItem]){
        
        self.clearToDoBtn.isEnabled = !todos.isEmpty
        self.addToDoBarBtn.isEnabled = todos.filter { !$0.isFinished }.count < 5
        title = todos.isEmpty ? "ToDos" : "\(todos.count) ToDos"
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "ToDoItemTableViewCell")
        
        self.todoItems.asObservable().subscribe(
            
            onNext:{
                
                [weak self] todos in
                
                self?.updateUI(todos: todos)
            
        }).disposed(by: bag)
        
        loadTodoItems()
    }

    
    @objc func addToDoItem (){
        
//        let todoItem = ToDoItem(name: "todoItem", isFinished: false)
//
//        self.todoItems.value.append(todoItem)
        let add = AddToDoViewController()
        self.navigationController?.pushViewController(add, animated: true)
        
        _ = add.todo.subscribe(
            onNext: {
            
                [weak self] newTodo in
                
                self?.todoItems.value.append(newTodo)
                
        },
            onDisposed: {
                
                print("finished adding a new item")
        })
    }
    
    @objc func clearToDoItems(){
        
        self.todoItems.value.removeAll()
    }
}

extension FirstViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todo = self.todoItems.value[indexPath.row]
        
        let add = AddToDoViewController()
        add.todoItem = todo
        self.navigationController?.pushViewController(add, animated: true)
        _ = add.todo.subscribe(
            onNext: {
                
                [weak self] revisedTodo in
                self?.todoItems.value[indexPath.row] = revisedTodo
            },
            onDisposed: {
                
                print("finished revising a new item")
        })
        
//        todo.isFinished = !todo.isFinished
//        self.todoItems.value[indexPath.row] = todo
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.todoItems.value.remove(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension FirstViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.todoItems.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemTableViewCell", for: indexPath) as! ToDoItemTableViewCell
        
        let todo = self.todoItems.value[indexPath.row]
        
        cell.todo = todo
        
        return cell
    }
    
}


extension FirstViewController{
    
//create observables test 创建observable的操作符
    
//1.create  使用一个函数闭包创建一个observable
    
    //1.带泛型的observable
    func create()-> Observable<Int>{
        
        return Observable.create { (observer) -> Disposable in
            
            observer.onNext(1)
            observer.onError(SaveTodoError.cannotCreateFileOnCloud)
            observer.onCompleted()
            
            //或者如下写法
            observer.on(.next(1))
            observer.on(.error(SaveTodoError.cannotCreateFileOnCloud))
            observer.on(.completed)
            
            return Disposables.create()
        }
    }
    //2.无泛型的observable Void类型对应值为()
    func createVoid() -> Observable<Void>{
        
        return Observable.create({ (observer) -> Disposable in
            
            observer.onNext(())
            observer.onError(SaveTodoError.cannotCreateFileOnCloud)
            observer.onCompleted()
            
            //或者如下写法
            observer.on(.next(()))
            observer.on(.error(SaveTodoError.cannotCreateFileOnCloud))
            observer.on(.completed)
            
            return Disposables.create()
        })
    }
    
//2.never 创建一个不发送任何数据的observable
    
    func never() -> Observable<Void>{
        
        return Observable.never()
    }

//3.empty 只发送completed事件的observable
    func empty() -> Observable<Void> {
        
        return Observable.empty()
    }
    
//4.just 创建 Observable 发出唯一的一个元素，just只包含一个元素的序列，先发送 next(value)，然后发送.complete
    
    func just() -> Observable<Int>{
        
        return Observable.just(1)
    }
    
    func messaground(){
        
        
    }
    
    
    

    
    
    
    
    
    func observablesTest (){
        
        _ = self.empty().subscribe { (event) in
            
            if event.isStopEvent{
             
            }
        }
    }
}
