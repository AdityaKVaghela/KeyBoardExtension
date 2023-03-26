//
//  KeyboardViewController.swift
//  keaBoard
//
//  Created by Aditya on 2022-03-09.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    var keyboardView = UIView()
    var isSwiftPressed = false
    var iscapitalize = false
    var counter = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
        // Perform custom UI setup here
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let desiredHeight:CGFloat!
        if UIDevice.current.userInterfaceIdiom == .phone{
            desiredHeight = 230
            
        }else{
            if UIDevice.current.orientation == .portrait{
                desiredHeight = 230
                
            }else {
                desiredHeight = 230
                
            }
        }
        let heightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: desiredHeight)
        view.addConstraint(heightConstraint)
        
        if let stackView = self.keyboardView.viewWithTag(101) as? UIStackView{
            
            //            stackView.frame = CGRectMake(-500, stackView.frame.origin.y, stackView.frame.width, stackView.frame.height)
            stackView.frame.origin.x = -UIScreen.main.bounds.width
            //            self.isShowInputText = false
            //            stackView.frame.origin.x -= UIScreen.main.bounds.width
            print(stackView.frame.origin.x)
        }
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        
        if proxy.returnKeyType == .search {
            print("seach")
        } else {
            print("return")
        }
        
    }
    func loadInterface() {
        // load the nib file
        let customKeyBoard = UINib(nibName: "KeyBoardView", bundle: nil)
        // instantiate the view
        keyboardView = customKeyBoard.instantiate(withOwner: self, options: nil)[0] as! UIView
        keyboardView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 360)
        // add the interface to the main view
        view.addSubview(keyboardView)
        for iTag in buttons.allCases {
            if let iButton  = keyboardView.viewWithTag(iTag.rawValue) as? UIButton{
                iButton.layer.cornerRadius = 6
                
                switch iTag.rawValue {
                case 42:
                    iButton.addTarget(self, action: #selector(spaceBtnTapped(_:)), for: .touchUpInside)
                case 39:
                    iButton.isUserInteractionEnabled = true
                    let singleTap = UITapGestureRecognizer(target: self, action:#selector(self.singleTapAction(_:)))
                    singleTap.numberOfTapsRequired = 1
                    iButton.addGestureRecognizer(singleTap)

                    let doubleTap = UITapGestureRecognizer(target: self, action:#selector(self.doubleTapAction(_:)))
                    doubleTap.numberOfTapsRequired = 2
                    iButton.addGestureRecognizer(doubleTap)

                    singleTap.require(toFail: doubleTap)
//                    iButton.addTarget(self, action: #selector(shiftBtnTapped(_:event:)), for: .touchUpInside)
                case 40:
                    iButton.addTarget(self, action: #selector(backBtnTapped(_:)), for: .touchUpInside)
                case 43:
                    iButton.addTarget(self, action: #selector(returnBtntapped(_:)), for: .touchUpInside)
                   
                default:
                    iButton.addTarget(self, action: #selector(btnWasTapped(_:)), for: .touchUpInside)
                }
            }
            
        }
        
        // copy the background color
        view.backgroundColor = keyboardView.backgroundColor
    }
    @objc func singleTapAction(_ sender: UIButton){
//        isSwiftPressed = iscapitalize && isSwiftPressed ? false : true
//        if iscapitalize{
//            iscapitalize = false
//            isSwiftPressed = false
//            counter = false
//        }
//        else{
//            isSwiftPressed = !isSwiftPressed
//            counter = true
//
//        }
//
////        isSwiftPressed = iscapitalize ? false : true
//        for iTag in buttons.allCases {
//            if let iButton = self.keyboardView.viewWithTag(iTag.rawValue) as? UIButton{
//                guard let btnTitle = isSwiftPressed ?  iButton.titleLabel?.text?.uppercased() : iButton.titleLabel?.text?.lowercased() else {
//                    return
//                }
//                iButton.setTitle(btnTitle, for: .normal)
//            }
//        }
            
        print("shift")
        if iscapitalize{
            iscapitalize = false
            isSwiftPressed = false
            counter = false
        }
        else{
            isSwiftPressed = !isSwiftPressed
            counter = true
        }
        
        for iTag in buttons.allCases {
            print(iTag)
            if let iButton = self.keyboardView.viewWithTag(iTag.rawValue) as? UIButton{
                guard let btnTitle = isSwiftPressed ?  iButton.titleLabel?.text?.uppercased() : iButton.titleLabel?.text?.lowercased() else {
                    return
                }
                print(btnTitle)
                iButton.setTitle(btnTitle, for: .normal)
            }
        }
      
       
    }
    @objc func doubleTapAction(_ sender: UIButton){
        iscapitalize = !iscapitalize
        counter = false
        isSwiftPressed = false
        for iTag in buttons.allCases {
            if let iButton = self.keyboardView.viewWithTag(iTag.rawValue) as? UIButton{
                guard let btnTitle =   iButton.titleLabel?.text?.uppercased() else {
                    return
                }
                iButton.setTitle(btnTitle, for: .normal)
            }
        }
    }
    @objc func backBtnTapped(_ sender: UIButton){
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    @objc func spaceBtnTapped(_ sender: UIButton){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText(" ")
        
    }
    @objc func returnBtntapped(_ sender: UIButton){
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("\n")
        
    }
    @objc func btnWasTapped(_ sender: UIButton){
//        isSwiftPressed = !isSwiftPressed
        let proxy = textDocumentProxy as UITextDocumentProxy
        
        if let input = sender.titleLabel?.text as String? {
            proxy.insertText(input)
        }

        if counter == true {
            for iTag in buttons.allCases {
                if let iButton = self.keyboardView.viewWithTag(iTag.rawValue) as? UIButton{

                    guard let btnTitle = iButton.titleLabel?.text?.lowercased() else {
                        return
                    }
                    iButton.setTitle(btnTitle, for: .normal)
                    isSwiftPressed = false
                }
            }
        }
       
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
    }
    
}
