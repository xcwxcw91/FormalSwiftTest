//
//  ThirdGreenTableViewCell.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class ThirdGreenTableViewCell: BaseTableViewCell {
  
    override func initialize(){
        
        super.initialize()
        
        self.imageView?.frame = CGRect.init(x: 100, y: 10, width: 40, height: 40)
        self.contentView.backgroundColor = .green
        self.textLabel?.backgroundColor = .clear
    }
    
    override func setCellData(sectionModel sectionModel:BaseTableViewSectionModel ,cellModel model: BaseTableViewCellModel) {
       
        if model is ThirdGreenCellModel{
            
            let greenModel =  model as! ThirdGreenCellModel
            
            self.textLabel?.text = greenModel.greenTitle
            self.detailTextLabel?.text = greenModel.greenSubtitle
            if let img = greenModel.greenImageName {
                
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
