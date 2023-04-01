//
//  StartUpViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit

class StartUpViewController: UIViewController {
    
    static func makeFromStoryboard() -> StartUpViewController {
        let vc = UIStoryboard(name: "StartUp", bundle: nil).instantiateInitialViewController() as! StartUpViewController
        return vc
    }
    @IBAction func goNext(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "logined")
        
        Router.shared.showSecondTime(from: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

    }
    

}
