//
//  BaseRequestResultModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/5.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class BaseRequestResultModel: HandyJSON {

    var status : Int?
    var message : String?
    var data : Any?
    
    required init( ) {
        
    }
}
