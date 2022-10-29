//
//  Statics.swift
//  SofttechCase
//
//  Created by RMac on 29.10.2022.
//

import Foundation
import UIKit

//View ler oluşurken Y eksenindeki dizilimlerinin başlangıç noktası ve dizilimin sekansı olarak kullanıldı
struct yAxis{
    static var sequence : CGFloat = 50
}

//ihtiyaca binaen geri dönüş tipi ve dosya adı parametre olarak alınıp generic halde kullanılabilir
struct CustomViewsDecoder{
    static func decodeFromJSON() -> [CustomView] {
        guard let path = Bundle.main.url(forResource: "CustomViews", withExtension: "json") else {
            fatalError("File Not Found!")
        }
        guard let customViewsAsData = try? Data(contentsOf: path) else{
            fatalError("Data can not Convert")
        }
        guard let customViewsAsModel = try? JSONDecoder().decode([CustomView].self, from: customViewsAsData) else{
            fatalError("Data can not Decode")
        }
        return customViewsAsModel
    }
}
