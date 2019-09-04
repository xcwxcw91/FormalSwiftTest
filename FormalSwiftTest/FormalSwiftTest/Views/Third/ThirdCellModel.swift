//
//  SecondCellModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class ThirdCellModel: BaseTableViewCellModel {

    var privateProperty : String = "ThirdRedTableViewCell"
   
    override var cellClass: UITableViewCell.Type{
        
        return ThirdRedTableViewCell.self
    }
    
    override var cellReuseIdentifer: String{
        return String(describing: ThirdRedTableViewCell.self)
    }
}

class ThirdCellModel1: BaseTableViewCellModel {
    
    var privateProperty : String = "ThirdGreenTableViewCell"
  
    override var cellClass: UITableViewCell.Type{
        
        return ThirdGreenTableViewCell.self
    }
    
    override var cellReuseIdentifer: String{
        return String(describing: ThirdGreenTableViewCell.self)
    }
    
    override var rowHeight: CGFloat{
        
        return 100
    }
}

