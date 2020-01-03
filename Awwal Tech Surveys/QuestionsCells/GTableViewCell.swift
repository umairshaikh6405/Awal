//
//  GTableViewCell.swift
//  Dynamic
//
//  Created by aa on 29/03/2019.
//  Copyright © 2019 aa. All rights reserved.
//

import UIKit

class GTableViewCell: UITableViewCell,UITextFieldDelegate {

      var index = ""
    var isnumber = false
    @IBOutlet weak var mandatory: UILabel!
    @IBOutlet weak var inputt: UITextField!
    @IBOutlet weak var lablee: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
           inputt.delegate = self
          inputt.keyboardType = .default
        inputt.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeToNum(isChange : Bool)  {
    inputt.keyboardType = .default
    }
    


    @IBAction func text(_ sender: Any) {
      textInput[index] = inputt.text
    }
}
