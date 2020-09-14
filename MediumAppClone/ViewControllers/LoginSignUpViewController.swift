//
//  LoginSignUpViewController.swift
//  MediumAppClone
//
//  Created by Tutku Bide on 25.08.2020.
//  Copyright © 2020 Tutku Bide. All rights reserved.
//

import UIKit
import Parse

class LoginSignUpViewController: UIViewController {
    
    @IBOutlet weak var signInPasswordTextfield: UITextField!
    @IBOutlet weak var signInMailTextField: UITextField!
    @IBOutlet weak var againPasswordTextfield: UITextField!
    @IBOutlet weak var signUpPasswordTextfield: UITextField!
    @IBOutlet weak var signupMailTextField: UITextField!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var signUpNameTextield: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var loginInfoLabel: UILabel!
    @IBOutlet weak var signInInfoLabel: UILabel!
    
    var loginAnimateActive = true
    var signUpAnimateActive = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let signUpRecognizer = UITapGestureRecognizer(target: self, action: #selector(signUpViewTapped))
        signUpView.addGestureRecognizer(signUpRecognizer)
        let signInRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignInViewTapped))
        loginView.addGestureRecognizer(signInRecognizer)
        statusOfTheScreen()
        showAndHideKeybord()
        let hideKeybord = UITapGestureRecognizer(target: self, action: #selector(
            hideKeybordFunc(_:)))
        view.addGestureRecognizer(hideKeybord)
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    @objc func hideKeybordFunc(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func showAndHideKeybord() {
        let showNotification = NotificationCenter.default
        showNotification.addObserver(self,
                                     selector: #selector(keyboardWillShow),
                                     name: UIWindow.keyboardWillShowNotification,
                                     object: nil)
        
        let hideNotification = NotificationCenter.default
        hideNotification.addObserver(self,
                                     selector: #selector(keyboardWillHide(notification:)),
                                     name: UIWindow.keyboardWillHideNotification,
                                     object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.signUpView.frame.origin.y -= view.frame.origin.y + 150
            self.loginView.frame.origin.y -= view.frame.origin.y + 150
        }
    }
    
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    private func statusOfTheScreen() {
        signUpView.transform = CGAffineTransform(translationX: -view.bounds.width/2, y: 0)
        registerLabel.transform = CGAffineTransform(translationX: view.bounds.width/4.8, y: 0)
        loginInfoLabel.transform = .identity
        stackView.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        okButton.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        welcomeLabel.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        leftButton.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        loginView.transform = CGAffineTransform(translationX: view.bounds.width/2, y: 0)
        loginLabel.transform = CGAffineTransform(translationX: -view.bounds.width/4.8, y: 0)
        loginStackView.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        loginButton.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        welcomeLabel.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        signInInfoLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        signInInfoLabel.transform = .identity
    }
    
    private func signInOriginalConstraints() {
        loginView.transform = .identity
        loginStackView.transform = .identity
        loginLabel.transform = .identity
        loginButton.transform = .identity
        leftButton.transform = .identity
        loginInfoLabel.transform = .identity
        signInInfoLabel.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
        welcomeLabel.transform = .identity
        signUpView.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        registerLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        stackView.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        okButton.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        hiLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        leftButton.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        leftButton.transform = .identity
    }
    
    private func signUpOriginalConstraints() {
        signUpView.transform = .identity
        stackView.transform = .identity
        registerLabel.transform = .identity
        okButton.transform = .identity
        hiLabel.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
        welcomeLabel.transform = .identity
        leftButton.transform = .identity
        signInInfoLabel.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
        loginView.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        loginLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        loginStackView.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        loginButton.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        loginInfoLabel.transform = CGAffineTransform(translationX: view.bounds.width*2, y: 0)
    }
    
    @objc func SignInViewTapped() {
        if loginAnimateActive == true {
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.signInOriginalConstraints()
            }, completion: nil)
        }
    }
    
    
    @objc func signUpViewTapped() {
        if signUpAnimateActive == true {
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.signUpOriginalConstraints()
            }, completion: nil)
        }
    }
    
    @IBAction func leftButton(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            self.statusOfTheScreen()
            self.hiLabel.transform = .identity
        }, completion: nil)
        
    }
    @IBAction func signInButton(_ sender: Any) {
        signInTapped()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        signUpTapped()
    }
    
    func signInTapped() {
        if signInMailTextField.text != nil && signInPasswordTextfield.text != nil{
            PFUser.logInWithUsername(inBackground: signInMailTextField.text!, password: signInPasswordTextfield.text!) { (success, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okButton)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    self.performSegue(withIdentifier: "toCircleVC", sender: nil)
                }
            }
        }else{
            let alert = UIAlertController(title: "Hata", message: "hataloı", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func signUpTapped() {
        if signUpNameTextield.text != "" && signupMailTextField.text != "" && signUpNameTextield.text != "" {
            if signUpPasswordTextfield.text == againPasswordTextfield.text! {
                let user = PFUser()
                user.username = signUpNameTextield.text!
                user.password = signUpPasswordTextfield.text!
                user.email = signupMailTextField.text!
                
                user.signUpInBackground { (success, error) in
                    if error != nil {
                        let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        DispatchQueue.main.async {
                            let board = UIStoryboard(name: "Main", bundle: nil)
                            let tabBar = board.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                            self.navigationController?.pushViewController(tabBar, animated: true)
                        }
                        
                    }
                }
            }else{
                let alert = UIAlertController(title: "Hata", message: "Şifreler Eşleşmiyor", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Hata", message: "Boş Alan Bıraktınız", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
