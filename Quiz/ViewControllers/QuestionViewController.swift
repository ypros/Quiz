//
//  QuizViewController.swift
//  Quiz
//
//  Created by YURY PROSVIRNIN on 24.05.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionStack: UIStackView!
    @IBOutlet weak var answersStack: UIStackView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var questionStackLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionStackTrailingConstraint: NSLayoutConstraint!
    
    var sliderValueLabel: UILabel?
    var singleButtons: [UIButton] = []
    var multiSwitches: [UISwitch] = []
    
    var questionIndex: Int = 0
    var questions: [Question] = Question.all.shuffled()
    var answers: [Answer] = []
    
    var selectedAnswers: Set<Int> = [] {
        didSet {
            buttonNext.isEnabled = !selectedAnswers.isEmpty
            buttonNext.alpha = buttonNext.isEnabled ? 1 : 0.3
        }
    }
    
    public var currentQuestion: Question {
        return questions[questionIndex]
    }
    
    public var currentAnswers: [Answer] {
        return currentQuestion.answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.overrideUserInterfaceStyle = .dark
        
        buttonNext.layer.cornerRadius = 25
        buttonNext.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        buttonNext.setTitleColor(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1), for: .normal)
        buttonNext.setTitleColor(#colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1), for: .disabled)
        buttonNext.layer.masksToBounds = true
        
        updateUI()
        
    }
    
    private func addAnswersMulti() {
        
        multiSwitches = []
        
        for (n, answer) in currentAnswers.enumerated() {

            let answerRow = UIStackView()
            answerRow.axis = .horizontal
            answerRow.alignment = .center
            answerRow.distribution = .fill
            answerRow.spacing = 20

            
            let answerLabel = UILabel()
            answerLabel.text = answer.text
            answerLabel.font = UIFont.systemFont(ofSize: 24)
            
            let answerSwitch = UISwitch()
            answerSwitch.isOn = false
            answerSwitch.addTarget(self, action: #selector(answerSwitchToggled), for: .valueChanged)
            answerSwitch.tag = n
            
            multiSwitches.append(answerSwitch)
            
            answerRow.addArrangedSubview(answerLabel)
            answerRow.addArrangedSubview(answerSwitch)
            
            answersStack.addArrangedSubview(answerRow)
        }
    }
    
    private func addAnswersSingle() {
        
        singleButtons = []
        
        for (n, answer) in currentAnswers.enumerated() {
            
            let answerRow = UIStackView()
            answerRow.axis = .horizontal
            answerRow.alignment = .center
            answerRow.distribution = .fill
            answerRow.spacing = 0
            
            let button = UIButton(type: .roundedRect)
            button.setTitle(answer.text, for: [])
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            button.titleShadowColor(for: [])
            button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
            button.tag = n
            
            singleButtons.append(button)
            
            answerRow.addArrangedSubview(button)
            
            answersStack.addArrangedSubview(button)
        }
        
    }
    
    private func addAnswersRange() {
        
        let answerRow = UIStackView()
        answerRow.axis = .vertical
        answerRow.alignment = .fill
        answerRow.distribution = .fill
        answerRow.spacing = 0
        
        sliderValueLabel = UILabel()
        sliderValueLabel!.text = currentAnswers.first?.text
        sliderValueLabel!.textAlignment = .center
        sliderValueLabel!.font = UIFont.systemFont(ofSize: 24)
        
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = Float(currentAnswers.count - 1)
        slider.addTarget(self, action: #selector(answerSliderMoved), for: .valueChanged)
        
        
        let minMaxRow = UIStackView()
        minMaxRow.axis = .horizontal
        minMaxRow.alignment = .fill
        minMaxRow.distribution = .fillEqually
        minMaxRow.spacing = 0

        let minValueTitle = UILabel()
        minValueTitle.text = currentAnswers.first?.text
        minValueTitle.textAlignment = .left
        minValueTitle.font = UIFont.systemFont(ofSize: 20)

        let maxValueTitle = UILabel()
        maxValueTitle.text = currentAnswers.last?.text
        maxValueTitle.textAlignment = .right
        maxValueTitle.font = UIFont.systemFont(ofSize: 20)

        minMaxRow.addArrangedSubview(minValueTitle)
        minMaxRow.addArrangedSubview(maxValueTitle)
        
        answerRow.addArrangedSubview(sliderValueLabel!)
        answerRow.addArrangedSubview(slider)
        answerRow.addArrangedSubview(minMaxRow)
        
        answersStack.addArrangedSubview(answerRow)
        
    }
    
    private func updateUI() {
        
        selectedAnswers = []
        
        for element in answersStack.arrangedSubviews {
            element.removeFromSuperview()
        }
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        
        progressBar.setProgress(Float(questionIndex + 1) / Float(questions.count), animated: true)
        
        questionText.text = currentQuestion.text
        
        switch currentQuestion.style {
            case .multi: addAnswersMulti()
            case .single: addAnswersSingle()
            case .range: addAnswersRange()
        }
        
        if questionStack.alpha == 0 {
            
            showQuestion()
        }
        
    }
    
    
    private func showQuestion() {
        questionStackLeadingConstraint.constant = 20 + view.bounds.width
        questionStackTrailingConstraint.constant = 20 - view.bounds.width
        
        view.layoutIfNeeded()
        
        questionStackLeadingConstraint.constant = 20
        questionStackTrailingConstraint.constant = 20
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) { [self] in
            view.layoutIfNeeded()
            questionStack.alpha = 1
        }
    }
    
    
    
    private func hideQuestion() {
        questionStackLeadingConstraint.constant -= view.bounds.width
        questionStackTrailingConstraint.constant += view.bounds.width
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn)  {[self] in
            view.layoutIfNeeded()
            questionStack.alpha = 0
        } completion: { finished in
            
            self.updateUI()
        }
    }
    
    private func nextQuestion() {
        
        questionIndex += 1
        
        if questionIndex < questions.count {
            
            hideQuestion()
        }
        else {
            performSegue(withIdentifier: "showResult", sender: nil)
        }
    }
    
    @IBAction func saveAnswer(_ sender: UIButton) {
        
        for index in selectedAnswers {
            answers.append(currentAnswers[index])
        }
        
        nextQuestion()
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        for button in singleButtons {
            button.isSelected = (button == sender)
        }
        
        selectedAnswers = [sender.tag]
    }
    
    @IBAction func answerSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            selectedAnswers = selectedAnswers.union([sender.tag])
        }
        else {
            selectedAnswers = selectedAnswers.subtracting([sender.tag])
        }
    }
    
    @IBAction func answerSliderMoved(_ sender: UISlider) {
        
        sender.value =  roundf(sender.value)
        
        let tag = Int(sender.value)
        sliderValueLabel?.text = currentAnswers[tag].text
        
        selectedAnswers = [tag]
    }
    
    
    @IBSegueAction func showResult(_ coder: NSCoder, sender: Any?) -> ResultViewController? {
        return ResultViewController(coder: coder, answers)
    }
}
