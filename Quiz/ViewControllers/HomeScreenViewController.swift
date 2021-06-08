//
//  ViewController.swift
//  Quiz
//
//  Created by YURY PROSVIRNIN on 24.05.2021.
//

import UIKit

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.overrideUserInterfaceStyle = .dark
        
        logoImage.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 3) {
            self.logoImage.alpha = 1
            self.logoImage.contentMode = .scaleAspectFit
        }
    }
        
    
    
}

