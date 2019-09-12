//
//  FirstViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
 
    let todoItems = Variable<[ToDoItem]>([])
    let bag = DisposeBag()
    
    weak var tableView : UITableView!
    weak var addToDoBarBtn : UIBarButtonItem!
    weak var clearToDoBtn : UIButton!
    
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
    }
    
    func updateUI(todos: [ToDoItem]){
        
        self.clearToDoBtn.isEnabled = !todos.isEmpty
        self.addToDoBarBtn.isEnabled = todos.filter {!$0.isFinished }.count < 5
        title = todos.isEmpty ? "ToDos" : "\(todos.count) toDos"
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ToDoItemTableViewCell.self, forCellReuseIdentifier: "ToDoItemTableViewCell")
        
        self.todoItems.asObservable().subscribe(onNext:{ [weak self] todos in
            
            self?.updateUI(todos: todos)
            
        }).disposed(by: bag)
    }

    //
    @objc func addToDoItem (){
        
        let todoItem = ToDoItem(name: "todoItem", isFinished: false)
        
        self.todoItems.value.append(todoItem)
    }
    
    @objc func clearToDoItems(){
        
        self.todoItems.value.removeAll()
    }
}

extension FirstViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todo = self.todoItems.value[indexPath.row]
        
        
//        todo.isFinished = !todo.isFinished
//        self.todoItems.value[indexPath.row] = todo
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.todoItems.value.remove(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
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
