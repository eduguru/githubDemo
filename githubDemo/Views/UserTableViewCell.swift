//
//  UserTableViewCell.swift
//  githubDemo
//
//  Created by Edwin Weru on 25/05/2022.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var img_view: UIImageView!
    
    @IBOutlet private weak var lbl_title: UILabel!
    
    static let reUseIdentifier: String = "UserTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "UserTableViewCell", bundle: nil)
    }
    
    func configure(with model: UserModel) {
        self.lbl_title.text = model.login
        
        let url = URL(string: model.avatar_url)
        img_view.kf.setImage(with: url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
