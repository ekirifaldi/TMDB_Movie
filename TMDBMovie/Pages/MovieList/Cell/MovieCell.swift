//
//  MovieCell.swift
//  TMDBMovie
//
//  Created by Eki Rifaldi on 10/01/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var ivPhoto: UIImageView!
    @IBOutlet weak var labelTitle: DynamicLabel!
    @IBOutlet weak var labelReleaseDate: DynamicLabel!
    @IBOutlet weak var labelDesc: DynamicLabel!
    @IBOutlet weak var viewCard: UIView! {
        didSet {
            viewCard.addShadow()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
