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

class FourthModelItem : BaseTableViewCellModel , HandyJSON {
    
    //MARK: - 基础属性
    var id : Int64?
    var name : String?
    var headimg : String?
    var description : String?
    
    //MARK: - custom
    var useFourth_one_Cell: Bool?
    
    required override init() {
        
    }
    
    //MARK: - 设置对于的cell信息
    override var cellClass: UITableViewCell.Type{
        
        get{
            
            _cellClass = useFourth_one_Cell==true ? Fourth_one_TableViewCell.self : FourthTableViewCell.self
            
            return _cellClass!
        }
        set{
            
            _cellClass = newValue
        }
    }
    
    override var rowHeight: CGFloat{
        
        get{
            _rowHeight = useFourth_one_Cell == true ? 100 : 70
            return _rowHeight!
        }
        set{
            
            _rowHeight = newValue
        }
    }
}
