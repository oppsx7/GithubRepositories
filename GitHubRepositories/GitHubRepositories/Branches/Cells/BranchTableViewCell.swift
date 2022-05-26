//
//  BranchTableViewCell.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import UIKit

class BranchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
