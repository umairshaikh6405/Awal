
//
//  UserDetailViewController.swift
//  Awwal Tech Surveys
//
//  Created by Aamir Shaikh on 9/27/19.
//  Copyright © 2019 Gexton. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import SwiftyJSON

class UserDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name_tf: UITextField!
    @IBOutlet weak var jobTitle_tf: UITextField!
    @IBOutlet weak var company_tf: UITextField!
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var phone_f: UITextField!
    @IBOutlet weak var business_contact: UITextField!
    @IBOutlet weak var country_tf: UITextField!
    @IBOutlet weak var companySize_tf: UITextField!
    @IBOutlet weak var industry_tf: UITextField!
    @IBOutlet weak var levelOfInterest_tf: UITextField!
    @IBOutlet weak var role_tf: UITextField!
    @IBOutlet weak var budget_tf: UITextField!
    
    @IBOutlet weak var logo_imageView: UIImageView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var nxt_btn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        scrollView.addGestureRecognizer(tap)
        
        self.setNotificationKeyboard()
        
        setBorders()
        
        print("--- logo url \(AppDataSwift.userDefault.string(forKey: "companyLogo")!)")
        
        
        let logoUrl = "http://\(AppDataSwift.userDefault.string(forKey: "companyLogo")!)"
        
        self.logo_imageView.sd_setImage(with: URL(string: (logoUrl) ), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        
        self.companyName.text = AppDataSwift.userDefault.string(forKey: "companyName")
        
        
        
    }
    @IBAction func logout_Action(_ sender: Any) {
        
        
        AppDataSwift.userDefault.set(false, forKey: "isLogin")
        
        AppDataSwift.gotoLoginController(withNavigationController: self.navigationController!, andIsAnimated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.name_tf.text = ""
        self.phone_f.text = ""
        self.jobTitle_tf.text = ""
        self.email_tf.text = ""
        self.company_tf.text = ""
        self.business_contact.text = ""
        self.companySize_tf.text = ""
        self.industry_tf.text = ""
        self.levelOfInterest_tf.text = ""
        self.role_tf.text = ""
        self.budget_tf.text = ""
        self.country_tf.text = ""
    }
    
    @IBAction func next_Action(_ sender: Any) {
        
//        if self.name_tf.hasText{
//
//            if self.phone_f.hasText{
//
//                if self.email_tf.hasText{
//
//                    if self.company_tf.hasText{
             
                        self.addUser(name: self.name_tf.text!, email: self.email_tf.text!, phone: self.phone_f.text!, jobTitle: self.jobTitle_tf.text!, company: self.company_tf.text!, businessContact: self.business_contact.text!, country: self.country_tf.text!, companySize: self.companySize_tf.text!, industry: self.industry_tf.text!, leveOfInterest: self.levelOfInterest_tf.text!, role: self.role_tf.text!, budget: self.budget_tf.text!)
                        
                        
//                    }
//                    else{
//                        
//                        AppSwiftData.shakeTextField(self.company_tf)
//                    }
//                    
//                }
//                else{
//                    
//                    AppSwiftData.shakeTextField(self.email_tf)
//                }
//            }
//            else{
//                
//                AppSwiftData.shakeTextField(self.phone_f)
//            }
//        }
//        else{
//            
//            AppSwiftData.shakeTextField(self.name_tf)
//            
//        }
//        
        
        
        //        AppDataSwift.gotoSurveyFormController(withNavigationController: self.navigationController!, andIsAnimated: true)
        
        
    }
    
    
    func addUser(name: String, email: String, phone: String, jobTitle: String, company: String, businessContact: String, country:String, companySize: String, industry: String, leveOfInterest: String, role: String, budget: String){
        
        CustomAlert.showLoader(viewController: self)
         var parameters : [String:String]? = [String: String]()
        parameters!["name"] = name
        parameters!["email"] = email
        parameters!["phone"] = phone
        parameters!["job_title"] = jobTitle
        parameters!["company"] = company
        parameters!["business_contact"] = businessContact
        parameters!["country"] = country
        parameters!["company_size"] = companySize
        parameters!["industry"] = industry
        parameters!["level_of_interest"] = leveOfInterest
        parameters!["role"] = role
        parameters!["budget"] = budget
        
        
        let addUserUrl = "http://app.awwalsurvey.com/admin/api/add_user_get.php?"
        
        
        AF.request(addUserUrl, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response in
            
            switch response.result{
                
            case .success(let value):
                
                //                AppSwiftData/.dismissLoader(self)
                CustomAlert.dismissLoader()
                
                let json = JSON(value)
                print(json)
                
                print("--Yahooo")
                
                if json["status"].stringValue == "N"{
                    
                    AppDataSwift.showAlert("Error", andMsg: json["message"].stringValue, andViewController: self)
                }
                else{
                    
                    let userId = json["Data"].stringValue
                    
                    AppDataSwift.userDefault.set(userId, forKey: "userID")
                    
                    AppDataSwift.gotoSurvryForm(withNavigationController: self.navigationController!, andIsAnimated: true)
                    
                }
                break
                
            case .failure(let error):
                
                CustomAlert.dismissLoader()
                
                AppDataSwift.showAlert("Error!", andMsg: error.localizedDescription, andViewController: self)
                print(error)
                
                break
            }
            
            
        })
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == name_tf){
            
            if let nxtField = name_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                name_tf.resignFirstResponder()
            }
        }
        else if (textField == jobTitle_tf){
            
            if let nxtField = jobTitle_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                jobTitle_tf.resignFirstResponder()
            }
        }
        else if (textField == company_tf){
            
            if let nxtField = company_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                company_tf.resignFirstResponder()
            }
        }
        else if (textField == email_tf){
            
            if let nxtField = email_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                email_tf.resignFirstResponder()
            }
        }
        else if (textField == phone_f){
            
            if let nxtField = phone_f.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                phone_f.resignFirstResponder()
            }
            
        }
        else if (textField == business_contact){
            
            if let nxtField = business_contact.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                business_contact.resignFirstResponder()
            }
            
        }
        else if (textField == country_tf){
            
            if let nxtField = country_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                country_tf.resignFirstResponder()
            }
            
        }
        else if (textField == companySize_tf){
            
            if let nxtField = companySize_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                companySize_tf.resignFirstResponder()
            }
            
        }
        else if (textField == industry_tf){
            
            if let nxtField = industry_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                industry_tf.resignFirstResponder()
            }
            
        }
        else if (textField == levelOfInterest_tf){
            
            if let nxtField = levelOfInterest_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                levelOfInterest_tf.resignFirstResponder()
            }
            
        }
        else if (textField == role_tf){
            
            if let nxtField = role_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                role_tf.resignFirstResponder()
            }
            
        }
            
        else if (textField == budget_tf){
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.resignFirstResponder()
            
        }
        
        return true
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
        
        if (textField == name_tf){
            
            self.name_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
        if (textField == jobTitle_tf){
            
            self.jobTitle_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
        }
        if (textField == company_tf){
            
            self.company_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
        }
        else if (textField == email_tf){
            
            self.email_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
        else if (textField == phone_f){
            
            self.phone_f.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
        else if (textField == business_contact){
            
            self.business_contact.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
            
        else if (textField == company_tf){
            
            self.company_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
        else if (textField == industry_tf){
            
            self.industry_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
            
        else if (textField == levelOfInterest_tf){
            
            self.levelOfInterest_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
            
        else if (textField == role_tf){
            
            self.role_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
            
        else if (textField == budget_tf){
            
            self.budget_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
            
            self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
            
            self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func setNotificationKeyboard ()  {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification)
    {
        var info = notification.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize!.height+10, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height + 5
        if let activeField = self.activeTextField
        {
            if (!aRect.contains(activeField.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    // when keyboard hide reduce height of scroll view
    @objc func keyboardWillBeHidden(notification: NSNotification){
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0,bottom: 0.0, right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.phone_f.layer.borderColor = UIColor.lightGray.cgColor

        self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
        
        self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
        
        self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.view.endEditing(true)
    }
    
    func setBorders(){
        
        self.name_tf.delegate = self
        self.jobTitle_tf.delegate = self
        self.company_tf.delegate = self
        self.email_tf.delegate = self
        self.phone_f.delegate = self
        self.business_contact.delegate = self
        self.country_tf.delegate = self
        companySize_tf.delegate = self
        industry_tf.delegate = self
        levelOfInterest_tf.delegate = self
        role_tf.delegate = self
        budget_tf.delegate = self
        
        
        let borderRaius = self.name_tf.frame.size.height / 2.0
        
        self.name_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.name_tf.layer.borderWidth = 1
        self.name_tf.layer.cornerRadius = borderRaius
        
        self.jobTitle_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.jobTitle_tf.layer.borderWidth = 1
        self.jobTitle_tf.layer.cornerRadius = borderRaius
        
        self.company_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.company_tf.layer.borderWidth = 1
        self.company_tf.layer.cornerRadius = borderRaius
        
        self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.email_tf.layer.borderWidth = 1
        self.email_tf.layer.cornerRadius = borderRaius
        
        self.phone_f.layer.borderColor = UIColor.lightGray.cgColor
        self.phone_f.layer.borderWidth = 1
        self.phone_f.layer.cornerRadius = borderRaius
        
        self.business_contact.layer.borderColor = UIColor.lightGray.cgColor
        self.business_contact.layer.borderWidth = 1
        self.business_contact.layer.cornerRadius = borderRaius
        
        self.country_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.country_tf.layer.borderWidth = 1
        self.country_tf.layer.cornerRadius = borderRaius
        
        self.companySize_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.companySize_tf.layer.borderWidth = 1
        self.companySize_tf.layer.cornerRadius = borderRaius
        
        self.industry_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.industry_tf.layer.borderWidth = 1
        self.industry_tf.layer.cornerRadius = borderRaius
        
        self.levelOfInterest_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.levelOfInterest_tf.layer.borderWidth = 1
        self.levelOfInterest_tf.layer.cornerRadius = borderRaius
        
        self.role_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.role_tf.layer.borderWidth = 1
        self.role_tf.layer.cornerRadius = borderRaius
        
        self.budget_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.budget_tf.layer.borderWidth = 1
        self.budget_tf.layer.cornerRadius = borderRaius
        
        self.nxt_btn.layer.cornerRadius = borderRaius
        
    }
    
    
    
}
