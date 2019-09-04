//
//  ThirdViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class ThirdViewController: BaseTableViewController {
 
    let sectionModel = BaseTableViewSectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getData()
    }
    
    func getData(){
        //在正式项目中，此处应该从接口获取数据，json转model之后给到View使用
        for i in 0...202 {
            
            if i % 2 == 0{
                
                let model = ThirdRedCellModel()
                model.rowHeight = 60
                model.title = "red \(i)"
                model.subtitle = "this is the \(i) count"
                model.imageName = "cake"
                sectionModel.addCellModel(model)
            }
            else{
                
                let model = ThirdGreenCellModel()
                model.greenTitle = "here comes the green cells"
                model.greenSubtitle = "this is the NO.\(i)"
                model.greenImageName = "Swift_logo"
                sectionModel.addCellModel(model)
            }
        }
        
        self.dataSource = [sectionModel]
    }
}


