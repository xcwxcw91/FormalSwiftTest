//
//  ThirdRedTableViewCell.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class ThirdRedTableViewCell: BaseTableViewCell {
    

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize(){
        
        self.imageView?.frame = CGRect.init(x: 10, y: 10, width: 40, height: 40)
    }
    

    override func setCellData(cellModel model: BaseTableViewCellModel) {
        
        if model is ThirdCellModel{
            
            self.contentView.backgroundColor = .red
            self.textLabel?.backgroundColor = .clear
            self.textLabel?.text = "red"
            self.imageView?.image = UIImage(named: "cake")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = nil
        self.imageView?.image = nil
        self.contentView.backgroundColor = .clear
        
    }
}