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

class BaseTableViewCellModel : BaseTableViewCellModelProtocol{
    
    var _cellClass : UITableViewCell.Type?
    var cellClass: UITableViewCell.Type{
        
        get{
            return _cellClass ?? BaseTableViewCell.self
        }
        set{
            _cellClass = newValue
        }
    }
    
    var _reuseIdentifer : String?
    var cellReuseIdentifer: String{
        
        get{
            return _reuseIdentifer ?? String(describing: cellClass)//reuseidentifer直接使用cellClass，子类若无特殊自定义需求，则无需重写该属性
        }
        set{
            _reuseIdentifer = newValue
        }
    }
    
    var _rowHeight : CGFloat?
    var rowHeight: CGFloat{
        
        get{
            return CGFloat(_rowHeight ?? 44)
        }
        set{
            _rowHeight = newValue
        }
    }
    
    var _cellJumpClassName : AnyClass?
    var cellJumpClassName: AnyClass?{
        
        get{
            return _cellJumpClassName
        }
        set{
            _cellJumpClassName = newValue
        }
    }
}


extension BaseTableViewCellModel : Equatable{
    
    static func == (lhs: BaseTableViewCellModel, rhs: BaseTableViewCellModel) -> Bool {
        
        return lhs === rhs //=== 用于比较内存是否一致
    }
}
    
   

