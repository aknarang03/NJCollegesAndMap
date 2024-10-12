//
//  CollegesListTableViewCell.swift
//  NJCollegesAndMap
//
//  Created by Anjali Narang  on 10/12/24.
//

import UIKit

class CollegesListTableViewCell: UITableViewCell {

    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeImage: UIImageView!
    @IBOutlet weak var go: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
