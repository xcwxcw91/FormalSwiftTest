//
//  ToDoItemTableViewCell.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/12.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit

class ToDoItemTableViewCell: UITableViewCell {

    weak var statusLabel : UILabel!
    weak var nameLabel : UILabel!

    var todo: ToDoItem?{
        
        didSet{
            
            self.statusLabel.text = todo?.isFinished == true ? "✓":""
            self.nameLabel.text = todo?.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.status)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.info)

        self.status.snp.makeConstraints { make in
            
            make.left.top.bottom.equalTo((0))
            make.width.equalTo(50)
        }
        
        self.info.snp.makeConstraints { (make) in
            
            make.right.equalTo(-10)
            make.centerY.equalTo(self)
        }
        
        self.name.snp.makeConstraints { (make) in
            make.left.equalTo(self.status.snp_right)
            make.top.bottom.equalTo(0)
            make.right.equalTo(self.info.snp_left)
        }
        
        self.statusLabel = self.status
        nameLabel = name
        
        
        self.accessoryType = .disclosureIndicator
        
        self.info.rx.tap.subscribe{
            
            
            
        }.dispose()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        statusLabel.text = nil
        nameLabel.text = nil
    }
    
    let status:UILabel={
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        
        return label
    }()
    
    let name:UILabel={
        
        return UILabel()
    }()
    
    let info : UIButton = {
       
        let btn = UIButton.init(type: .infoDark)
        return btn
    }()
}
