//
//  ViewController.swift
//  Quiz
//
//  Created by YURY PROSVIRNIN on 24.05.2021.
//

import UIKit

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.overrideUserInterfaceStyle = .dark
        
        logoImage.alpha = 0
        
        startButton.layer.cornerRadius = 25.0
        startButton.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        startButton.setTitleColor(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1), for: .normal)
        startButton.layer.masksToBounds = true
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1) {
            self.logoImage.alpha = 1
            self.logoImage.contentMode = .scaleAspectFit
        }
    }
        
    
    
}

