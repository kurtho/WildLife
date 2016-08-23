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
    var id: String
    var name: String
    var photo: UIImage
    var place: String
    var info: String
    var skill: [String]
    var content: String
    init(name: String, photo: UIImage, skill: [String], content: String, id: String, place: String, info: String){
        self.id = id
        self.name = name
        self.photo = photo
        self.place = place
        self.info = info
        self.skill = skill
        self.content = content
    }
}

class CurrentUser {
    static let shareInstance = CurrentUser()
    var infos: Infos?
    var pic = UIImage()

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
