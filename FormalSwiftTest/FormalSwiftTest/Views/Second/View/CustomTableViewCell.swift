//
//  SecondTableViewCell.swift
//  FormalSwiftTest
//
//  Created by sdusz on 2019/9/3.
//  Copyright © 2019年 xcw. All rights reserved.
//

import UIKit
import SnapKit

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
    
//    override func layoutSubviews() {
//
//        super.layoutSubviews()
//        self.coverView.snp.makeConstraints { (ConstraintMaker) in
//
//            ConstraintMaker.width.equalTo(100)
//            ConstraintMaker.height.equalTo(100)
//            ConstraintMaker.center.equalTo(self.contentView)
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.coverView.backgroundColor = selected ? .red : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.coverView.backgroundColor = highlighted ? .blue : .clear
    }
}
