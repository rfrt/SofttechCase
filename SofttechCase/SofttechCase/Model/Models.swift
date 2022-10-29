//
//  Models.swift
//  SofttechCase
//
//  Created by RMac on 24.10.2022.
//

/*import Foundation

struct CustomView<T:Properties>: Codable{
    var type : String
    var properties : T
}

protocol Properties:Codable{
    
}

struct DatePickerProperties: Properties {
    var date:String
}

struct EntityListProperties: Properties {
    var text:String
    var entities:[String]
}

struct HeaderProperties: Properties {
    var text:String
}

struct TextInputProperties: Properties {
    var text:String
}*/



 import Foundation

 struct CustomView: Codable{
     var type : String
     var properties : String
 }

 protocol Properties:Codable{
     
 }

 struct DatePickerProperties: Properties {
     var date:String
 }

 struct EntityListProperties: Properties {
     var text:String
     var entities:[String]
 }

 struct HeaderProperties: Properties {
     var text:String
 }

 struct TextInputProperties: Properties {
     var text:String
 }
