//
//  BaseRequestResultModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/5.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class BaseRequestResultModel: NSObject {

    public var code : Int = 0
    public var message : String = ""
    public var success : Bool = true
    public var data : Any? = nil
    
    
}
