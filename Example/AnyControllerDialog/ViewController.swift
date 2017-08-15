//
//  ViewController.swift
//  AnyControllerDialog
//
//  Created by npu3pak on 08/15/2017.
//  Copyright (c) 2017 npu3pak. All rights reserved.
//

import UIKit
import AnyControllerDialog

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onShowDialogButtonClick(_ sender: Any) {
        let dialogContent = storyboard?.instantiateViewController(withIdentifier: "DialogContent")
        
        showDialog(dialogContent!, height: 200, width: 200, top: 70, completion: {print("Presented!")})
    }
    
    @IBAction func onShowTransparentDialogButtonClick(_ sender: Any) {
        let dialogContent = storyboard?.instantiateViewController(withIdentifier: "TransparentDialogContent")
        
        showDialog(dialogContent!, height: 200, width: 200, top: 100, completion: {print("Presented!")})
    }
    
}

