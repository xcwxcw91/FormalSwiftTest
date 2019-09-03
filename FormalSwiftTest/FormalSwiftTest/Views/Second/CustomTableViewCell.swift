//
//  SecondTableViewCell.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/3.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    weak var titleLabel : UILabel!
    weak var coverView : UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        self.coverView.image = nil
    }

    func initialize(){
     
        let titleLabel = UILabel.init(frame: CGRect.init(x: 70, y: 10, width: 200, height: 40))
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel = titleLabel
        
        let coverView = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 50, height: 50))
        coverView.contentMode = .scaleAspectFit
        self.coverView = coverView;
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(coverView)
        
    }
}
