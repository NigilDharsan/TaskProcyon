//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by NigilDharsan on 28/05/22.
//

import UIKit

import Alamofire

class NetworkManager: NSObject {
    
    var alamoFireManager : SessionManager!
    
    
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        
    }
    func cancelAllRequest() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({
                $0.cancel()
                
            })
        }
    }
    
    func cancelRequestFor(url: String){
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({task in
                if task.currentRequest?.url?.absoluteString == url{
                    print("Task Cancelled : \(url)")
                    task.cancel()
                }
            })
        }
    }
    
    func requestWith(_ method:HTTPMethod, strURL : String,
                     params : [String : Any]?, headers : [String : String]? = nil, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void){
        
        let encoding =  URLEncoding(boolEncoding: .literal) //URLEncoding.default
        
        Alamofire.request(strURL, method: method, parameters: params, encoding: encoding , headers: headers).responseData { (responseData) -> Void in
                
                if let error = responseData.error{
                    if error != nil {
                        failure(error)
                    }
                }else{
                    success(responseData.data!)
                }
            }
        }
        
}


// MARK: - Network Reachability
struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}


