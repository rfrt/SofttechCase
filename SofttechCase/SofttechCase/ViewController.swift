//
//  ViewController.swift
//  SofttechCase
//
//  Created by RMac on 23.10.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var entityListHeader = ""
    var entities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Functional
        /*
        let viewCreator = ViewCreator()
        let customViews = viewCreator.loadAllViews()
        for customView in customViews{
            if let entityProp = customView.value as? EntityListProperties{
                entities = entityProp.entities
                entityListHeader = entityProp.text
                (customView.key as! UITableView).delegate = self
                (customView.key as! UITableView).dataSource = self
            }
            view.addSubview(customView.key)
        }
        */

        
        //Object Oriented
        
        let allViews = Facade().getAllViews()
        for singleView in allViews{
            if let entityProp = singleView.value as? EntityListProperties{
                entities = entityProp.entities
                entityListHeader = entityProp.text
                (singleView.key as! UITableView).delegate = self
                (singleView.key as! UITableView).dataSource = self
                singleView.key.frame = CGRect(x: 10, y: yAxis.sequence , width: view.frame.size.width - 20, height: 150)
                yAxis.sequence += 160
            }else if let _ =  singleView.value as? HeaderProperties {
                singleView.key.frame = CGRect(x: 0, y: yAxis.sequence , width: view.frame.size.width, height: 50)
                yAxis.sequence += 60
            }else {
                singleView.key.frame = CGRect(x: 10, y: yAxis.sequence , width: view.frame.size.width - 20, height: 50)
                yAxis.sequence += 60
            }
            view.addSubview(singleView.key)
        }
        
        view.backgroundColor = .orange
    }
    
    //entityList header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader")
        view?.textLabel!.text = entityListHeader
        view?.textLabel?.textColor = .black
        return view
    }
    
    //entityList Fonksiyonları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = entities[indexPath.row]
        cell.contentConfiguration = content
        cell.backgroundColor = .darkGray
        cell.textLabel?.textColor = .white
        return cell
    }
    /*
    //top bar gizleme
    override var prefersStatusBarHidden: Bool {
        return true
    }
 */
}






