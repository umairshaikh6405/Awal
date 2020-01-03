//
//  SurveyFormExtension.swift
//  Awwal Tech Surveys
//
//  Created by WCP on 10/6/19.
//  Copyright © 2019 Gexton. All rights reserved.
//

import Foundation
import UIKit

extension SurveyFormViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return FormDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
            let index = "\(indexPath.section):\(indexPath.row)"
            
            let type = FormDataList[indexPath.section].quiz_type_name
            // parent --------
            if type!.elementsEqual(TYPEText){
                print("one")
                let cell = (tableView.dequeueReusableCell(withIdentifier: "settingTableViewCell") as? GTableViewCell)!
                cell.isnumber = false
                cell.changeToNum(isChange: false)
                cell.index = index
                cell.lablee.text = FormDataList[indexPath.section].quiz_name
                cell.inputt.text = textInput[index] ?? ""
                cell.contentView.backgroundColor  = UIColor.white
                return cell
            }else if type!.elementsEqual(TYPETextArea){
                let cell = (tableView.dequeueReusableCell(withIdentifier: "TextAreaTableViewCell") as? TextAreaTableViewCell)!
                cell.index = index
                cell.questionLable.text = FormDataList[indexPath.section].quiz_name
                cell.textArea.text = areaInput[index] ?? ""
                cell.contentView.backgroundColor  = UIColor.white
                 print("two")
                return cell
            }else if type!.elementsEqual(TYPECheckBox) {
                  print( "FormDataList")
                 print( FormDataList[indexPath.section])
                let cell = (tableView.dequeueReusableCell(withIdentifier: "checkboxcell") as? checkboxTableViewCell)!
                cell.index = index
                cell.lable.text = FormDataList[indexPath.section].quiz_name
                cell.changeArray(options: FormDataList[indexPath.section].options)
                cell.contentView.backgroundColor  = UIColor.white
                 print("three")
                return cell
                
            }else if type!.elementsEqual(TYPERadio) {
                
                let cell = (tableView.dequeueReusableCell(withIdentifier: "RadioTableViewCell") as? RadioTableViewCell)!
                cell.index = index
                cell.lable.text = FormDataList[indexPath.section].quiz_name
                cell.changeArray(options: FormDataList[indexPath.section].options)
                cell.contentView.backgroundColor  = UIColor.white
                   print("four")
                return cell
                
              
            }else{
                  print("elseeeee")
                return UITableViewCell()
            }
            
        }
        
    
    
}

