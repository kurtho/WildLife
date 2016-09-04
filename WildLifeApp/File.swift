//
//  File.swift
//  WildLifeApp
//
//  Created by KurtHo on 2016/8/17.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import Foundation
import UIKit

class Infos: NSObject {
    var id : String
    var gender: String
    var place: String
    var age: String
    var sport: [String]
    var intro: String
    init(id : String, gender: String, place: String, age: String, sport: [String], intro: String){
        self.id = id
        self.gender = gender
        self.place = place
        self.age = age
        self.sport = sport
        self.intro = intro
    }
}

class CurrentUser {
    static let shareInstance = CurrentUser()
    var infos = Infos(id: "", gender: "Male / Female ??", place: "Wheredo you live ??", age: "Your age ??", sport: ["What sports do you like ??"], intro: "Introduce your self !")
    var uid: String?
    var pic = UIImage()
    var userInfo =  [
        "Male / Female?",
        "Where do you live?",
        "Your age?",
        ["What Sports do you like"],
        "Introduce yourself"
    ]
    var defaultSports = [
        "Diving", "Surfing", "Swimming", "Snorkelling", "Climbing", "Biking", "Camping",
        "Wind surfin", "Skateboard", "Fishing", "River Tracing", "Mountain climbing",
        "Kayaking", "Paragliding",
        "Other"
    ]
}

class User: NSObject {
    var profileImageUrl: String?
    var name: String?
    var myID: String?

}


class UserInfo {
    var gender: String?
    var place: String?
    var age: String?
    var sport: [String]?
    var intorduction: String?
}
