//
//  ViewController.swift
//  Meme1.0
//
//  Created by  AminSaleh on 27/02/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //Defalut attributes for the text field
    
    let memeTextAttributes:[NSAttributedString.Key: Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 45)!,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): 5
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topText.delegate = self
        bottomText.delegate = self
        
        topText.textAlignment = NSTextAlignment.center
        topText.text = "TOP"
        bottomText.textAlignment = NSTextAlignment.center
        bottomText.text = "BOTTOM"
        
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        
        uiShareCancelState(0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    @IBAction func picImg(_ sender: Any) {
       let imgPicker = UIImagePickerController()
       imgPicker.delegate = self
       present(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func camPicImg(_ sender: Any) {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = UIImagePickerController.SourceType.camera
        imgPicker.delegate = self
        uiShareCancelState(1)
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    // image picker delegate implemented functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePicked.image = img
            uiShareCancelState(1)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    //text field delegate implemented functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"
        {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Share image with texts
    
    @IBAction func shareImage(_ sender: Any) {
        
        let imageTemp = save()
        let activityVC = UIActivityViewController(activityItems: [imageTemp], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    //Rest image and texts
    
    @IBAction func cancel(_ sender: Any) {
        
        imagePicked.image = UIImage.init()
        topText.textAlignment = NSTextAlignment.center
        topText.text = "TOP"
        bottomText.textAlignment = NSTextAlignment.center
        bottomText.text = "BOTTOM"
        uiShareCancelState(0)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //UI share and cancel state on or off
    
    func uiShareCancelState(_ zeroOrOne: Int)
    {
        if zeroOrOne == 0
        {
            shareButton.isEnabled = false
            cancelButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
            cancelButton.isEnabled = true
        }
    }
    
}

extension ViewController {
    
    //save pic
    
    struct Meme {
        let topText: String
        let bottomText: String
        let originalImage: UIImage
        let memedImage: UIImage
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        topToolBar.isHidden = true
        bottomToolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show toolbar and navbar
        topToolBar.isHidden = false
        bottomToolBar.isHidden = false
        
        return memedImage
    }
    
    func save() -> UIImage {
        // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePicked.image!, memedImage: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print(appDelegate.memes.count)
        
        return meme.memedImage
    }
    
}

extension ViewController {
    
    //hide keyboard-----------------------------------------------------
    @objc func keyboardWillHide(_ notification:Notification)
    {
        view.frame.origin.y = 0
    }
    
    //show Keyboard------------------------------------------------------
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomText.isEditing{
            view.frame.origin.y = -getKeyboardHeight(notification)
        }else{
            view.frame.origin.y = 0
        }
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}
