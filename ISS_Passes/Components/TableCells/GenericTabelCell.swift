//
//  GenericTabelCell.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit
import Foundation

class GenericTabelCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel1: UILabel!
    @IBOutlet weak var valueLabel1: UILabel!
    @IBOutlet weak var keyLabel2: UILabel!
    @IBOutlet weak var valueLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /** Populates the text for the cell's labels
        - parameter labelSet1: A Dictionary Object whose key/value combination is used to populate the text values for label set 1
     - parameter labelSet2: A Dictionary Object whose key/value combination is used to populate the text values for label set 2
     */
    func setup(labelSet1: [String : String], labelSet2: [String : String]) {
        if let key = labelSet1.keys.first {
            self.keyLabel1.text = key
            self.valueLabel1.text = labelSet1[key]
        }
        
        if let key = labelSet2.keys.first {
            self.keyLabel2.text = key
            self.valueLabel2.text = labelSet2[key]
        }
    }
}
