//
//  wordCardView.swift
//  wordcard
//
//  Created by x15071xx on 2017/06/08.
//  Copyright © 2017年 AIT. All rights reserved.
//

import UIKit

class wordCardViewController: UIViewController, UITextFieldDelegate {
    
    var mode:Int = 0
    var wordData = WordData()
    var backButton: UILabel!
    var nextWordButton: UILabel!
    var backWordButton: UILabel!
    var maxLabel: UILabel!
    var nowLabel: UITextField!
    var cardLabel: UILabel!
    var word:[String]!
    var wordBool:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let statusBarH = UIApplication.shared.statusBarFrame.height
        //左上戻るボタン
        backButton = UILabel(frame: CGRect(x: 0, y: statusBarH, width: self.view.bounds.width/6, height: self.view.bounds.height/6))
            
        backButton.text = "終了"
        backButton.textColor = UIColor.black
        backButton.adjustsFontSizeToFitWidth = true
        backButton.textAlignment = NSTextAlignment.center
        //tapイベントの有効化
        backButton.isUserInteractionEnabled = true
        backButton.tag = 1
        
        self.view.addSubview(backButton)
        
        //左右の下あたりに次,前の単語に移る
        
        let widthB = self.view.bounds.width/4
        let heightB = self.view.bounds.height/8
        
        nextWordButton = UILabel(frame: CGRect(x: self.view.bounds.width-widthB, y: self.view.bounds.height-heightB, width: widthB, height: heightB))
        
        nextWordButton.text = ">"
        nextWordButton.adjustsFontSizeToFitWidth = true
        nextWordButton.textColor = UIColor.blue
        nextWordButton.textAlignment = NSTextAlignment.center
        //tapイベントの有効化
        nextWordButton.isUserInteractionEnabled = true
        nextWordButton.tag = 2
        
        self.view.addSubview(nextWordButton)
        
        backWordButton = UILabel(frame: CGRect(x: 0, y: self.view.bounds.height-heightB, width: widthB, height: heightB))
        
        backWordButton.text = "<"
        backWordButton.adjustsFontSizeToFitWidth = true
        backWordButton.textColor = UIColor.blue
        backWordButton.textAlignment = NSTextAlignment.center
        //tapイベントの有効化
        backWordButton.isUserInteractionEnabled = true
        backWordButton.tag = 3
        
        self.view.addSubview(backWordButton)

        //左右したボタンの中央に今何分の何とわかるようにする
        maxLabel =  UILabel(frame: CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height-heightB, width: widthB, height: heightB))
        let maxWordNum: String = wordData.retElementNum(mode: mode).description
        maxLabel.text = "/  " + maxWordNum
        maxLabel.adjustsFontSizeToFitWidth = true
        maxLabel.textColor = UIColor.blue
        maxLabel.textAlignment = NSTextAlignment.center

        self.view.addSubview(maxLabel)
        
        nowLabel = UITextField(frame: CGRect(x: self.view.bounds.width/2-widthB, y: self.view.bounds.height-heightB, width: widthB, height: heightB))
        print(mode)
        
        nowLabel.text = "1"
        nowLabel.delegate = self
        nowLabel.adjustsFontSizeToFitWidth = true
        nowLabel.textColor = UIColor.blue
        nowLabel.textAlignment = NSTextAlignment.center
        nowLabel.keyboardType = UIKeyboardType.numberPad
        
        self.view.addSubview(nowLabel)
        
        //中央に英語と日本語を出す画面
        cardLabel = UILabel(frame: CGRect(x: 0, y: statusBarH+backButton.bounds.height, width: self.view.bounds.width, height: self.view.bounds.width*3/4))
        
        cardLabel.adjustsFontSizeToFitWidth = true
        cardLabel.backgroundColor = UIColor.white
        cardLabel.textColor = UIColor.black
        cardLabel.textAlignment = NSTextAlignment.center
        
        let elenum = Int(nowLabel.text!)
        word = wordData.retWords(eleNum: elenum!, mode: mode)
        
        cardLabel.text = word[0]
        cardLabel.tag = 4
        
        //tapイベントの有効化
        cardLabel.isUserInteractionEnabled = true
        
        self.view.addSubview(cardLabel)
        
        self.addDoneButtonOnKeyboard()
        
    }
    
    //numberpad にUItoolbar を追加　して　Done ボタンをついか
    func addDoneButtonOnKeyboard() {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(wordCardViewController.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.nowLabel.inputAccessoryView = doneToolbar
    }
    
    func doneButtonAction() {
        self.nowLabel.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        
        let touch = touches.first
        
        if touch?.view?.tag == 1 { //戻るボタンが押されたら
            self.dismiss(animated: true, completion: nil)
        } else if touch?.view?.tag == 2 {
            var nowNum = Int(nowLabel.text!)
            let maxWordNum = wordData.retElementNum(mode: mode)
            if !(nowNum! >= maxWordNum) {
                nowNum = nowNum! + 1
                nowLabel.text = nowNum?.description
                
                word = wordData.retWords(eleNum: nowNum!, mode: mode)
                cardLabel.text = word[0]
                wordBool = true

            }
        } else if touch?.view?.tag == 3 {
            var nowNum = Int(nowLabel.text!)
            
            if !(nowNum! <= 1) {
                nowNum = nowNum! - 1
                nowLabel.text = nowNum?.description
                
                word = wordData.retWords(eleNum: nowNum!, mode: mode)
                cardLabel.text = word[0]
                wordBool = true

            }
        } else if touch?.view?.tag == 4 {
            if wordBool {
                cardLabel.text = word[1]
                wordBool = false
            } else {
                cardLabel.text = word[0]
                wordBool = true
            }
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        var nowNum = Int(nowLabel.text!)
        let maxWordNum = wordData.retElementNum(mode: mode)
        
        if nowNum! <= 1 || nowNum! >= maxWordNum {
            
            nowNum = 1
            
        }
        
        nowLabel.text = nowNum?.description
        
        word = wordData.retWords(eleNum: nowNum!, mode: mode)
        cardLabel.text = word[0]
        wordBool = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
