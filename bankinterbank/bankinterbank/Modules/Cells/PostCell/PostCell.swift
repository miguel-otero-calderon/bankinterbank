//
//  PostCell.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import UIKit
protocol PostCellDelegate {
    func selected(cell:PostCell)
}
class PostCell: UITableViewCell {

    //Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    //variables
    var data:PostCellData?
    var delegate: PostCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            delegate?.selected(cell: self)
        }
    }
    func configure(data:PostCellData){
        self.data = data
        titleLabel.text = data.post.title
        bodyLabel.text = data.post.body
    }
    
}
extension PostCell: ProtocolCell {
    static var height: CGFloat {
        return UITableView.automaticDimension
    }
    
    static var identifier: String {
        return "PostCell"
    }
}
struct PostCellData {
    let post:Post
}
