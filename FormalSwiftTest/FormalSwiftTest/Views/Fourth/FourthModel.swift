//
//  FourthModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/5.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit
import ObjectMapper

class FourthModel: HandyJSON  {

    var page : Int?
    var size : Int?
    var list : [FourthModelItem]?
    
    required  init() {
        
    }
}

class FourthModelItem : HandyJSON {
    
    var id : Int64?
    var name : String?
    var headimg : String?
    var description : String?
    required init() {
        
    }
}
