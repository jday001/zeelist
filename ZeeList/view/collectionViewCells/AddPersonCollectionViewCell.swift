//
//  AddPersonCollectionViewCell.swift
//  ZeeList
//
//  Created by Jeff Day on 2/16/19.
//  Copyright © 2019 JDay Apps, LLC. All rights reserved.
//

import UIKit


class AddPersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 30
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1.0
        
        imageView.layer.shadowColor = UIColor(white: 0, alpha: 1.0).cgColor
        imageView.layer.shadowRadius = 1
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
    }
}
