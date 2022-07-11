//
//  WhiteNavViewController.swift
//  VM Directory
//
//  Created by Eldho on 11/07/22.
//

import UIKit

class WhiteNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbarUI()
        
    }

    
     func setupNavbarUI(){
         
         if #available(iOS 15.0, *) {
             let appearance = UINavigationBarAppearance()
             appearance.configureWithOpaqueBackground()
             appearance.backgroundColor = .white
             appearance.shadowImage = UIImage()
             appearance.shadowColor = .white
             navigationBar.standardAppearance = appearance
             navigationBar.scrollEdgeAppearance = appearance
         }
         else
         {
             self.navigationBar.barTintColor = .white
             self.navigationBar.shadowImage = UIImage()
             self.navigationBar.isTranslucent = false
             self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
         }
         self.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), .font : UIFont.systemFont(ofSize: 18)]
         self.navigationBar.tintColor = .black
         
    }

}
