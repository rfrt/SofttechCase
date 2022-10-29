//
//  ObjectOriented.swift
//  SofttechCase
//
//  Created by RMac on 29.10.2022.
//

import Foundation
import UIKit

//VIEW CREATION : SOYUT YAPILAR
protocol ProtocolCustomViewCreator{
    var properties: String {get set}
    func createView() -> UIView
    func decodeProperty() -> Properties
}
class CustomViewCreator<T:Properties>: ProtocolCustomViewCreator {//SOMUT SINIF AMA ABSTRACT CLASS GIBI KULLANDIM
    var properties: String
    init(properties:String) {
        self.properties = properties
    }
    func createView() -> UIView {
        fatalError("Not Overrided")
    }
    func decodeProperty() -> Properties {
        let jsonData = self.properties.data(using: .utf8)!
        let properties = try! JSONDecoder().decode(T.self, from: jsonData)
        return properties
    }
}


//VIEW CREATION : SOMUT SINIFLAR
class HeaderCreator:CustomViewCreator<HeaderProperties> {
    override func createView() -> UIView {
        let label = UILabel()
        label.text = (super.decodeProperty() as! HeaderProperties).text
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .darkGray
        return label
    }
}
class TextInputCreator: CustomViewCreator<TextInputProperties> {
    override func createView() -> UIView {
        let textField = UITextField()
        textField.backgroundColor = .darkGray
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: (super.decodeProperty() as! TextInputProperties).text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return textField
    }
}
class DatePickerCreator: CustomViewCreator<DatePickerProperties> {
    override func createView() -> UIView {
        var customDate: Date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = .current
        customDate = dateFormatter.date(from: (super.decodeProperty() as! DatePickerProperties).date)
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .darkGray
        datePicker.tintColor = .white
        datePicker.date = customDate
        return datePicker
    }
}
class EntityListCreator: CustomViewCreator<EntityListProperties> {
    override func createView() -> UIView {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        return tableView
    }
}


//FACADE YAPISI : ARDISIK ISLEMLERI TEK YERDEN TETIKLEYEBILMEK ICIN KULLANDIM
class Facade {
    func getAllViews() -> [UIView:Properties] {
        var uiViews = [UIView:Properties]()
        let customViewsAsModel = CustomViewsDecoder.decodeFromJSON()
        for viewAsModel in customViewsAsModel{
            switch viewAsModel.type {
            case "header":
                let headerCreator = HeaderCreator(properties:viewAsModel.properties)
                uiViews[headerCreator.createView()] = headerCreator.decodeProperty()
            case "textInput":
                let textInputCreator = TextInputCreator(properties:viewAsModel.properties)
                uiViews[textInputCreator.createView()] = textInputCreator.decodeProperty()
            case "datePicker":
                let datePickerCreator = DatePickerCreator(properties:viewAsModel.properties)
                uiViews[datePickerCreator.createView()] = datePickerCreator.decodeProperty()
            case "entityList":
                let entityListCreator = EntityListCreator(properties:viewAsModel.properties)
                uiViews[entityListCreator.createView()] = entityListCreator.decodeProperty()
            default:
                break
            }
        }
        return uiViews
    }
}
