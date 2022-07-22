//
//  PostViewController.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import UIKit

class PostViewController: UIViewController {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    //variables
    var cells:[CustomCell] = []
    
    // MARK: Properties
    var presenter: PostPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configCells()
        loadTable()
    }
    func configTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: SearchBarCell.identifier, bundle: nil), forCellReuseIdentifier: SearchBarCell.identifier)
        self.tableView.isScrollEnabled = true
        self.tableView.tableFooterView = UIView()
    }
    func configCells() {
        cells = []
        cells.append(.searchBarCell(SearchBarCellData(placeHolder: "Buscar posts")))        
    }
    func loadTable() {
        self.tableView.reloadData()
    }
}

extension PostViewController: PostViewControllerProtocol {
    // TODO: implement view output methods
}
extension PostViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let custom = cells[indexPath.row]
        switch custom {
        case .searchBarCell(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarCell.identifier, for: indexPath) as! SearchBarCell
            cell.configure(data: data)
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            return cell
        }
    }
}
extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = cells[indexPath.row]
        switch cell {
        case .searchBarCell(_):
            return SearchBarCell.height
        default :
            return 0
        }
    }
}
extension PostViewController: SearchBarCellDelegate {
    func search(cell: SearchBarCell, filter: String, page: Int) {
        print(filter)
    }
    func changeText(cell: SearchBarCell, searchText: String) {
        print(searchText)
    }
}
