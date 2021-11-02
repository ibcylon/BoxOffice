//
//  BoxOfficeTableViewCell.swift
//  BoxOffice
//
//  Created by Kanghos on 2021/11/03.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    static let identifier = "boxOfficeCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
