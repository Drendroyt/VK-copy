//
//  Post.swift
//  Navigation
//
//  Created by Кирилл Дамковский on 01.05.2022.
//

import UIKit

struct Post {
    let author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

let post1 = Post(author: "CrazyDev", description: "Эй! А когда все будет готово? – и ты понимаешь, что все снова затянулось. Давай разберемся, как грамотно оценить срок проекта.", image: "post1", likes: 119, views: 22300)

let post2 = Post(author: "JoinIT", description: "ТОП-10 игр, которые научат ребенка программировать на Python. Подборка для детей из 10 бесплатных и платных онлайн-платформ для увлекательного изучения Python. Помимо Python, можно подтянуть знания по JavaScript, TypeScript, CoffeScript, C++, PHP, Java и Lua.", image: "post2", likes: 144, views: 40332)

let post3 = Post(author: "JoinIT", description: "25 самых используемых регулярных выражений в Java. Список из 25 регулярных выражений в Java, без которых не обойтись ни новичку, ни профессиональному разработчику. С примерами.", image: "post3", likes: 115, views: 39223)

let post4 = Post(author: "JoinIT", description: "Алгоритмы и структуры данных на C++ для новичков. Часть 1: Основы анализа алгоритмов. Осваиваем основы анализа алгоритмов, которые потребуются любому начинающему программисту на C++ (и не только). Адекватное представление о времени выполнения кода может оказаться решающим фактором там, где производительность имеет большое значение.", image: "post4", likes: 86, views: 22466)

let postArray: [Post] = [post1, post2, post3, post4]
