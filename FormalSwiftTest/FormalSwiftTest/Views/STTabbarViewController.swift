//
//  STTabbarViewController.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/2.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class STTabbarViewController: UITabBarController {
//
//    required init?(coder aDecoder: NSCoder) {
//
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func simpleDescription() -> String{
    
        return ""
    }
    
    init(){
        
        super.init(nibName: nil, bundle: nil)
        
        let first = FirstViewController()
        first.title = "first"
        
        let second = SecondViewController()
        second.title = "second"
        
        let third = ThirdViewController()
        third.title = "third"
        
        let fourth = FourthViewController()
        fourth.title = "fourth"
        
        let fifth  = FifthViewController()
        fifth.title = "RxSwiftTest"
        
        self.setViewControllers([
            UINavigationController.init(rootViewController: first), UINavigationController.init(rootViewController: second),
                                 UINavigationController.init(rootViewController: third),
                                 UINavigationController.init(rootViewController: fourth), UINavigationController.init(rootViewController: fifth)], animated: true)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
