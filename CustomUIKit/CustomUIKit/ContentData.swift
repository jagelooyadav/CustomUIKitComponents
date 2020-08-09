//
//  ContentData.swift
//  HumanLifeExpectancy
//
//  Created by Jageloo Yadav on 11/04/20.
//  Copyright © 2020 CustomAppDelegate. All rights reserved.
//

import UIKit

public struct AppData: Decodable {
    public let name: String
    public let screens: [ContentData]
}

public enum ResourceType: String, Decodable {
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
    case Button
    case Label
    case Placeholder
    case UnderLineButton
}

public struct ContentData: Decodable {
    public let resourceType: ResourceType
    public let title: String
    public let description: String?
    public let contents: [ContentData]
    public let images: [String]?
    public let names: [String]?
    public var identifier: String?
    public var icon: String?
    public var isContentVetical: Bool?
    public var textColorName: String?
}
