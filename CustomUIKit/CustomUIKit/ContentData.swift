//
//  ContentData.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 11/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

struct AppData: Decodable {
    let name: String
    let screens: [ContentData]
}

enum ResourceType: String, Decodable {
    case PageView
    case RoundedInformationBox
    case HeadingWithSeperator
    case Footer
    case fullscreen
    case ImageGroupButtons
    case TextInputView
    case ObjectiveQestionView
    case SingleQuestionOptionView
    case ImageTextInputViewGroups
    case ImageInputTextView
}

struct ContentData: Decodable {
    let resourceType: ResourceType
    let title: String
    let description: String?
    let contents: [ContentData]
    let images: [String]?
    let names: [String]?
    var identifier: String?
    var icon: String?
}
