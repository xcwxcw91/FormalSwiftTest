//
//  SecondCellModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class ThirdRedCellModel: BaseTableViewCellModel {

    var title : String?
    var subtitle : String?
    var imageName : String?

    override var cellClass: UITableViewCell.Type{

        set{
            _cellClass = newValue
        }
        get{
            return _cellClass ?? ThirdRedTableViewCell.self
        }
    }
}

class ThirdGreenCellModel: BaseTableViewCellModel {
    
    var greenTitle : String?
    var greenSubtitle : String?
    var greenImageName : String?
    
     override var cellClass: UITableViewCell.Type{
        
        set{
            _cellClass = newValue
        }
        get{
            return _cellClass ?? ThirdGreenTableViewCell.self
        }
    }
   
    override var rowHeight: CGFloat{
        
        get{
            return CGFloat(_rowHeight ?? 100)
        }
        set{
            _rowHeight = newValue
        }
    }
}

