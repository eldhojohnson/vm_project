//
//  VMEmployeesListTCell.swift
//  VM Directory
//
//  Created by Eldho on 10/07/22.
//

import UIKit

class VMEmployeesListTCell: UITableViewCell {

    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePicImageView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
