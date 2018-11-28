//
//  ViewController.swift
//  TableviewScrollS
//
//  Created by Lalit Arya on 28/11/18.
//  Copyright © 2018 Lalit Arya. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let cellID = "cellID"
    
    func someMethodIWantToCall(cell: UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        let contact = twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited
        twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        cell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray : .red
    }
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, names: ["item1", "item2", "item3", "item4", "item5", "item6", "Mary"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["Raj", "Kishore", "Anuj", "Varun"].map{ Contact(name: $0, hasFavorited: true) }),
        ExpandableNames(isExpanded: true, names: ["Sonu", "Kamal"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: [Contact(name: "Jigar", hasFavorited: false)]),
        ExpandableNames(isExpanded: true, names: ["Suno", "Rohit", "Lalit", "Jugal", "jimmy"].map{ Contact(name: $0, hasFavorited: false) }),
        ]
    var showIndexPaths = false
    
    @objc func handleShowIndexPath() {
        var indexPathsToReload = [IndexPath]()
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].names.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : .left
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    tableView.register(ContactCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactCell
        cell.link = self
        let contact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = contact.name
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray
        
        if showIndexPaths {
          //  cell.textLabel?.text = "\(contact.name)   Section:\(indexPath.section) Row:\(indexPath.row)"
        }
        return cell
    }
}

