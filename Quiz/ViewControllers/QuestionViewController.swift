//
//  QuizViewController.swift
//  Quiz
//
//  Created by YURY PROSVIRNIN on 24.05.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionStack: UIStackView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionText: UILabel!
    
    var questionIndex: Int = 0
    var questions: [Question] = Question.all.shuffled()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        updateUI()
        
        
        
    }
    
    private func addAnswersMulti(_ question: Question) {
        
        for (n, answer) in question.answers.enumerated() {

            
            let answerRow = UIStackView()
            answerRow.axis = .horizontal
            answerRow.alignment = .center
            answerRow.distribution = .fill
            answerRow.spacing = 20

            
            let answerLabel = UILabel()
            answerLabel.text = answer.text
            
            let answerSwitch = UISwitch()
            answerSwitch.isOn = false
            answerSwitch.tag = n
            
            answerRow.addArrangedSubview(answerLabel)
            answerRow.addArrangedSubview(answerSwitch)
            
            questionStack.addArrangedSubview(answerRow)
        }
    }
    
    private func addAnswersSingle(_ question: Question) {
        
        for (n, answer) in question.answers.enumerated() {
            
            let answerRow = UIStackView()
            answerRow.axis = .horizontal
            answerRow.alignment = .center
            answerRow.distribution = .fill
            answerRow.spacing = 20
            
            let button = UIButton()
            button.setTitle(answer.text, for: [])
            button.setTitleColor(UIColor.label, for: [])
            button.setTitleShadowColor(UIColor.lightGray, for: [])
            button.isSelected = true
            button.layer.cornerRadius = 5
            button.tag = n
            
            button.isEnabled = true
            
            answerRow.addArrangedSubview(button)
            
            questionStack.addArrangedSubview(button)
        }
        
    }
    
    
    
    private func updateUI() {
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        progressBar.setProgress(Float(questionIndex + 1) / Float(questions.endIndex), animated: true)
        
        let question = questions[questionIndex]
        
        questionText.text = question.text
        
        switch question.style {
        case .multi: addAnswersSingle(question)
        case .single: addAnswersSingle(question)
        case .range: addAnswersSingle(question)
        }
        
    }
    
    
    
}
