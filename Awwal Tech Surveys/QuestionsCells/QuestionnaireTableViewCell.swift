//
//  QuestionnaireTableViewCell.swift
//  PMI-CIS
//
//  Created by aa on 07/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class QuestionnaireTableViewCell: UITableViewCell {

    @IBOutlet weak var lableDescrpition: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lableDescrpition.text = UserDefaults.standard.string(forKey: DynamicInstruction)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
