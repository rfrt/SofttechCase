//
//  Functional.swift
//  SofttechCase
//
//  Created by RMac on 29.10.2022.
//

import Foundation
import UIKit


class ViewCreator:UIViewController{

    func loadAllViews() -> [UIView:Properties] {
        var customViews = [UIView:Properties]()
        
        guard let path = Bundle.main.url(forResource: "CustomViews", withExtension: "json") else {
            fatalError("File Not Found!")
        }
        guard let customViewsAsData = try? Data(contentsOf: path) else{
            fatalError("Data can not Convert")
        }
        let decoder = JSONDecoder()
        guard let customViewsAsModel = try? decoder.decode([CustomView].self, from: customViewsAsData) else{
            fatalError("Data can not Decoding")
        }
        for view in customViewsAsModel{
            let jsonData = view.properties.data(using: .utf8)!
            switch view.type {
            case "header":
                let headerProperties = try! JSONDecoder().decode(HeaderProperties.self, from: jsonData)
                let header = createHeader(text: headerProperties.text)
                customViews[header] = headerProperties

            case "textInput":
                let textInputProperties = try! JSONDecoder().decode(TextInputProperties.self, from: jsonData)
                let textInput = createTextInput(text: textInputProperties.text)
                customViews[textInput] = textInputProperties

            case "datePicker":
                let datePickerProperties = try! JSONDecoder().decode(DatePickerProperties.self, from: jsonData)
                let datePicker = createDatePicker(date: datePickerProperties.date)
                customViews[datePicker] = datePickerProperties

            case "entityList":
                let entityListProperties = try! JSONDecoder().decode(EntityListProperties.self, from: jsonData)
                let entityList = createEntityList()
                customViews[entityList] = entityListProperties
            default:
                break
            }
        }
        return customViews
    }
    
    func createHeader( text : String ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.frame = CGRect(x: 0, y: yAxis.sequence , width: view.frame.size.width, height: 50)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .darkGray
        yAxis.sequence += 60
        return label
    }
    
    func createTextInput(text:String) -> UITextField {
        let textField = UITextField()
        textField.frame = CGRect(x: 10, y: yAxis.sequence, width: view.frame.size.width - 20, height: 50)
        textField.backgroundColor = .darkGray
        textField.textColor = .white
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        yAxis.sequence += 60
        return textField
    }
    
    func createDatePicker(date:String) -> UIDatePicker {
        var customDate: Date!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = .current
        customDate = dateFormatter.date(from: date)
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .darkGray
        datePicker.tintColor = .white
        datePicker.date = customDate
        datePicker.frame = CGRect(x: 10, y: yAxis.sequence, width: view.frame.size.width - 20, height: 50)
        yAxis.sequence += 60
        return datePicker
    }
    
    func createEntityList() -> UITableView {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 10, y: yAxis.sequence, width: view.frame.size.width - 20, height: 150)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        yAxis.sequence += 160
        return tableView
    }
}
