//
//  ReviewCell.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet weak var ivUserPhoto: UIImageView!
    @IBOutlet weak var labelName: DynamicLabel!
    @IBOutlet weak var labelRate: DynamicLabel!
    @IBOutlet weak var labelContent: DynamicLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
