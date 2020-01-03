//
//  checkboxTableViewCell.swift
//  Dynamic
//
//  Created by aa on 29/03/2019.
//  Copyright © 2019 aa. All rights reserved.
//

import UIKit
import BEMCheckBox
class checkboxTableViewCell: UITableViewCell,BEMCheckBoxDelegate {
    
    var options:[String]?
    var checklist = [BEMCheckBox]()
    var index = ""
    var change = false
    @IBOutlet weak var mandatory: UILabel!
    @IBOutlet weak var lablestack: UIStackView!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var lable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        change = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkbox(s : String) {
        let checkboxx = BEMCheckBox.init(frame: CGRect(x: 0, y: 1,width: 19, height: 19))
        checkboxx.boxType = .square
        checkboxx.tintColor = UIColor.init(red: 229, green: 3, blue: 1)
                checkboxx.onCheckColor = UIColor.init(red: 255, green: 255, blue: 255)
                checkboxx.onFillColor = UIColor.init(red: 229, green: 3, blue: 1)
                checkboxx.onTintColor = UIColor.init(red: 229, green: 3, blue: 1)
        checkboxx.delegate = self
        checkboxx.accessibilityIdentifier = s
        let label = UILabel(frame: CGRect(x: 22, y: 0, width: 200, height: 21))
        label.textAlignment = .left
        label.text = s
        stackview.addArrangedSubview(checkboxx)
        lablestack.addArrangedSubview(label)
        checklist.append(checkboxx)
        
        
    }
    
    
    func didTap(_ checkBox: BEMCheckBox) {
        var list = [Int: Bool]()
        for n in 0..<stackview.subviews.count{
            let view = stackview.subviews[n] as! BEMCheckBox
            list[n] = view.on
        }
        checkedList[index] = list
    }
    
    func checkbox()-> [BEMCheckBox]{
    return checklist
        
    }
    
    

    func changeArray(options:[String])  {
       
        
        for n in options{
            checkbox(s: n)
        }
        change = false
     
           
            if checkedList[index] != nil{
                var data = checkedList[index]!
                let list = stackview.subviews as! [BEMCheckBox]
                for n in 0..<list.count{
                    list[n].on = data[n] ?? false
                }
            }else{
                for n in stackview.subviews as! [BEMCheckBox]{
                    n.on = false
                }
            }
        
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        // Reset the cell for new row's data
        checklist.removeAll()
        
        for n in stackview.subviews{
            n.removeFromSuperview()
        }
        for n in lablestack.subviews{
            n.removeFromSuperview()
        }
    
    }
    

}
