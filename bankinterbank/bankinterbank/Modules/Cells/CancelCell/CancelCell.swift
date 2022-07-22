//
//  CancelCell.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import UIKit

class CancelCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var cancelButton: UIButton!
    //variables
    var delegate: CancelCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        delegate?.cancel(cell: self)
    }
    func configure(data:CancelCellData) {
        cancelButton.setTitle(data.cancelTitle, for: .normal)
    }
}
extension CancelCell: ProtocolCell {
    static var identifier: String {
        return "CancelCell"
    }
    
    static var height: CGFloat {
        return 50.0
    }
}
protocol CancelCellDelegate {
    func cancel(cell:CancelCell)
}
struct CancelCellData {
    let cancelTitle:String
}
