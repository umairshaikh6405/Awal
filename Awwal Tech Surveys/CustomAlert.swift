//
//  CustomAlert.swift
//  Lensofy
//
//  Created by Aamir Shaikh on 11/3/17.
//  Copyright © 2017 Gexton. All rights reserved.
//

import UIKit
//import SCLAlertView
import NVActivityIndicatorView

class CustomAlert: NSObject {

    public static var overLayView: UIView?
    public static var indicatorView: NVActivityIndicatorView?
    public static var animationTypeLabel: UILabel?
    
//    class func showInfo(_ title: String, message: String){
//        SCLAlertView().showInfo(title, subTitle: message)
//    }
//
//    class func showSuccess(_ title: String, message: String){
//        SCLAlertView().showSuccess(title, subTitle: message)
//    }
//
//    class func showError(_ title: String, message: String){
//        SCLAlertView().showError(title, subTitle: message)
//    }
//
//    class func showAlert(){
//        SCLAlertView().showSuccess("Hello World", subTitle: "This is a more descriptive text.")
//    }
//
//
//    class func showNoInternetAlert(viewController vc: UIViewController) {
//        SCLAlertView().showError("No Internet!", subTitle: "Your device has no internet connection.")
//    }
//
//    class func showConfirmationAlert(viewController vc: UIViewController, title: String, message: String, button1Title: String, block1: @escaping () -> Void, button2Title: String, block2: @escaping () -> Void) {
//        let appearance = SCLAlertView.SCLAppearance(
//            showCloseButton: false
//        )
//        let alertView = SCLAlertView(appearance: appearance)
//        alertView.addButton(button1Title, action: block1)
//        alertView.addButton(button2Title, action: block2)
//        alertView.showSuccess(title, subTitle: message)
//    }
    
    
    class func showLoader(viewController: UIViewController){


        
        if CustomAlert.indicatorView?.isAnimating == true{
            
            CustomAlert.indicatorView?.stopAnimating()
            CustomAlert.animationTypeLabel?.removeFromSuperview()
            CustomAlert.overLayView?.removeFromSuperview()
//            CustomAlert.overLayView?.isUserInteractionEnabled = false
            CustomAlert.indicatorView?.removeFromSuperview()
            self.overLayView?.removeFromSuperview()
//            CustomAlert.overLayView?.removeBlur()

//            CustomAlert.removeObserver(CustomAlert)
        



//            self.dismissLoader()
            
        }
        
        
        overLayView = UIView.init(frame: viewController.view.frame)
        CustomAlert.overLayView?.isUserInteractionEnabled = true
        CustomAlert.overLayView?.blur(effectStyle: .dark)
        
        let frame = CGRect.init(x: viewController.view.frame.size.width/2 - 25, y: viewController.view.frame.size.height/2 - 25, width: 50, height: 50)
        
//        indicatorView = NVActivityIndicatorView
        
        indicatorView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.ballRotateChase, color: UIColor.trendingTubes.redColor, padding: 10.0)
        
        let labelFrame = CGRect.init(x: viewController.view.frame.size.width/2 - 50, y: viewController.view.frame.size.height/2 + 35, width: 100, height: 50)
        
        CustomAlert.animationTypeLabel = UILabel(frame: labelFrame)
        
        CustomAlert.animationTypeLabel?.text = "Please wait" //"Please wait..."
        CustomAlert.animationTypeLabel?.sizeToFit()
        CustomAlert.animationTypeLabel?.textColor = UIColor.trendingTubes.redColor
        CustomAlert.animationTypeLabel?.textAlignment = .center
        
        viewController.view.addSubview(CustomAlert.overLayView!)
        viewController.view.addSubview(CustomAlert.indicatorView!)
        viewController.view.addSubview(CustomAlert.animationTypeLabel!)
        
        CustomAlert.indicatorView?.startAnimating()
            
        
        
    }
    
    class func dismissLoader(){
        
    
        CustomAlert.indicatorView?.stopAnimating()
        CustomAlert.animationTypeLabel?.removeFromSuperview()
        CustomAlert.indicatorView?.removeFromSuperview()
        CustomAlert.overLayView?.removeFromSuperview()
//        CustomAlert.overLayView?.removeBlur()
    }
    
    
    
}

public extension UIView {
    
    func blur(effectStyle: UIBlurEffect.Style){
        let blurEffect = UIBlurEffect(style: effectStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.2
        self.addSubview(blurEffectView)
    }
    
//    func removeBlur(){
//
////        let blurEffectView = UIVisualEffectView(frame: self.bounds)
//        self.removeFromSuperview
//    }
    
    
}
