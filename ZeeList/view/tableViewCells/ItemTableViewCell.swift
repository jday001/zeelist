//
//  ItemTableViewCell.swift
//  ZeeList
//
//  Created by Jeff Day on 2/16/19.
//  Copyright © 2019 JDay Apps, LLC. All rights reserved.
//

import UIKit


protocol ItemCellDelegate: class {
    func addItemButtonTapped(for cell: ItemTableViewCell)
    func addImageButtonTapped(for cell: ItemTableViewCell)
    func addLocationButtonTapped(for cell: ItemTableViewCell)
    func deleteButtonTapped(for cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    
    weak var delegate: ItemCellDelegate?
    
    var item: ListItem? {
        didSet {
            if let item = item {
                DispatchQueue.main.async {
                    self.itemNameLabel.text = item.name
                }
            } else {
                self.itemNameLabel.text = ""
            }
        }
    }
    
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
        delegate?.addItemButtonTapped(for: self)
    }
    
    @IBAction func addImageButtonTapped(_ sender: Any) {
        delegate?.addImageButtonTapped(for: self)
    }
    
    @IBAction func addLocationButtonTapped(_ sender: Any) {
        delegate?.addLocationButtonTapped(for: self)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        delegate?.deleteButtonTapped(for: self)
    }
}
