//
//  TableViewCellController.swift
//  Meme2.0
//
//  Created by  AminSaleh on 17/03/1440 AH.
//  Copyright © 1440 AminTech. All rights reserved.
//

import UIKit

class TableViewCellController: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
