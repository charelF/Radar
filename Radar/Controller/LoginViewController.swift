//
//  LoginViewController.swift
//  Radar
//
//  Created by Charel FELTEN on 24/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

//import UIKit
//
//class LoginViewController: UIViewController {
//    
//    @IBOutlet weak var loginTextField: UITextField!
//    
//    @IBAction func connectButton(_ sender: Any) {
//        
//        DataBase.data.login(username: loginTextField.text!, completion: { succes in
//            if succes {
//                self.startApp()
//            } else {
//                print("error with logging in")
//            }
//        })
//    }
//    
//    func startApp() {
//        // https://stackoverflow.com/questions/28631345/swift-call-segue-inside-of-a-closure
//        performSegue(withIdentifier: "startApp", sender: self)
//    }
//    
//}
