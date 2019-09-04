//
//  BaseTableViewCellModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

protocol BaseTableViewCellModelProtocol  {

    var cellClass : UITableViewCell.Type {get set}//cellModel associated tableviewCell Class, default is BaseTableViewCell
    
    var cellReuseIdentifer : String {get set}//tableViewCell's reuseIdentifer, default is "BaseTableViewCell"
    
    var rowHeight : CGFloat {get set}//tableViewCell's rowHeight, default is 44
    
    var cellJumpClassName : AnyClass? {get set}// jump class when tapped tableViewCell, nullable

}

class BaseTableViewCellModel : BaseTableViewCellModelProtocol, Equatable{
    
    static func == (lhs: BaseTableViewCellModel, rhs: BaseTableViewCellModel) -> Bool {
        
        return lhs === rhs //=== 用于比较内存是否一致
    }
    
    
    fileprivate var _cellClass : UITableViewCell.Type?
    var cellClass: UITableViewCell.Type{
        
        get{
            return _cellClass ?? BaseTableViewCell.self
        }
        set{
            _cellClass = newValue
        }
    }
    
    fileprivate var _reuseIdentifer : String = String(describing: BaseTableViewCell.self)
    var cellReuseIdentifer: String{
        
        get{
            return _reuseIdentifer
        }
        set{
            _reuseIdentifer = newValue
        }
    }
    
    fileprivate var _rowHeight = 44.0
    var rowHeight: CGFloat{
        
        get{
            return CGFloat(_rowHeight)
        }
        set{
            _rowHeight = Double(newValue)
        }
    }
    
    fileprivate var _cellJumpClassName : AnyClass?
    var cellJumpClassName: AnyClass?{
        
        get{
            return _cellJumpClassName
        }
        set{
            _cellJumpClassName = newValue
        }
    }
    
}



    
   

