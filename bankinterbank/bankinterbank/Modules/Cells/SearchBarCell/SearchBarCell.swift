//
//  SearchBarCell.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import UIKit

protocol SearchBarCellDelegate {
    func search(cell: SearchBarCell, filter: String, page:Int)
    func changeText(cell:SearchBarCell, searchText: String)
}
class SearchBarCell: UITableViewCell {

    //Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    //variables
    var data:SearchBarCellData?
    var delegate:SearchBarCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.searchBar.delegate = self
    }
    func configure(data:SearchBarCellData) {
        self.data = data
        self.searchBar.placeholder = data.placeHolder
    }
    
}
extension SearchBarCell: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()        
        guard let filter = searchBar.text else {
            return
        }
        self.delegate?.search(cell: self, filter: filter, page: 1)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.delegate?.changeText(cell: self, searchText: searchText)
    }
}
extension SearchBarCell: ProtocolCell {
    static var height: CGFloat {
        return 60
    }
    
    static var identifier: String {
        return "SearchBarCell"
    }
}
struct SearchBarCellData {
    let placeHolder:String
}

