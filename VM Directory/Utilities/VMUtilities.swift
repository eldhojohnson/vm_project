//
//  VMUtilities.swift
//  VM Directory
//
//  Created by Eldho on 12/07/22.
//

import Foundation
import UIKit

class VMUtilities {
    
    static let shared = VMUtilities()

    func showAlertWithTitle(title:String?, andMessage message:String?, inView view:UIViewController){
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: VMAlertButtons.ok, style: .cancel, handler: nil)
            
            alertController.view.tintColor = #colorLiteral(red: 0.8412271142, green: 0, blue: 0, alpha: 1)
            alertController.addAction(cancelAction)
            
            
            view.present(alertController, animated: true, completion: nil)
            
        }
        
        
    }
    
    
    func showAlertWithTwoFunctionality(message: String, title : String?,view: UIViewController, buttonOneTitle : String, fucntionOne:@escaping () -> Void, buttonTwoTitle : String, fucntionTwo:@escaping () -> Void) {
          
          DispatchQueue.main.async {
              
              let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
              //
              let cancelAction = UIAlertAction(title: buttonOneTitle, style: .cancel, handler: {
                  
                  (alert: UIAlertAction!) in
                  
                  fucntionOne()
                  
                  
              })
              
              
              
              let tryAction = UIAlertAction(title: buttonTwoTitle, style: .default, handler: {
                  
                  (alert: UIAlertAction!) in
                  
                  fucntionTwo()
                  
                  
              })
              
              alertController.view.tintColor = #colorLiteral(red: 0.8412271142, green: 0, blue: 0, alpha: 1)
              alertController.addAction(cancelAction)
              alertController.addAction(tryAction)
              view.present(alertController, animated: true, completion: nil)
              
              
          }
          
      }
    
}
