//
//  SurveyFormViewController.swift
//  Awwal Tech Surveys
//
//  Created by WCP on 10/6/19.
//  Copyright © 2019 Gexton. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MRProgress
import BEMCheckBox

class SurveyFormViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var logoImg: UIImageView!
    var FormDataList = [FormPopulateData]()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FormDataList = [FormPopulateData]()
        textInput = [String:String]()
        areaInput = [String:String]()
        checkedList = [String:[Int:Bool]]()
        radioList = [String:Int]()
        conditionalList = [String:Int]()
        radioData = [String:BEMCheckBox]()
        
        tableview.allowsSelection = false
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        let logoUrl = "http://\(AppDataSwift.userDefault.string(forKey: "companyLogo")!)"
        self.logoImg.sd_setImage(with: URL(string: (logoUrl) ), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        getData()
        
    
    }
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        submit()
    }
    
    
    func submit(){
        let button = FormPopulateData()
        button.quiz_type_name = "submit"
        FormDataList.append(button)
        var questionAns : [DynamicQuestionAns] = []
        for index in 0..<FormDataList.count{
            
            let data = FormDataList[index]
            
            if data.quiz_type_name == TYPEText{     // ------------- TYPEText
                
                
                let Ans = DynamicQuestionAns()
                Ans.quiz_id = data.id
                Ans.quiz_type_name = data.quiz_type_name
                var ansArray = [String]()
                if textInput["\(index):0"] != nil && !(textInput["\(index):0"]?.isEmpty)!{
                    ansArray.append(textInput["\(index):0"]!)
                }
                Ans.quiz_answer = ansArray.joined(separator:",")
                questionAns.append(Ans)
                
            }else if data.quiz_type_name == TYPETextArea {       // ------------- TYPECheckBox
                
                
                let Ans = DynamicQuestionAns()
                Ans.quiz_id = data.id
                Ans.quiz_type_name = data.quiz_type_name
                var ansArray = [String]()
                if areaInput["\(index):0"] != nil && !(areaInput["\(index):0"]?.isEmpty)!{
                    ansArray.append(areaInput["\(index):0"]!)
                }
                Ans.quiz_answer = ansArray.joined(separator:",")
                questionAns.append(Ans)
                
            }else if data.quiz_type_name == TYPECheckBox {       // ------------- TYPECheckBox
                
                
                let Ans = DynamicQuestionAns()
                Ans.quiz_id = data.id
                Ans.quiz_type_name = data.quiz_type_name
                var ansArray = [String]()
                
                
                if checkedList["\(index):0"] != nil{
                    let ans = checkedList["\(index):0"]
                    for checks in  0..<data.options.count{
                        if ans![checks]!{
                            ansArray.append(data.options[checks])
                        }
                    }
                    
                }
                
                Ans.quiz_answer = ansArray.joined(separator:",")
                questionAns.append(Ans)
                
            }else if data.quiz_type_name == TYPERadio {      // ------------- TYPERadio
                
                let Ans = DynamicQuestionAns()
                Ans.quiz_id = data.id
                Ans.quiz_type_name = data.quiz_type_name
                var ansArray = [String]()
                
                if radioData["\(index):0"] != nil {
                    let radio =  radioData["\(index):0"]
                    ansArray.append(data.options[Int((radio?.accessibilityIdentifier)!)!])
                }
                Ans.quiz_answer = ansArray.joined(separator:",")
                questionAns.append(Ans)
            }
                
            else if data.quiz_type_name == TYPEButton {      // ------------- TYPEButton
                CustomAlert.showLoader(viewController: self)
                let user_id = AppDataSwift.userDefault.string(forKey: "userID")
                let campaign_id = AppDataSwift.userDefault.string(forKey: "campaignId")
                let agentID = AppDataSwift.userDefault.string(forKey: "agentID")
                let aswers = questionAns.toDictionaryArray()
                var parameters : [String:String]? = [String: String]()
                parameters!["user_id"] = user_id
                parameters!["campaign_id"] = campaign_id
                parameters!["other"] = agentID
                parameters!["surveyAnswers"] = convertToJson(data: aswers)
                print("parameters")
                print(parameters)
                print("aswers")
                print(aswers)
                sendData(parameters : parameters!)
                
            }
            
        }
    }
    
    
    
    
    func getData(){
        
        CustomAlert.showLoader(viewController: self)
        let compID = AppDataSwift.userDefault.string(forKey: "companyId")
        
        let loginURL = "http://app.awwalsurvey.com/admin/api/get_survey.php?company_id=\(String(describing: compID!))"
        
        AF.request(loginURL, method: .post, parameters: [:], encoding: URLEncoding.default).responseJSON(completionHandler: { response in
            
            switch response.result{
                
            case .success(let value):
                
                
                CustomAlert.dismissLoader()
                let json = JSON(value)
                print(json)
                
                if json["status"].stringValue == "N"{
                    AppDataSwift.goBack(withNavigationController: self.navigationController!, andIsAnimated: true)
                    AppDataSwift.showAlert("Error", andMsg: json["message"].stringValue, andViewController: self)
                }
                else
                {
                    
                    
                    let jsonData = json
                    let allData = jsonData["data"].array
                    
                    
                    for data in allData ?? [] {
                        let form = FormPopulateData()
                        form.id = data["id"].stringValue
                        form.quiz_name = data["quiz_name"].stringValue
                        form.quiz_type_name = data["quiz_type_name"].stringValue
                        let options = data["options"].array
                        var optionslist = [String]()
                        for option in options ?? [] {
                            optionslist.append(option.stringValue)
                        }
                        form.options = optionslist
                        self.FormDataList.append(form)
                    }
                    self.tableview.delegate = self
                    self.tableview.dataSource = self
                    self.tableview.reloadData()
                    
                    
                }
                
                break
                
            case .failure(let error):
                
                CustomAlert.dismissLoader()
                AppDataSwift.goBack(withNavigationController: self.navigationController!, andIsAnimated: true)
                AppDataSwift.showAlert("Error!", andMsg: error.localizedDescription, andViewController: self)
                print(error)
                
                break
            }
            
            
        })
        
    }
    
    
    
    
    
    func sendData(parameters :[String:String]){
        
        
        
        let loginURL = "http://app.awwalsurvey.com/admin/api/submit_answer_get2.php?"
        
        AF.request(loginURL, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response in
            
            print("-----------response  \(response)")
            switch response.result{
                
            case .success(let value):
                
                
                CustomAlert.dismissLoader()
                let json = JSON(value)
                
                if json["status"].stringValue == "1"{
                    
                     textInput = [String:String]()
                     areaInput = [String:String]()
                     checkedList = [String:[Int:Bool]]()
                     radioList = [String:Int]()
                     conditionalList = [String:Int]()
                     radioData = [String:BEMCheckBox]()
                    
                    
                    self.showAlertWithBack("Success", andMsg: "Sync Successfully", andViewController: self)
                    
                }else{
                    AppDataSwift.showAlert("Server Error", andMsg: "Unable to upload please try again", andViewController: self)
                    
                }
                
                break
                
            case .failure(let error):
                
                CustomAlert.dismissLoader()
                
                AppDataSwift.showAlert("Error!", andMsg: error.localizedDescription, andViewController: self)

                
                break
            }
            
            
        })
        
    }
    
    func showAlertWithBack(_ title: String, andMsg msg: String, andViewController vc: UIViewController) {
        let alertController = UIAlertController.init(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
         let doneAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                   AppDataSwift.goBack(withNavigationController: self.navigationController!, andIsAnimated: true)
               }
        alertController.addAction(doneAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func convertToJson(data: NSArray) -> String {
        var dataJson : String = ""
        
        if let convertDataJson = try? JSONSerialization.data(
            withJSONObject: data,
            options: []) {
            dataJson = String(data: convertDataJson,
                              encoding: .ascii)!
            
        }
        return dataJson
    }
    
    @IBAction func backPress(_ sender: UIButton) {
        
        AppDataSwift.goBack(withNavigationController: self.navigationController!, andIsAnimated: true)
        
    }
}
