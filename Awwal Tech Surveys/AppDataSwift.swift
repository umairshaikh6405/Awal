//
//  AppDataSwift.swift
//  Awwal Tech Surveys
//
//  Created by Aamir Shaikh on 9/28/19.
//  Copyright © 2019 Gexton. All rights reserved.
//

import UIKit

class AppDataSwift: NSObject {
    
    public static let userDefault = UserDefaults.standard

    
    public static func gotoLoginController(withNavigationController navigationController: UINavigationController, andIsAnimated animated: Bool){
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        navigationController.pushViewController(vc, animated: animated)
    }
    
    
    public static func gotoUserDetailController(withNavigationController navigationController: UINavigationController, andIsAnimated animated: Bool){
           
           let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
           
           navigationController.pushViewController(vc, animated: animated)
       }
    
    public static func gotoSurvryForm(withNavigationController navigationController: UINavigationController, andIsAnimated animated: Bool){
              
              let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyFormViewController") as! SurveyFormViewController
              
              navigationController.pushViewController(vc, animated: animated)
          }
       
    
//    public static func gotoSurveyFormController(withNavigationController navigationController: UINavigationController, andIsAnimated animated: Bool){
//            
//            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SurveyViewController") as! SurveyViewController
//            
//            navigationController.pushViewController(vc, animated: animated)
//        }

    
    public static func goBack(withNavigationController navigationController: UINavigationController, andIsAnimated animated: Bool){
        
        navigationController.popViewController(animated: animated)
    }
    
    public static func shakeTextField(_ txtField: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        // animation.
        animation.autoreverses = true
        animation.fromValue = NSValue.init(cgPoint: CGPoint.init(x: txtField.center.x - 10, y: txtField.center.y))
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: txtField.center.x + 10, y: txtField.center.y))
        txtField.layer.add(animation, forKey: "position")
    }

    public static func showAlert(_ title: String, andMsg msg: String, andViewController vc: UIViewController) {
        let alertController = UIAlertController.init(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let alertActionOK = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertActionOK)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
}
