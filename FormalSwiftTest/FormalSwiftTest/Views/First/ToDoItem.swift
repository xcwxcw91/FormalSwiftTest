//
//  ToDoItem.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/12.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class ToDoItem: NSObject , NSCoding{
    
    var name = ""
    var isFinished = false
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(isFinished, forKey: "isFinished")
    }
    
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObject(forKey: "name") as! String
        isFinished = aDecoder.decodeBool(forKey: "isFinished")
    }
    
    init(name:String, isFinished: Bool) {
        
        self.name = name
        self.isFinished = isFinished
    }

    
    
}
