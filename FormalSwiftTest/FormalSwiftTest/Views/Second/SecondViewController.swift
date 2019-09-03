//
//  SecondViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //MARK: - Properties
    let cellIdentifer = "UITableViewCell"
    let detailCellIdentifer = "detailCellIdentifer"
    let customCellIdentifer = "customCellIdentifer"
    
    var items: [String] = [
        "👽", "🐱", "🐔", "🐶", "🦊", "🐵", "🐼", "🐷", "💩", "🐰",
        "🤖", "🦄", "🐻", "🐲", "🦁", "💀", "🐨", "🐯", "👻", "🦖",
        ]
    
    weak var tableView : UITableView!
    
    
    //MARK: - Life Cycle
    override func loadView() {
        
        super.loadView()
        
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView)
        
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: detailCellIdentifer)
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: customCellIdentifer)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

//MARK: - Datasource Implementation As Extension
extension SecondViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:customCellIdentifer, for: indexPath) as! CustomTableViewCell
        
        let item = self.items[indexPath.row]
        
        cell.titleLabel.text = item
        
        cell.coverView.image = UIImage(named: "Swift_logo")
        
        return cell
    }

}

//MARK: - Delegate Implementation As Extension
extension SecondViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertCtr = UIAlertController.init(title: "did select", message: "tableview", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "ok", style: .cancel) { (UIAlertAction) in
            
        }
        alertCtr.addAction(action)
        
        self.present(alertCtr, animated: true) {
            
        }
    }
}
