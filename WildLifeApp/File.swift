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

class User: NSObject {
    var profileImageUrl: String?
    var name: String?
    var myID: String?
    
}

class Cuser {
    static let shareObj = Cuser()
    var infos = Infos(id: "", gender: "", place: "", age: "", sport: [""], intro: "")


    var defaultSports = [
        "Diving", "Surfing", "Swimming", "Snorkelling", "Climbing", "Biking", "Camping",
        "Wind surfin", "Skateboard", "Fishing", "River Tracing", "Mountain climbing",
        "Kayaking", "Paragliding",
        "Other"
    ]
    var sportCheck = [
    true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,
    ]
}



