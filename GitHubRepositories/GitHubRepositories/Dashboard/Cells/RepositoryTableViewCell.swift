//
//  RepositoryTableViewCell.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var latestPushLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
