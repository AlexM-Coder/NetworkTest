//
//  MyTableViewCell.swift
//  NetworkTest
//
//  Created by Алексей Муравьев on 28.05.2022.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myNumber: UILabel!
    
    @IBOutlet weak var myTitle: UILabel!
    
    @IBOutlet weak var myID: UILabel!
    
    @IBOutlet weak var myBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
