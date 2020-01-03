//
//  AppSwiftData.swift
//  Trending Tubes
//
//  Created by Aamir Shaikh on 11/9/18.
//  Copyright © 2018 Gexton. All rights reserved.
//

import Foundation


//import Foundation
import UIKit
import MRProgress
import Alamofire
import SwiftyJSON
//import ANLoader
//import NVActivityIndicatorView




public class AppSwiftData{
    
    public static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView();
    public static var overlay = MRProgressOverlayView()
    
//    static var userDefault = AppUserDefault()

  
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
    
    public static func showAlertDialog(title :String,msg :String,viewController vc: UIViewController){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
        
        // let DestructiveAction = UIAlertAction(title: "Destructive", style: UIAlertActionStyle.destructive) {
        // (result : UIAlertAction) -> Void in
        // print("Destructive")
        // }
        
        // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        // alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        vc.present(alertController, animated: true, completion: nil)
    }
   
    
}


