//
//  UserDetailsViewController.swift
//  githubDemo
//
//  Created by Edwin Weru on 27/05/2022.
//

import UIKit
import Kingfisher

class UserDetailsViewController: BaseViewController<UsersViewModel> {

    @IBOutlet weak var img_profile: UIImageView!
    
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var lbl_score: UILabel!
    
    @IBOutlet weak var btn_done: UIButton!
    
    
    var coordinator: AppCoordinator?
    var selectedItem: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    private func setUpView() {
        guard let name = selectedItem?.login else {
            return
        }
        self.lbl_score.text = name
        
        guard let score = selectedItem?.score else {
            return
        }
        self.lbl_score.text = "\(score)"
        
        guard let avatar_url = selectedItem?.avatar_url else {
            return
        }
        let url = URL(string: avatar_url)
        img_profile.kf.setImage(with: url)
    }

    @IBAction func actionDone(_ sender: Any) {
        
        guard let partner_url = selectedItem?.html_url else {
            return
        }
        
        guard let url = URL(string: partner_url) else {
          return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
