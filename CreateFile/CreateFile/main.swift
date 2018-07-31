//
//  main.swift
//  CreateFile
//
//  Created by BridgeLabz Solutions LLP  on 7/28/18.
//  Copyright © 2018 Pratik Zanjurne. All rights reserved.
//

import Foundation

print("Enter the name of file ")
var fileName = readLine()!
let data = Data(base64Encoded: "{}")
let path = "/Users/bridgelabz/Desktop/Files/\(fileName).json"
let file =  FileManager.default.createFile(atPath: path, contents: data, attributes: nil)

//if FileManager().createFile(atPath: path, contents: nil, attributes: nil){
//    print("File created")
//}else{
//    print("Not created")
//}

