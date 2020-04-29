//
//  TblCell_ExpandItem.swift
//  PSExpandableTableView
//
//  Created by Prince Sojitra on 29/04/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import UIKit

class TblCell_ExpandItem: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var vwSeperator: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
