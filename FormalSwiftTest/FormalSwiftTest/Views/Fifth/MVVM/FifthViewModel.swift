//
//  FifthViewModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/19.
//  Copyright © 2019 xcw. All rights reserved.
//

import Foundation

class FifthViewModel{
    
    //输出
    let userNameValid : Observable<Bool>
    let passwordValid : Observable<Bool>
    let everythingValid : Observable<Bool>
    
    //输入->输出
    init(userName: Observable<String>, password: Observable<String>) {
        
        let minimalUserNameLength = 5
        let minimalPasswordLength = 5
        
        userNameValid = userName.map{
            
             $0.count >= minimalUserNameLength
        }.share(replay: 1)
        
        passwordValid = password.map{
            
            $0.count >= minimalPasswordLength
            }.share(replay:1)
        
        everythingValid = Observable.combineLatest(userNameValid, passwordValid).map{$0 && $1}.share(replay: 1)
    }
    
    
}
