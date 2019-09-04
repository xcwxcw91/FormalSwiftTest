//
//  ThirdViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class ThirdViewController: BaseTableViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getData()
    }
    
    func getData(){
        
        for i in 0...202 {
            
            if i % 2 == 0{
                
                self.dataSource.append(ThirdCellModel())
            }
            else{
                
                self.dataSource.append(ThirdCellModel1())
            }
        }
    }
}


