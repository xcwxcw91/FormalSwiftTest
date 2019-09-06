//
//  Fourth_one_TableViewCell.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/6.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class Fourth_one_TableViewCell: BaseTableViewCell {

    override func initialize() {
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(describeLabel)
        self.contentView.addSubview(avatar)
        
        self.makeConstraints()
    }
    
    func makeConstraints(){
        
        nameLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        avatar.snp.makeConstraints { (make) in
            
            make.right.equalTo(-10)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize.init(width: 50, height: 50))
        }
        
        describeLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(10)
            make.bottom.equalTo(avatar)
            make.right.lessThanOrEqualTo(avatar.snp_left).offset(-10)
        }
    }
    
    override func setCellData(_ sectionModel: BaseTableViewSectionModel, _ cellModel: BaseTableViewCellModel) {
        
        guard let model = cellModel as? FourthModelItem else {return}
        
        nameLabel.text = model.name
        describeLabel.text = model.description
        avatar.image = UIImage(named: "Swift_logo")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        describeLabel.text = nil
        avatar.image = nil
    }
    
    
    //MARK: - Lazy load
    lazy var nameLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = .green
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var describeLabel : UILabel = {
        
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var avatar : UIImageView = {
        
        let img = UIImageView()
        img.layer.cornerRadius = 25
        img.layer.masksToBounds = true
        
        return img
    }()

}
