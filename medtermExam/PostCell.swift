//
//  PostCell.swift
//  medtermExam
//
//  Created by Abdalla Elnajjar on 2022-06-05.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(title: String) {
        postLabel.text = title
    }

}
