//
//  VMWebServices.swift
//  VM Directory
//
//  Created by Eldho on 10/07/22.
//

import Foundation
import Alamofire
import SVProgressHUD
import Reachability

//MARK: Webservices / APIs
class VMWebServices: NSObject {
    
    static let shared = VMWebServices()

    func getPeopleList(completion: @escaping (_ responseJSON: Any?, _ isError: Bool , _ isNetworkError: Bool,_ isGoToLogin: Bool, _ isMaintenance: Bool ) -> Void) {

        NetworkHelper.shared.makeAPIRequest(url: VMURLs.baseURL + VMURLs.people, method: .get, encoding: JSONEncoding.default, params: nil) { responseJSON, isError, isNetworkError, isGoToLogin, isMaintenance in
            
            completion(responseJSON,isError,isNetworkError,isGoToLogin,isMaintenance)
        }
    }
    
    func getRoomsList(completion: @escaping (_ responseJSON: Any?, _ isError: Bool , _ isNetworkError: Bool,_ isGoToLogin: Bool, _ isMaintenance: Bool ) -> Void) {

        NetworkHelper.shared.makeAPIRequest(url: VMURLs.baseURL + VMURLs.rooms, method: .get, encoding: JSONEncoding.default, params: nil) { responseJSON, isError, isNetworkError, isGoToLogin, isMaintenance in
            
            completion(responseJSON,isError,isNetworkError,isGoToLogin,isMaintenance)
        }
    }
}
