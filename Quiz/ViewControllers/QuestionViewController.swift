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
    @IBOutlet weak var buttonNext: UIButton!
    
    var sliderValueLabel: UILabel?
    var singleButtons: [UIButton] = []
    
    var questionIndex: Int = 0
    var questions: [Question] = Question.all.shuffled()
    var answers: [Answer] = []
    
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
        
        singleButtons = []
        
        for (n, answer) in question.answers.enumerated() {
            
            let answerRow = UIStackView()
            answerRow.axis = .horizontal
            answerRow.alignment = .center
            answerRow.distribution = .fill
            answerRow.spacing = 0
            
            let button = UIButton(type: .roundedRect)
            button.setTitle(answer.text, for: [])
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.setTitleColor(UIColor.darkText, for: [])
            button.titleShadowColor(for: [])
            button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
            
            singleButtons.append(button)
            
            answerRow.addArrangedSubview(button)
            
            questionStack.addArrangedSubview(button)
        }
        
    }
    
    private func addAnswersRange(_ question: Question) {
        
        let currentAnswer = question.answers[0]
        
        let answerRow = UIStackView()
        answerRow.axis = .vertical
        answerRow.alignment = .fill
        answerRow.distribution = .fill
        answerRow.spacing = 0
        
        sliderValueLabel = UILabel()
        sliderValueLabel!.text = currentAnswer.text
        sliderValueLabel!.textAlignment = .center
        sliderValueLabel!.font = UIFont.systemFont(ofSize: 28)
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = Float(question.answers.count - 1)
        slider.addTarget(self, action: #selector(answerSliderMoved), for: .valueChanged)
        
        
        let minMaxRow = UIStackView()
        minMaxRow.axis = .horizontal
        minMaxRow.alignment = .fill
        minMaxRow.distribution = .fillEqually
        minMaxRow.spacing = 0

        let minValueTitle = UILabel()
        minValueTitle.text = question.answers[0].text
        minValueTitle.textAlignment = .left
        minValueTitle.font = UIFont.systemFont(ofSize: 20)

        let maxValueTitle = UILabel()
        maxValueTitle.text = question.answers[question.answers.count - 1].text
        maxValueTitle.textAlignment = .right
        maxValueTitle.font = UIFont.systemFont(ofSize: 20)

        minMaxRow.addArrangedSubview(minValueTitle)
        minMaxRow.addArrangedSubview(maxValueTitle)
        
        answerRow.addArrangedSubview(sliderValueLabel!)
        answerRow.addArrangedSubview(slider)
        answerRow.addArrangedSubview(minMaxRow)
        
        questionStack.addArrangedSubview(answerRow)
        
    }
    
    
    private func updateUI() {
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        
        progressBar.setProgress(Float(questionIndex + 1) / Float(questions.count), animated: true)
        
        print(Float(questionIndex + 1), Float(questions.endIndex))
        print(Float(questionIndex + 1) / Float(questions.endIndex))
        
        let question = questions[questionIndex]
        
        questionText.text = question.text
        
        for element in questionStack.arrangedSubviews {
            element.removeFromSuperview()
        }
        
        switch question.style {
        case .multi: addAnswersMulti(question)
        case .single: addAnswersSingle(question)
        case .range: addAnswersRange(question)
        }
        
    }
    
    @IBAction func saveAnswer(_ sender: UIButton) {
        nextQuestion()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        for button in singleButtons {
            button.isSelected = (button == sender)
        }
    }
    
    @IBAction func answerSwitchToggled(_ sender: UISwitch) {
        
    }
    
    @IBAction func answerSliderMoved(_ sender: UISlider) {
        
        sender.value =  roundf(sender.value)
        sliderValueLabel?.text = questions[questionIndex].answers[Int(sender.value)].text
    }
    
    
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex == questions.count {
            performSegue(withIdentifier: "showResult", sender: nil)
        }
        else {
            updateUI()
        }
    }
    
}
