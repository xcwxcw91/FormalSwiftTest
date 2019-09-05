//
//  FourthViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()
        
    }
    
    
    func getData(){
         
        let api = "/test/list"
 
        RequestTool.requestDataWithParams(nil, api: api, nil, success: { (result) in
            
            let jsonToModel = FourthModel.deserialize(from: result.data as? Dictionary , designatedPath : "data")
            
            print("取到的model \(jsonToModel)")
            
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
