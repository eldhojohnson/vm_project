//
//  VMLabel.swift
//  VM Directory
//
//  Created by Eldho on 12/07/22.
//

import UIKit

class VMCustomLabel : UILabel {

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.font = .systemFont(ofSize: 17)
        self.textColor = .black
        self.backgroundColor = .clear
        self.textAlignment = .left
    }
    
}
