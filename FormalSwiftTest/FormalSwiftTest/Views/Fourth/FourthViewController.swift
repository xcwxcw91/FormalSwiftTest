//
//  FourthViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class FourthViewController: BaseTableViewController {

    let sectionModel = BaseTableViewSectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.dataSource = [sectionModel]
        
        getData()

    }
    
    
    func getData(){
         
        let api = "/test/list"
 
        RequestTool.requestDataWithParams(nil, api: api, nil, success: { (result) in
            
            let jsonToModel = FourthModel.deserialize(from: result.data as? Dictionary)
            
            print("取到的model \(String(describing: jsonToModel?.list?.first?.headimg))")

            // for in
            for element in (jsonToModel?.list)!{
                
                element.name = "xcw"
            }
        
            // enumerate
            for (index,element) in (jsonToModel?.list?.enumerated())!{
                
                if index % 2==0{
                    
                    element.useFourth_one_Cell = true
                }
            }

            self.sectionModel.addCellModelsFromArray(jsonToModel?.list)
            
            self.reload()
            
        }) { (msg, code) in
            
        }
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
