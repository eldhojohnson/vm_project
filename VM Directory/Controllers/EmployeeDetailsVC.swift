//
//  EmployeeDetailsVC.swift
//  VM Directory
//
//  Created by Eldho on 11/07/22.
//

import UIKit
import Kingfisher

class EmployeeDetailsVC: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var favColorLabel: UILabel!
    @IBOutlet weak var bgVIew: UIImageView!
    
    var employeeData : PeopleListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData(){
        if let employeeData = employeeData {
            userImage.layer.cornerRadius = 30
            userImage.kf.setImage(with: URL(string: employeeData.avatar ?? ""), placeholder: UIImage(named: "avatar"))
            userNameLabel.text = employeeData.firstName + " " + employeeData.lastName
            emailLabel.text = employeeData.email
            jobTitleLabel.text = employeeData.jobtitle
            favColorLabel.text = "Favourite Colour: " + (employeeData.favouriteColor ?? "-")
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        bgVIew.addGestureRecognizer(gesture)
    }

    @objc func tapAction(){
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
