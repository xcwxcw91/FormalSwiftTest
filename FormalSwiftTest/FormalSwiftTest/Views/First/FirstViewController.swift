//
//  FirstViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setup()
    }
    
    func setup() -> Void{
        
        self.view.addSubview(self.lazyBtn)
        self.lazyBtn
            .rx
            .tap
            .subscribe(onNext: {
            print("btn clicked")
            
        }).disposed(by: DisposeBag())
        
    }
    
    @objc dynamic func btnAction() ->Void{
        
        print("btn clicked")
        SCLAlertView().showInfo("Important info", subTitle: "You are great")
    }
    
    //MARK: - Lazy load
    lazy var lazyBtn : UIButton = {
        
        let btn = UIButton.init(type: .contactAdd)
        btn.frame = CGRect.init(x: 20, y: 70, width: 300, height: 200)
        btn.backgroundColor = .cyan
        btn.showsTouchWhenHighlighted = true
        
//        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
     
        return btn
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
