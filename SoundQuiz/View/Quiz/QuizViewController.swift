//
//  QuizViewController.swift
//  SoundQuiz
//
//  Created by koala panda on 2023/03/29.
//

import UIKit

class QuizViewController: UIViewController {

    static func makeFromStoryboard() -> QuizViewController {
        let vc = UIStoryboard(name: "Quiz", bundle: nil).instantiateInitialViewController() as! QuizViewController
        return vc
    }
    @IBAction func goNext(_ sender: Any) {
        Router.shared.showQuizExit(from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    

}
