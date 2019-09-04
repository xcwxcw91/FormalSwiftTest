//
//  BaseTableViewCellModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

protocol BaseTableViewCellModelProtocol  {

    var cellClass : UITableViewCell.Type {get}//cellModel associated tableviewCell Class, default is BaseTableViewCell
    var cellReuseIdentifer : String {get}//tableViewCell's reuseIdentifer, default is "BaseTableViewCell"
    var rowHeight : CGFloat {get}//tableViewCell's rowHeight, default is 44
    var cellJumpClassName : AnyClass? {get}// jump class when tapped tableViewCell, nullable

}

class BaseTableViewCellModel : BaseTableViewCellModelProtocol{
  
    var cellClass: UITableViewCell.Type{
        
        return BaseTableViewCell.self
    }
    
    var cellReuseIdentifer: String{
        
        return String(describing: BaseTableViewCell.self)
    }
    
    var rowHeight: CGFloat{
        
        return 44.0
    }
    
    var cellJumpClassName: AnyClass?{
        
        return nil
    }
    
}



    
   

