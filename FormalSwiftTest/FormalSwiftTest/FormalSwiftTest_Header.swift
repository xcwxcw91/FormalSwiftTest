//
//  FormalSwiftTest_Header.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/5.
//  Copyright © 2019 xcw. All rights reserved.
//

import Foundation

//使用 @_exported import 只需要导入一次即可全局使用
@_exported import SnapKit
@_exported import Alamofire
@_exported import HandyJSON
@_exported import Kingfisher
@_exported import SCLAlertView
@_exported import RxSwift
@_exported import RxCocoa


public let kScreenWidth = UIScreen.main.bounds.size.width <=  UIScreen.main.bounds.size.height ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height;

public let kScreenHeight = UIScreen.main.bounds.size.height >=  UIScreen.main.bounds.size.width ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width;

