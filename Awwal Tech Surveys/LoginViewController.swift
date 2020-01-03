//
//  LoginViewController.swift
//  Awwal Tech Surveys
//
//  Created by Aamir Shaikh on 9/27/19.
//  Copyright © 2019 Gexton. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MRProgress

class LoginViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var email_tf: UITextField!
    @IBOutlet weak var pass_tf: UITextField!
    @IBOutlet weak var signIn_btn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var activeTextField: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        scrollView.addGestureRecognizer(tap)
        
        self.setNotificationKeyboard()
        
        setBorders()
    }
    
    
    @IBAction func signIn_Action(_ sender: Any) {
        
        //        AppDataSwift.gotoUserDetailController(withNavigationController: self.navigationController!, andIsAnimated: true)
        
        //        if self.email_tf.text == ""{
        //
        //                 AppSwiftData.shakeTextField(self.email_tf)
        //             }
        //             else if self.pass_tf.text == ""{
        //
        //                 AppSwiftData.shakeTextField(self.pass_tf)
        //             }
        //             else{
        
        self.DOLOGIN(email: self.email_tf.text!, password: self.pass_tf.text!)
        //             }
    }
    
    
    func DOLOGIN(email : String, password: String){
        
        
        CustomAlert.showLoader(viewController: self)
        
        var parameters : [String:String]? = [String: String]()
               parameters!["username"] = email
               parameters!["password"] = password
        
        
        let loginURL = "http://app.awwalsurvey.com/admin/api/get_login.php?"
        
        
        AF.request(loginURL, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response in
            
            switch response.result{
                
            case .success(let value):
                
                //                AppSwiftData/.dismissLoader(self)
                CustomAlert.dismissLoader()
                
                let json = JSON(value)
                print(json)
                
                if json["status"].stringValue == "N"{
                    
                    AppDataSwift.showAlert("Error", andMsg: json["message"].stringValue, andViewController: self)
                }
                else
                {
                    
//                    for loginData in data{
//
                    
                    let company_details = json["data"]["company_details"].stringValue
                    let campaign_id = json["data"]["campaign_id"].stringValue
                    let company_name = json["data"]["company_name"].stringValue
                    let company_logo = json["data"]["company_logo"].stringValue
                    let company_id = json["data"]["company_id"].stringValue
                    let agent_id = json["data"]["agent_id"].stringValue

//
                    AppDataSwift.userDefault.set(company_details, forKey: "companyDetails")
                    AppDataSwift.userDefault.set(campaign_id, forKey: "campaignId")
                    AppDataSwift.userDefault.set(company_name, forKey: "companyName")
                    AppDataSwift.userDefault.set(company_logo, forKey: "companyLogo")
                    AppDataSwift.userDefault.set(company_id, forKey: "companyId")
                    AppDataSwift.userDefault.set(agent_id, forKey: "agentID")
//
//
//
//                    }
                    
                    AppDataSwift.userDefault.set(true, forKey: "isLogin")
                    
                    AppDataSwift.gotoUserDetailController(withNavigationController: self.navigationController!, andIsAnimated: true)
                    
//                     AppDataSwift.gotoSurvryForm(withNavigationController: self.navigationController!, andIsAnimated: true)
                    
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
        
        if (textField == email_tf){
            
            
            
            if let nxtField = email_tf.superview?.viewWithTag(textField.tag + 1) as? UITextField{
                
                nxtField.becomeFirstResponder()
            }
            else{
                
                email_tf.resignFirstResponder()
            }
        }
        else if (textField == pass_tf){
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            self.pass_tf.layer.borderColor = UIColor.lightGray.cgColor
            pass_tf.resignFirstResponder()
        }
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
        
        if (textField == email_tf){
            
            self.email_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
            self.pass_tf.layer.borderColor = UIColor.lightGray.cgColor
            
        }
        else if (textField == pass_tf){
            
            self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
            
            self.pass_tf.layer.borderColor = UIColor(red: 229/255, green: 28/255, blue: 0/255, alpha: 1).cgColor
            
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
        self.pass_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.view.endEditing(true)
    }
    
    func setBorders(){
        
        self.email_tf.delegate = self
        self.pass_tf.delegate = self
        
        
        let borderRaius = self.email_tf.frame.size.height / 2.0
        
        self.email_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.email_tf.layer.borderWidth = 1.5
        self.email_tf.layer.cornerRadius = borderRaius
        self.pass_tf.layer.borderColor = UIColor.lightGray.cgColor
        self.pass_tf.layer.borderWidth = 1.5
        self.pass_tf.layer.cornerRadius = borderRaius
        
        self.signIn_btn.layer.cornerRadius = borderRaius
        
        //           AppDataa.setBorderWith(self.email_tf, andBorderWidth: 1.5, andBorderColor: .lightGray, andBorderRadius: borderRaius)
        //           AppDataa.setBorderWith(self.pass_tf, andBorderWidth: 1.5, andBorderColor: .lightGray, andBorderRadius: borderRaius)
        //
        //           AppDataa.setBorderWith(self.signIn_btn, andBorderWidth: 1.0, andBorderColor: .clear, andBorderRadius: borderRaius)
        
        self.email_tf.setIcon(#imageLiteral(resourceName: "user"))
        self.pass_tf.setIcon(#imageLiteral(resourceName: "lock"))
    }
    
    
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 20, y: 5, width: image.size.width, height: image.size.height))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
    func setIconRight(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 20, y: 5, width: image.size.width, height: image.size.height))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 50, height: 30))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}
