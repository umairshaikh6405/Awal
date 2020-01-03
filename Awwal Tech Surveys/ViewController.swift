//
//  ViewController.swift
//  Awwal Tech Surveys
//
//  Created by Aamir Shaikh on 9/27/19.
//  Copyright © 2019 Gexton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
                 self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.navigate), userInfo: nil, repeats: true)
    }
    
    @objc func navigate() {
        
        self.timer?.invalidate()
        
        
        if AppDataSwift.userDefault.bool(forKey: "isLogin"){
            
            AppDataSwift.gotoUserDetailController(withNavigationController: self.navigationController!, andIsAnimated: true)
        }
        else
        {
            
            AppDataSwift.gotoLoginController(withNavigationController: self.navigationController!, andIsAnimated: true)

        }
        
        
//        if (AppSwiftData.userDefault.userDefault?.bool(forKey: "isLogin"))! {
//
//            AppDataSwift.gotoHomeController(withNavigationController: self.navigationController!, andIsAnimated: true)
//
//        }else{
//
//
//            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainLoginViewController") as! MainLoginViewController
//
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        }
        
    }


}

