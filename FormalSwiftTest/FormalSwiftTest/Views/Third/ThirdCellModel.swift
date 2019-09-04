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

    fileprivate var _redCellClass: UITableViewCell.Type?
    override var cellClass: UITableViewCell.Type{

        set{
            _redCellClass = newValue
        }
        get{
            return _redCellClass ?? ThirdRedTableViewCell.self
        }
    }

    fileprivate var _cellReuseIdentifer : String?
    override var cellReuseIdentifer: String{

        get{
            return _cellReuseIdentifer ?? String(describing: ThirdRedTableViewCell.self)
        }
        set{
            _cellReuseIdentifer = newValue
        }
    }
}

class ThirdGreenCellModel: BaseTableViewCellModel {
    
    var greenTitle : String?
    var greenSubtitle : String?
    var greenImageName : String?
    
    fileprivate var _greenCellClass: UITableViewCell.Type?
    override var cellClass: UITableViewCell.Type{
        
        set{
            _greenCellClass = newValue
        }
        get{
            return _greenCellClass ?? ThirdGreenTableViewCell.self
        }
    }
    
    fileprivate var _cellReuseIdentifer : String?
    override var cellReuseIdentifer: String{
        
        get{
            return _cellReuseIdentifer ?? String(describing: ThirdGreenTableViewCell.self)
        }
        set{
            _cellReuseIdentifer = newValue
        }
    }
    
    fileprivate var _rowHeight = 100.0
    override var rowHeight: CGFloat{
        
        get{
            return CGFloat(_rowHeight)
        }
        set{
            _rowHeight = Double(newValue)
            print(_rowHeight)
        }
    }
}

