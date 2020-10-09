//
//  TextViewController.swift
//  
//
//  Created by Tutku Bide on 24.08.2020.
//

import UIKit
import Parse

class CreateDocumentViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textViewInput: UITextView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var editViewBottom: NSLayoutConstraint!
    
    var boldClick = true
    var italicClick = true
    var leftAligmentClick = true
    var underLineClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let showNotification = NotificationCenter.default
        showNotification.addObserver(self,
                                     selector: #selector(handleKeybordNotification),
                                     name: UIWindow.keyboardWillShowNotification,
                                     object: nil)
        let hideNotification = NotificationCenter.default
        hideNotification.addObserver(self,
                                     selector: #selector(handleKeybordNotification),
                                     name: UIWindow.keyboardWillHideNotification,
                                     object: nil)
        textViewInput.delegate = self
    }
    
    @objc func handleKeybordNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let keybordSize = userInfo[UIWindow.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keybordFrame = keybordSize.cgRectValue
            let isKeybordShowing = notification.name == UIWindow.keyboardWillShowNotification
            editViewBottom.constant = isKeybordShowing ? -keybordFrame.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completion) in
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        editView.transform = .identity
    }
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func boldButton(_ sender: Any) {
        if boldClick == true {
            textViewInput.font = UIFont.boldSystemFont(ofSize: 18)
            boldClick = !boldClick
        }else{
            textViewInput.font = UIFont.systemFont(ofSize: 18)
            boldClick = true
        }
    }
    
    @IBAction func italicButton(_ sender: Any) {
        if italicClick == true {
            textViewInput.font = UIFont.italicSystemFont(ofSize: 18)
            italicClick = !italicClick
        }else{
            textViewInput.font = UIFont.systemFont(ofSize: 18)
            italicClick = true
        }
    }
    
    @IBAction func underLineButton(_ sender: Any) {
        if underLineClick == true {
            textViewInput.attributedText = NSAttributedString(string: textViewInput.text, attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
            underLineClick = !underLineClick
        }else{
            textViewInput.attributedText = NSAttributedString(string: textViewInput.text, attributes: .none)
            textViewInput.font = UIFont.systemFont(ofSize: 14)
            underLineClick = true
        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let textObject = PFObject(className: "Posts")
        let uuid = UUID().uuidString
        let uuidPost = "\(uuid) \(PFUser.current()!.username ?? "")"
        textObject["postUUID"] = uuidPost
        textObject["topics"] = topicTextField.text!
        textObject["texts"] = textViewInput.text!
        textObject["postOwner"] = PFUser.current()!.username
        textObject["FavoriListesi"] = ""
        textObject.saveInBackground { (success, error) in
            if error != nil {
                print("error")
            }else{
                print("uploaded")
                
                self.dismiss(animated: true, completion: nil)
              
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"), object: nil)
            }
        }
        PFUser.current()!.setObject(topicTextField.text!, forKey: "postOwnerTopic")
        PFUser.current()!.saveInBackground { (success, error) in
            if error != nil {
                print("error")
            }else{
    
                print("upload text")
                
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Yazmak İçin Dokun" {
            textView.text = ""
            textView.textColor = .black
            textView.font = UIFont(name: "verdana", size: 16.0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Yazmak İçin Dokun"
            textView.textColor = .lightGray
            textView.font = UIFont(name: "verdana", size: 16.0)
        }
    }
}
