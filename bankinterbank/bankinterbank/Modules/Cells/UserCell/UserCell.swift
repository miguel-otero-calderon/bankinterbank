//
//  UserCell.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import UIKit

class UserCell: UITableViewCell {
    //Outlet
    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var postIdLabel: UILabel!
    @IBOutlet weak var rankView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(data:UserCellData) {        
        self.rankView.circular = true
        let rank = Int.random(in: 0..<4)
        if rank == 1 {
            self.rankImage.image = UIImage(named: "refe_icon_crown_1")
        } else if rank == 2 {
            self.rankImage.image = UIImage(named: "refe_icon_crown_2")
        } else if rank == 3 {
            self.rankImage.image = UIImage(named: "refe_icon_crown_3")
        } else {
            self.rankImage.image = UIImage(named: "refe_icon_crown_1")
        }
        if data.userId <= 50 {
            self.userImage.image = UIImage(named: "avatar-image-\(data.userId).min")
        } else {
            let index = data.userId%50
            self.userImage.image = UIImage(named: "avatar-image-\(index).min")
        }
        userIdLabel.text = "User-\(data.userId)"
        postIdLabel.text = "Post:\(data.id)"
    }
}
extension UserCell: ProtocolCell {
    static var height: CGFloat {
        return 63
    }
    
    static var identifier: String {
        return "UserCell"
    }
}
struct UserCellData {
    let id: Int
    let userId:Int
}
