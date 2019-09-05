//
//  RequestTool.swift
//  FormalSwiftTest
//
//  Created by allen on 2019/9/5.
//  Copyright © 2019 xcw. All rights reserved.
//

import UIKit
import Alamofire

public enum BaseUrl : String{
    
    case base = "http://onapp.yahibo.top/public/?s=api"
    case login = "login"
}

public enum RequestErrorType : Int{
    
    case unknown = 400
    case serverError = 401
    case tokenExpired = 402
    case paramInvalid = 403
}

typealias RequestSuccessBlock = (_ result : BaseRequestResultModel) -> Void

typealias RequestFailureBlock = (_ message: String, _ errorCode : RequestErrorType) -> Void


// 自定义请求的adapter
class MyRequestAdapter : RequestAdapter{
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        
        var request = urlRequest
        request.setValue("userToken", forHTTPHeaderField: "token")
        
        return request
    }
}

//自定义请求失败的重试
//设定重新发送请求2次
//延时0.5秒再发送请求

class MyRequestRetrier: RequestRetrier {
    
    var count = 0
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
        if count<2 {
            completion(true,0.5)
            count += 1
        }else{
            completion(false,0.5)
        }
    }
    
}

public class RequestTool: NSObject {
    
    
    class func requestDataWithParams(_ method : HTTPMethod? = .get ,
                                     api url:String = "" ,
                                     _ params: Parameters? = nil,
                                     success successBlock: @escaping RequestSuccessBlock ,
                                     failure failureBlock: @escaping RequestFailureBlock) {
        
        let fullApi = BaseUrl.base.rawValue + url
        
        Alamofire.request(fullApi, method: method ?? .get , parameters: params).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                print(json)
                
                let result = BaseRequestResultModel()
                result.code = 200
                result.success = true
                result.message = "success"
                result.data = json
                
                successBlock(result)
                
                break
                
            case .failure(let error):
                
                print("error:\(error)")
                failureBlock("errorMessage", .paramInvalid)
                break
            }
            
        }
    
    }

}
