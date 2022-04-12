//
//  Model.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import Foundation

struct PostProfile {
    let author: String
    let discription: String
    let image: String
    var likes: Int
    var views: Int
}

var postArray: [PostProfile] = [PostProfile(author: "lady.official", discription: "Новая фотосессия", image: "imageCell20", likes: 20, views: 40),
                                PostProfile(author: "boy.official", discription: "Всех с праздником!", image: "imageCell16", likes: 60, views: 100),
                                PostProfile(author: "batman.official", discription: "Готовимся к выходным", image: "imageCell18", likes: 45, views: 60),
                                PostProfile(author: "party.official", discription: "На подходе вечеринка года", image: "imageCell4", likes: 78, views: 148)]


