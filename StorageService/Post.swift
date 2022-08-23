//
//  Post.swift
//  Navigation
//
//  Created by Alexey Kurazhov on 01.07.2022.
//

import Foundation

public struct Post {
    public var title: String
    public init(title: String) {
        self.title = title
    }
}


public struct PostCartoon {
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
}

public struct Storage {

public static let data: [PostCartoon] = [
    PostCartoon (author: "Мэтт Гроунинг",
                     description: "«Футура́ма» — американский научно-фантастический сатирический мультсериал, созданный в студии 20th Century Fox Мэттом Грейнингом и Дэвидом Коэном, авторами мультсериала «Симпсоны». В большинстве серий действие сериала происходит в Новом Нью-Йорке в XXXI веке",
                     image: "futurama",
                     likes: 1245,
                     views: 5300),
            PostCartoon (author: "Сет Макфарлейн",
                     description: "«Америка́нский папаша!» — американский комедийный мультсериал производства студии «Андердог» и «Фаззи Дор» по заказу 20th Century Fox. Он был придуман и разработан, в большей степени, Сетом Макфарлейном, создателем сериала «Гриффины».",
                     image: "american dad",
                     likes: 990,
                     views: 4585),
            PostCartoon (author: " Джастин Ройланд, Дэн Хармон",
                     description: "«Рик и Морти» — американский комедийный научно-фантастический анимационный сериал, созданный Джастином Ройландом и Дэном Хармоном и выпускаемый в рамках блока Adult Swim на телеканале Cartoon Network",
                         image: "rick and morty",
                     likes: 4450,
                     views: 9479),
            PostCartoon (author: "Союзмультфильм",
                     description: "Знакомьтесь, это семейство оранжевых коров: телята Бо и Зо и их родители — Мама Корова и Папа Бык. В каждой серии дети самостоятельно или с друзьями решают какую-нибудь важную проблему, а родители поддерживают их и дают полезные советы.",
                     image: "orange cow",
                     likes: 10050,
                     views: 10050)
        ]
}
