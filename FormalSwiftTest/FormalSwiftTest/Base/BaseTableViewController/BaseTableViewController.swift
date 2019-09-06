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
    var dataSource = [BaseTableViewSectionModel]()
    
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
    
    public func reload(){
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView Delegate && Datasource
extension BaseTableViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionModel = self.dataSource[section];
        return sectionModel.cellModelCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = self.dataSource[indexPath.section]
        let item = section.cellModelAtIndex(indexPath.row)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: item.cellReuseIdentifer) as? BaseTableViewCell
        
        if cell == nil {
 
            let newCellClass = item.cellClass as! BaseTableViewCell.Type
            
            cell = newCellClass.init(style: .default, reuseIdentifier: String(describing: item.cellReuseIdentifer))
            
            
//瞎写的init方法，用这个也可以  cell = newCellClass.init(arg0: String(describing: item.cellReuseIdentifer), arg1 :.default)
        }
        
        cell!.setCellData(section, item)
        return cell!
    }
}

extension BaseTableViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = self.dataSource[indexPath.section]
        let item = section.cellModelAtIndex(indexPath.row)
        
        return item.rowHeight
    }
}

