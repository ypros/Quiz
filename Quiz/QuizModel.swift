//
//  QuizModel.swift
//  Quiz
//
//  Created by YURY PROSVIRNIN on 26.05.2021.
//

struct Question {
    let text: String
    let style: QuestionStyle
    var answers: [Answer]
    
    static var all: [Question] {
        return [Question(text: "Кто учился на факультете Гриффиндор?", style: .multi,
                         answers: [Answer(text: "Невилл Долгопупс", points: 33),
                                   Answer(text: "Джинни Уизли", points: 33),
                                   Answer(text: "Том Реддл"),
                                   Answer(text: "Сириус Блэк", points: 33),
                                   Answer(text: "Драко Малфой")]),
                Question(text: "Сколько игроков в одной команде по квиддичу?", style: .range,
                         answers: [Answer(text: "2"),
                                   Answer(text: "3"),
                                   Answer(text: "5"),
                                   Answer(text: "7", points: 100),
                                   Answer(text: "10")]),
                Question(text: "Любимое заклянание Волан-де-Морта?", style: .single,
                         answers: [Answer(text: "Круциатус"),
                                   Answer(text: "Ешь слизней"),
                                   Answer(text: "Остолбиней"),
                                   Answer(text: "Авада Кедавра", points: 100),
                                   Answer(text: "Империо")]),
                Question(text: "Какой любимый цвет Долорес Амбридж?", style: .single,
                         answers: [Answer(text: "Черный"),
                                   Answer(text: "Фиолетовый"),
                                   Answer(text: "Зеленый"),
                                   Answer(text: "Синий"),
                                   Answer(text: "Розовый", points: 100)]),
                Question(text: "Сколько было лет Гарри Поттеру, когда он поступил в Хогвардс?", style: .range,
                         answers: [Answer(text: "10"),
                                   Answer(text: "11"),
                                   Answer(text: "12", points: 100),
                                   Answer(text: "13"),
                                   Answer(text: "14")]),
                Question(text: "Любимое ночное занятие Поллуны Лавгуд?", style: .single,
                         answers: [Answer(text: "Ходить во сне", points: 100),
                                   Answer(text: "Гадать на картах таро"),
                                   Answer(text: "Летать на метле"),
                                   Answer(text: "Выжимать сок мандрагоры", points: 100),
                                   Answer(text: "Играть на арфе")]),
                Question(text: "Сколько детей в семье Артура и Молли Уизли?", style: .range,
                         answers: [Answer(text: "5"),
                                   Answer(text: "6", points: 100),
                                   Answer(text: "7"),
                                   Answer(text: "8"),
                                   Answer(text: "9")]),
                Question(text: "Какие дисциплины изучают в Хогвардс?", style: .multi,
                         answers: [Answer(text: "Зельеварение", points: 33),
                                   Answer(text: "Защита от темных сил", points: 33),
                                   Answer(text: "Змеиный язык"),
                                   Answer(text: "Магические фокусы"),
                                   Answer(text: "Предсказание будущего", points: 33)]),
        ]
        
    }
    
    public mutating func selectAnswer(_ index: Int) {
        switch style {
        case .multi:
            answers[index].setSelection(true)
        case .single, .range:
            for var (n, answer) in answers.enumerated() {
                answer.setSelection(n == index)
            }
        }
    }
}

struct Answer {
    let text: String
    let points: Int
    private var isSelected: Bool
    
    init(text: String, points: Int = 0) {
        self.text = text
        self.points = points
        self.isSelected = false
    }
    
    mutating func setSelection(_ selected: Bool) {
        self.isSelected = selected
    }
}

enum QuestionStyle {
    case single, multi, range
}

enum Person {
    case Dudly, Ron, Hagrid, Hermione, Hat
    
    init(points: Int) {
        switch points {
        case 9..<11:
            self = .Hat
        case 7..<9:
            self = .Hermione
        case 5..<7:
            self = .Ron
        default:
            self = .Dudly
        }
    }
}

