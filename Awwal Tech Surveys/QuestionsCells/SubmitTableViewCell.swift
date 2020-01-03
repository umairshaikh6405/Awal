//
//  SubmitTableViewCell.swift
//  PMI-CIS
//
//  Created by aa on 09/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class SubmitTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        Constants.getInstance().dynamicTableViewController.submit()
    }
    
}
