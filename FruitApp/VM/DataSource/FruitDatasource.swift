//
//  FruitDatasource.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import UIKit

class FruitDatasource: NSObject, UITableViewDataSource {
    // MARK: - Types
    
    struct CellIdentifiers {
        static let fruit = "fruitTableViewCell"
    }
    
    struct NibName {
        static let fruit = "FruitTableViewCell"
    }
    
    // MARK: - vars
    var data = [Fruit]()
    
    // MARK: initialiser
    required init(tableView: UITableView, fruit: [Fruit]) {
        super.init()
        self.data = fruit
        configure(tableView: tableView)
        
    }
    
    // MARK: - private methods
    private func configure(tableView: UITableView) {
        tableView.dataSource = self
    }
    
    // MARK: - update datasource
    func update(data: [Fruit]) {
        self.data.removeAll()
        self.data = data.sorted(by: { (a, b) -> Bool in
            a.type < b.type
        })
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.fruit, for: indexPath) as! FruitTableViewCell
        let fruit = data[indexPath.row]
        cell.nameLabel?.text = fruit.type
        cell.fruitImageView.setImage(string:fruit.type, circular: true, stroke: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}

