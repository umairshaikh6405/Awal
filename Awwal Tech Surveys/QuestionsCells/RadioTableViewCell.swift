//
//  RadioTableViewCell.swift
//  PMI-CIS
//
//  Created by aa on 06/04/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import BEMCheckBox

class RadioTableViewCell: UITableViewCell,BEMCheckBoxDelegate {

    @IBOutlet weak var mandatory: UILabel!
    var options:[String]?
    var checklist = [BEMCheckBox]()
    var index = ""
     var grop : BEMCheckBoxGroup!
    
    @IBOutlet weak var lablestack: UIStackView!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var lable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func checkbox(s : String,i : String){
        let checkboxx = BEMCheckBox.init(frame: CGRect(x: 0, y: 1, width: 19, height: 19))
        checkboxx.tintColor = UIColor.init(red: 229, green: 3, blue: 1)
         checkboxx.onCheckColor = UIColor.init(red: 255, green: 255, blue: 255)
         checkboxx.onFillColor = UIColor.init(red: 229, green: 3, blue: 1)
         checkboxx.onTintColor = UIColor.init(red: 229, green: 3, blue: 1)
        
        checkboxx.boxType = .circle
        checkboxx.delegate = self
        checkboxx.accessibilityIdentifier = i
        let label = UILabel(frame: CGRect(x: 22, y: 0, width: 200, height: 21))
        label.textAlignment = .left
        label.text = s
        stackview.addArrangedSubview(checkboxx)
        lablestack.addArrangedSubview(label)
        checklist.append(checkboxx)
        
        
    }
    
    func checkbox()-> [BEMCheckBox]{
        return checklist
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        grop.mustHaveSelection = true
       radioList[index] = checklist.index(of: checkBox)
        radioData[index] = checkBox
        
    }
    
    func changeArray(options:[String])  {
       
        for n in options{
            checkbox(s: n,i: "\(options.index(of: n)!)")
        }
        
        grop = BEMCheckBoxGroup.init(checkBoxes: checklist)
     
            if radioList[index] != nil{
               print("----chala"+index)
                grop.selectedCheckBox = checklist[radioList[index]!]
            }else{
                print("----nhchala"+index)
                grop.selectedCheckBox = nil
                
            }
        
        
    }
    
    
    
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        // Reset the cell for new row's data
          grop.mustHaveSelection = false
        
        checklist.removeAll()
        
        for n in stackview.subviews{
            n.removeFromSuperview()
        }
        for n in lablestack.subviews{
            n.removeFromSuperview()
        }
    }
    


}
