//
//  BaseTableViewSectionModel.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/4.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit
import Foundation



class BaseTableViewSectionModel: NSObject {
 
    
    private var objects  = [BaseTableViewCellModel]()
    private var unfairLock = os_unfair_lock()
    private var spinLock = OS_SPINLOCK_INIT
    
    public var page = 1
    public var pageSize = 10
    
    /// section 添加元素(加到最后面) 单个添加
    ///
    /// - Parameter cellModel: 单个cellmodel
    open func addCellModel(_ cellModel: BaseTableViewCellModel? ){
     
        guard let val : BaseTableViewCellModel = cellModel else { return }

        self.lock()
        self.objects.append(val)
        self.unlock()
    }
    
    /// 从数组批量添加元素
    ///
    /// - Parameter arr: cellModel数组
    open func addCellModelsFromArray(_ arr : [BaseTableViewCellModel]?){
        
        guard let val : [BaseTableViewCellModel] = arr else { return }
        
        self.lock()
        
        self.objects.append(contentsOf: val)
        
        self.unlock()
    }
    
    /// 在指定index插入元素
    ///
    /// - Parameters:
    ///   - cellModel: <#cellModel description#>
    ///   - index: <#index description#>
    open func insertCellModel(_ cellModel: BaseTableViewCellModel, atIndex index: Int) throws -> Void{
        
        guard index < objects.count else {
            
            throw NSError(domain: "index \(index) beyond total count \(objects.count)", code: 100, userInfo: nil)
        }
        
        self.lock()
        objects.insert(cellModel, at: index)
        self.unlock()
    }
    
    
    /// section 移除指定的model
    ///
    /// - Parameter cellModel: <#cellModel description#>
    open func removeCellModel(_ cellModel : BaseTableViewCellModel){
        
        self.lock()
        
        self.objects.remove(at: try! self.indexOfCellModel(cellModel))
        
        self.unlock()
    }
    
    /// section 移除指定index的元素
    ///
    /// - Parameters:
    ///   - index: <#index description#>
    open func removeCellModelAtIndex(_ index:Int) throws{
        
        guard index < objects.count else {
            
            throw NSError(domain: "index \(index) beyond total count \(objects.count)", code: 100, userInfo: nil)
        }
        
        self.lock()
        self.objects.remove(at: index)
        self.unlock()
    }
    
    
    /// 移除所有元素
    open func removeAllCellModels(){
        
        self.lock()
        self.objects.removeAll()
        self.unlock()
    }
    
    
    /// 获取指定位置的元素
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    open func cellModelAtIndex(_ index : Int)  -> BaseTableViewCellModel{
//
//        guard index < objects.count else {
//
//            throw NSError(domain: "index \(index) beyond total count \(objects.count)", code: 100, userInfo: nil)
//        }
//
        return self.objects[index]
    }
    
    /// 获取该section下的cell/cellModel数量 不可用于kvc/kvo
    ///
    /// - Returns: <#return value description#>
    open func cellModelCount() -> Int{
        
        return self.objects.count
    }
    
    /// 获取cellmodel所在的index
    ///
    /// - Parameter cellModel: <#cellModel description#>
    /// - Returns: <#return value description#>
    open func indexOfCellModel(_ cellModel: BaseTableViewCellModel) throws ->Int{
        
        for (index, value) in self.objects.enumerated(){
            
            let model = value
            if (model == cellModel ){
                
                return index
            }
        }
   
        throw NSError(domain: "SectionModel does not contain this cellModel \(cellModel)", code: 101, userInfo: nil)
        
    }
    
    
    /// 交换两个位置的元素
    ///
    /// - Parameters:
    ///   - lhs: <#lhs description#>
    ///   - rhs: <#rhs description#>
    open func switchCellModelAtIndex(_ lhs : Int , _ rhs : Int){
        
        
        
    }
    
    /// 获取所有的元素
    ///
    /// - Returns: <#return value description#>
    open func getAllCellModels() -> [BaseTableViewCellModel]{
        
        return self.objects
    }

    private func lock(){
        
        if #available(iOS 10, *) {
            
            os_unfair_lock_lock(&unfairLock)
        }
        else{
            
            OSSpinLockLock(&spinLock)
        }
    }
    
    private func unlock(){
        
        if #available(iOS 10, *) {
            
            os_unfair_lock_unlock(&unfairLock)
        }
        else{
            
            OSSpinLockUnlock(&spinLock)
        }
    }
}
