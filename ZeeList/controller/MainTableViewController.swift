//
//  MainTableViewController.swift
//  ZeeList
//
//  Created by Jeff Day on 1/27/19.
//  Copyright © 2019 JDay Apps, LLC. All rights reserved.
//

import UIKit

enum TableSection: Int {
    case people
    case items
    case addItem
}


class MainTableViewController: UITableViewController {
    
    var people = [Person]()
    var items = [ListItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        people.append(Person(firstName: "George", lastName: "Washington"))
        people.append(Person(firstName: "John", lastName: "Adams"))
        people.append(Person(firstName: "Thomas", lastName: "Jefferson"))
        people.append(Person(firstName: "James", lastName: "Madison"))
        people.append(Person(firstName: "Andrew", lastName: "Jackson"))
        people.append(Person(firstName: "Abraham", lastName: "Lincoln"))
        
        items.append(ListItem(name: "Case of beer", quantity: 1, photo: nil, location: nil))
        items.append(ListItem(name: "Guac & chips", quantity: 1, photo: nil, location: nil))
    }
    
    
    // MARK: - UITableView Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case TableSection.people.rawValue:  return 1
        case TableSection.items.rawValue:   return items.count
        default:                            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case TableSection.people.rawValue:
            let id = "HorizontalCellIdentifier"
            let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! HorizontalListRow
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            return cell
            
        case TableSection.items.rawValue:
            let id = "ItemTableCellIdentifier"
            let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! ItemTableViewCell
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case TableSection.people.rawValue:
            break
            // guard let cell = cell as? HorizontalListRow else { return }
            
        case TableSection.items.rawValue:
            guard let cell = cell as? ItemTableViewCell else { return }
            cell.item = items[indexPath.row]

        default:
            break
        }
    }
    
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:     return 80
        case 1:     return 80
        default:    return 44
        }
    }
}


// TODO: might be cleaner to separate out datasource/delegate classes and just pass them above?

extension MainTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - UICollectionView Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:     return people.count + 1
        default:    return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.item == people.count {
                let id = "AddPersonCellIdentifier"
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! AddPersonCollectionViewCell
                return cell
            }
            let id = "PersonCellIdentifier"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! PersonCollectionViewCell
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            guard let cell = cell as? PersonCollectionViewCell else { return }
            let person = people[indexPath.item]
            cell.nameLabel.text = "\(person.firstName) \(person.lastName)"
            
        default:
            break
        }
    }
    
    
    
    // MARK: - UICollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.item == people.count {
            print("selected add row")
        }
    }
}

extension MainTableViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let width = view.bounds.size.width * 0.8
//        let height = view.bounds.size.height - 84 // 40 is for the top and bottom insets
//        return CGSize(width: width, height: height)
        
        return CGSize(width: 120, height: 79.5 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let horizontalInset: CGFloat = 0 //view.bounds.width * 0.075
        
        return UIEdgeInsets(top: 4, left: horizontalInset, bottom: 4, right: horizontalInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
}

extension MainTableViewController: ItemCellDelegate {
    func addItemButtonTapped(for cell: ItemTableViewCell) {
        guard let indexPath = indexPath(for: cell) else { return }
        print("\(#function) for \(indexPath)")
    }
    
    func addImageButtonTapped(for cell: ItemTableViewCell) {
        guard let indexPath = indexPath(for: cell) else { return }
        print("\(#function) for \(indexPath)")
    }
    
    func addLocationButtonTapped(for cell: ItemTableViewCell) {
        guard let indexPath = indexPath(for: cell) else { return }
        print("\(#function) for \(indexPath)")
    }
    
    func deleteButtonTapped(for cell: ItemTableViewCell) {
        guard let indexPath = indexPath(for: cell) else { return }
        print("\(#function) for \(indexPath)")
    }
    
    private func indexPath(for cell: ItemTableViewCell) -> IndexPath? {
        guard let currentItem = cell.item,
            let row = items.index(of: currentItem) else {
                return nil
        }
        
        return IndexPath(row: row, section: TableSection.items.rawValue)
    }
}
