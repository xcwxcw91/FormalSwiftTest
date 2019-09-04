//
//  BaseTableViewController.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController {

    weak var tableView : UITableView!
    var dataSource = [BaseTableViewCellModel]()
    
    override func loadView() {
        
        super.loadView()
        
        let tableView = UITableView.init(frame: self.view.bounds, style: self.tableViewStyle())
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
       
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
  
    public func tableViewStyle() -> UITableView.Style{
        
        return .plain
    }
}

//MARK: - TableView Delegate && Datasource
extension BaseTableViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.dataSource[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: item.cellReuseIdentifer) as? BaseTableViewCell
        
        if cell == nil {
 
            let newCellClass = item.cellClass as! BaseTableViewCell.Type
            
            cell = newCellClass.init(style: .default, reuseIdentifier: String(describing: item.cellReuseIdentifer))
        }
        
        cell!.setCellData(cellModel: item)
        return cell!
    }
}

extension BaseTableViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item = self.dataSource[indexPath.row]
        
        return item.rowHeight
    }
}

