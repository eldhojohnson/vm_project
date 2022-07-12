//
//  NetworkHelper.swift
//  VM Directory
//
//  Created by Eldho on 10/07/22.
//


import Foundation
import Alamofire
import Reachability

//MARK: Webservices / APIs
class NetworkHelper: NSObject {
    
    static let shared = NetworkHelper()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")

    func isRechable() -> Bool{
        
        print("Network Status value : \(String(describing:  reachabilityManager?.isReachable))")
        
        if let reachable =  reachabilityManager?.isReachable{
            
            if reachable == true{
                
                return true
            }
            else
            {
                
                
                return false
            }
            
            
        }
        
        return false
    }
    
    func makeAPIRequest( url : String, method : HTTPMethod, encoding : ParameterEncoding, params : [String:Any]?,successCompletion: @escaping (_ responseJSON: Any?, _ isError: Bool , _ isNetworkError: Bool,_ isGoToLogin: Bool, _ isMaintenance: Bool ) -> Void) {
        
        
        if isRechable(){
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            var encodedURL = url
            if let val = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                
                encodedURL = val
            }
            
            
            AF.request(encodedURL, method: method, parameters: params , encoding: encoding, headers: nil)
                .responseJSON { response in
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    print(params?.description as Any)
                    print(response.request as Any)  // original URL request
                    print(response.response as Any) // URL response
                    
                    
                    if response.response?.statusCode == 503{
                        successCompletion(nil,true,false,false,true)
                        return
                    }
                    
                    if response.response?.statusCode == 401 || response.response?.statusCode == 400 || response.response?.statusCode == 403 {
                        
                        //go to login
                        
                        successCompletion(nil, false,false,false,false)
                        return
                    }
                    
                    switch response.result {
                    case .success(let value):
                        
                        if let responseData = value as? [[String:Any]],(response.response?.statusCode == 200 || response.response?.statusCode == 201){
                            print(responseData)
                            successCompletion(responseData, false,false,false,false)
                            
                            return
                            
                        }
                        
                        if let responseData = value as? [[String:Any]]{
                            print(responseData)
                            successCompletion(responseData,true,false,false,false)
                            return
                        }
                        
                        
                    case .failure(let error):
                        
                        successCompletion(error,true,false, false,false)
                        return
                        
                    }
                    
                }
            
        }
        else
        {
            
            successCompletion("No Internet", true, true,false,false)
            
        }
        
    }
}
