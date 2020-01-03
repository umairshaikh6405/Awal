//
//  Constants.swift
//  Awwal Tech Surveys
//
//  Created by WCP on 10/6/19.
//  Copyright © 2019 Gexton. All rights reserved.
//



import Foundation
import UIKit
import CoreTelephony
import CoreLocation
import BEMCheckBox


//Dynamic Question
var textInput = [String:String]()
var areaInput = [String:String]()
var checkedList = [String:[Int:Bool]]()
var radioList = [String:Int]()
var conditionalList = [String:Int]()
var radioData = [String:BEMCheckBox]()
var datePickerInput = [String:Date]()
var checkchangelist = [Bool]()
var isECC = false

//Dynamic types
var TYPEText = "input"
var TYPETextArea = "textarea"
var TYPEDropDown = "3"
var TYPECheckBox = "checkbox"
var TYPERadio = "Radio"
var TYPEDate = "6"
var TYPEButton = "submit"
