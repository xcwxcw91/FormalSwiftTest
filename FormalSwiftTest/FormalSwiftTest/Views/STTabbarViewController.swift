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
        first.view.backgroundColor = .red
        first.title = "first"
        
        let second = SecondViewController()
        second.view.backgroundColor = .yellow
        second.title = "second"
        
        let third = ThirdViewController()
        third.view.backgroundColor = .green
        third.title = "third"
        
        let fourth = FourthViewController()
        fourth.view.backgroundColor = .purple
        fourth.title = "fourth"
        
        let fifth  = FifthViewController()
        fifth.view.backgroundColor = .white
        fifth.title = "RxSwiftTest"
        
        self.setViewControllers([first, second, third, fourth, UINavigationController.init(rootViewController: fifth)], animated: true)
        
        
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
