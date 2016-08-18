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
    var id: Int?
    var name: String
    var photo: String
    var place: String
    var info: String
    var skill: [String]
    var content: String
    init(name: String, photo: String, skill: [String], content: String, id: Int, place: String, info: String){
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