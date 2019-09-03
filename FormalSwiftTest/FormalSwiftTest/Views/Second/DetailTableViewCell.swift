//
//  DetailTableViewCell.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/3.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
        self.imageView?.image = nil
    }

}
