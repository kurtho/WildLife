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

    var gender: String
    var place: String
    var age: String
    var sport: [String]
    var intro: String
    init(gender: String, place: String, age: String, sport: [String], intro: String){
        self.gender = gender
        self.place = place
        self.age = age
        self.sport = sport
        self.intro = intro
    }
}

class CurrentUser {
    static let shareInstance = CurrentUser()
    var infos: Infos?
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
