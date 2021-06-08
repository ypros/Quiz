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
                         answers: [Answer(text: "Невилл Долгопупс", points: 34),
                                   Answer(text: "Джинни Уизли", points: 33),
                                   Answer(text: "Том Реддл", points: -50),
                                   Answer(text: "Сириус Блэк", points: 33),
                                   Answer(text: "Драко Малфой", points: -50)]),
                Question(text: "Сколько игроков в одной команде по квиддичу?", style: .range,
                         answers: [Answer(text: "2"),
                                   Answer(text: "3"),
                                   Answer(text: "5"),
                                   Answer(text: "7", points: 100),
                                   Answer(text: "10")]),
                Question(text: "Любимое заклинание Волан-де-Морта?", style: .single,
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
                                   Answer(text: "Выжимать сок мандрагоры"),
                                   Answer(text: "Играть на арфе")]),
                Question(text: "Сколько детей в семье Артура и Молли Уизли?", style: .range,
                         answers: [Answer(text: "5"),
                                   Answer(text: "6", points: 100),
                                   Answer(text: "7"),
                                   Answer(text: "8"),
                                   Answer(text: "9")]),
                Question(text: "Какие дисциплины изучают в Хогвардс?", style: .multi,
                         answers: [Answer(text: "Зельеварение", points: 34),
                                   Answer(text: "Защита от темных сил", points: 33),
                                   Answer(text: "Язык змей", points: -50),
                                   Answer(text: "Магические фокусы", points: -50),
                                   Answer(text: "Предсказание будущего", points: 33)]),
        ]
        
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
        case -300..<300:
            self = .Dudly
        case 300..<500:
            self = .Ron
        case 500..<650:
            self = .Hagrid
        case 650..<750:
            self = .Hermione
        default:
            self = .Hat
        }
    }
    
    var name: String {
        switch self {
        case .Hat:
            return "Распределяющая Шляпа"
        case .Hermione:
            return "Гермиона Грейнджер"
        case .Hagrid:
            return "Рубеус Хагрид"
        case .Ron:
            return "Рон Уизли"
        default:
            return "Дадли Дурсль"
        }
    }
    
    var image: String {
        switch self {
        case .Hat:
            return "Hat"
        case .Hermione:
            return "Hermione"
        case .Hagrid:
            return "Hagrid"
        case .Ron:
            return "Ron"
        default:
            return "Dudly"
        }
    }
    
    var description: String {
        switch self {
        case .Hat:
            return "Нет ни одного вопроса, на который ты бы не знал ответа. В Хогвардсе ты был одинм из лучших учеников!"
        case .Hermione:
            return "Отличный результат! Сама Гермиона позавидовала бы твоим знаниям."
        case .Hagrid:
            return "Неплохой результат. Похоже раньше вы знали все ответы, но что-то подзабылось."
        case .Ron:
            return "Несколько правильных ответов тоже результат. Теперь можно пойти поиграть в квиддич или шамхаты"
        default:
            return "Терпеть не можете этих магов и волшебников?"
        }
    }
}

