//
//  ViewController.swift
//  wordcard
//
//  Created by x15071xx on 2017/06/08.
//  Copyright © 2017年 AIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    var firstLabel: UILabel!
    var secondLabel: UILabel!
    var thirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewX = self.view.bounds.width / 4
        let viewY = self.view.bounds.height / 12
        
        firstLabel = UILabel(frame: CGRect(x: viewX, y: viewY*2, width: viewX*2, height: viewY*2))
        
        firstLabel.backgroundColor = UIColor.orange
        
        firstLabel.textColor = UIColor.white
        firstLabel.text = "1年生"
        firstLabel.textAlignment = NSTextAlignment.center
        //tapイベントの有効化
        firstLabel.isUserInteractionEnabled = true
        firstLabel.tag = 1
        
        self.view.addSubview(firstLabel)
        
        secondLabel = UILabel(frame: CGRect(x: viewX, y: viewY*6, width: viewX*2, height: viewY*2))
        
        secondLabel.backgroundColor = UIColor.orange
        
        secondLabel.textColor = UIColor.white
        secondLabel.text = "2年生"
        secondLabel.textAlignment = NSTextAlignment.center
        //tapイベントの有効化
        secondLabel.isUserInteractionEnabled = true
        secondLabel.tag = 2
        
        self.view.addSubview(secondLabel)
        
        thirdLabel = UILabel(frame: CGRect(x: viewX, y: viewY*10, width: viewX*2, height: viewY*2))
        
        thirdLabel.backgroundColor = UIColor.orange
        
        thirdLabel.textColor = UIColor.white
        thirdLabel.text = "3年生"
        thirdLabel.textAlignment = NSTextAlignment.center
        //tapイベントの有効化
        thirdLabel.isUserInteractionEnabled = true
        thirdLabel.tag = 3
        
        self.view.addSubview(thirdLabel)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        
        let touch = touches.first
        
        if touch?.view?.tag == 1 {
            //1年生に画面遷移
            print("画面遷移");
            //遷移するviewのインスタンス化
            let wordView = wordCardViewController()
            
            wordView.mode = 1
            
            wordView.transitioningDelegate = self
            self.present(wordView, animated: true, completion: nil)
            
        } else if touch?.view?.tag == 2 {
            //2年生に画面遷移
            print("画面遷移");
            //遷移するviewのインスタンス化
            let wordView = wordCardViewController()
            
            wordView.mode = 2
            
            wordView.transitioningDelegate = self
            self.present(wordView, animated: true, completion: nil)
        } else if touch?.view?.tag == 3 {
            //3年生に画面遷移
            print("画面遷移");
            //遷移するviewのインスタンス化
            let wordView = wordCardViewController()
            
            wordView.mode = 3
            
            wordView.transitioningDelegate = self
            self.present(wordView, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

