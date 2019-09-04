//
//  ThirdRedTableViewCell.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class ThirdRedTableViewCell: BaseTableViewCell {
    
    override func initialize(){
        
        super.initialize()
    
        self.contentView.backgroundColor = .red
        self.textLabel?.backgroundColor = .clear
        self.imageView?.frame = CGRect.init(x: 10, y: 10, width: 40, height: 40)
    }
    

    override func setCellData(_ sectionModel:BaseTableViewSectionModel ,_ model: BaseTableViewCellModel) {
        
        if model is ThirdRedCellModel{
            
            let redModel = model as! ThirdRedCellModel
            
            self.textLabel?.text = redModel.title
            self.detailTextLabel?.text = redModel.subtitle
            if let img = redModel.imageName {
                
                self.imageView?.image = UIImage(named: img)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = nil
        self.imageView?.image = nil
        
    }
}
