//
//  VMRoomsListTCell.swift
//  VM Directory
//
//  Created by Eldho on 10/07/22.
//

import UIKit

class VMRoomsListTCell: UITableViewCell {

    @IBOutlet weak var availabilityIndicatorView: UIView!
    @IBOutlet weak var maxOccupencyLabel: UILabel!
    @IBOutlet weak var roomIdLabel: UILabel!
    @IBOutlet weak var roomStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        availabilityIndicatorView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
