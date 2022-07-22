//
//  PostDetailViewController.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import UIKit

protocol PostDetailViewControllerProtocol: AnyObject {
    var presenter: PostDetailPresenterProtocol? { get set }
    func getPost(post:Post? , error:Error?)
}

class PostDetailViewController: UIViewController {
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    //variables
    var cells:[CustomCell] = []
    var post:Post?
    
    // MARK: Properties
    var presenter: PostDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configCells()
        presenter?.getPost()
    }
    func configTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: UserCell.identifier, bundle: nil), forCellReuseIdentifier: UserCell.identifier)
        self.tableView.register(UINib(nibName: PostCell.identifier, bundle: nil), forCellReuseIdentifier: PostCell.identifier)
        self.tableView.isScrollEnabled = true
        self.tableView.tableFooterView = UIView()
    }
    func configCells() {
        guard let post = post else {
            return
        }
        cells = []
        cells.append(.userCell(
            UserCellData(id: post.id, userId: post.userId)
        ))
        cells.append(.postCell(
            PostCellData(post: post)
        ))
    }
    func loadTable() {
        self.tableView.reloadData()
    }
}

extension PostDetailViewController: PostDetailViewControllerProtocol {
    func getPost(post: Post?, error: Error?) {
        if let error = error {
            print(error)
            return
        }
        if let post = post {
            self.post = post
        }
        self.configCells()
        self.loadTable()
    }
}
extension PostDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let custom = cells[indexPath.row]
        switch custom {
        case .userCell(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
            cell.configure(data: data)
            return cell
        case .postCell(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
            cell.configure(data: data)
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
extension PostDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = cells[indexPath.row]
        switch cell {
        case .userCell(_):
            return UserCell.height
        case .postCell(_):
            return PostCell.height
        default :
            return 0
        }
    }
}

