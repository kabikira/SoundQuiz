//
//  QuizExitViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit

class QuizExitViewController: UIViewController {
    
    static func makeFromStoryboard() -> QuizExitViewController {
            let vc = UIStoryboard(name: "QuizExit", bundle: nil).instantiateInitialViewController() as! QuizExitViewController
            return vc
        }
    
    @IBAction func reSetUser(_ sender: Any) {
        Router.shared.showReStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    


}
