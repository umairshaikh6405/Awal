//
//  TextAreaTableViewCell.swift
//  Awwal Tech Surveys
//
//  Created by WCP on 10/8/19.
//  Copyright © 2019 Gexton. All rights reserved.
//

import UIKit
import MultilineTextField

class TextAreaTableViewCell: UITableViewCell , UITextViewDelegate {
    var index = ""
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var textArea : MultilineTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textArea.placeholder = " Text Area.."
        textArea.placeholderColor = UIColor.lightGray
        textArea.isPlaceholderScrollEnabled = true
        textArea.borderColor = UIColor.lightGray
        textArea.borderWidth = 0.3
        textArea.cornerRadius = 5.0
        textArea.delegate = self
     
    }
    func textViewDidChange(_ textView: UITextView) {
        if ( textView.text.elementsEqual("")){
             textArea.placeholder = " Text Area.."
        }else{
             textArea.placeholder = ""
        }
        areaInput[index] = textView.text
        }
    
    
    
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    

}
