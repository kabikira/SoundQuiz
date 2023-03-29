//
//  SecondTimeViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit

class SecondTimeViewController: UIViewController {

    static func makeFromStoryboard() -> SecondTimeViewController {
        let vc = UIStoryboard(name: "SecondTime", bundle: nil).instantiateInitialViewController() as! SecondTimeViewController
        return vc
    }
    
    
    @IBAction func goNext(_ sender: Any) {
        Router.shared.showQuiz(from: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    

   

}
