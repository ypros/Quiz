//
//  ResultViewController.swift
//  Quiz
//
//  Created by YURY PROSVIRNIN on 25.05.2021.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    let answers: [Answer]
    
    init?(coder: NSCoder, _ answers: [Answer]) {
        self.answers = answers
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .dark
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "Результат"

        var totalPoints: Int
        totalPoints = answers.reduce(0, {$0 + $1.points})
        
        let person = Person(points: totalPoints)
        resultLabel.text = "Ваш герой - \(person.name) (результат \(totalPoints))"
        
        personImage.image = UIImage(named: person.image)
        
        descriptionLabel.text = person.description

    }



}
