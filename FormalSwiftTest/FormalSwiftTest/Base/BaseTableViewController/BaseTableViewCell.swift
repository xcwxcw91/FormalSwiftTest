//
//  BaseTableViewCell.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    //子类需要在init方法前加上required，以保证一致性
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func initialize(){}
    
    public func setCellData(_ sectionModel:BaseTableViewSectionModel  ,_ cellModel: BaseTableViewCellModel){}


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


