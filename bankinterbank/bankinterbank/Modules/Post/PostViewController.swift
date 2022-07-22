//
//  PostViewController.swift
//  bankinterbank
//
//  Created by Miguel on 21/07/22.
//

import UIKit

protocol PostViewControllerProtocol: AnyObject {
    var presenter: PostPresenterProtocol? { get set }
    func getPost(meta:Meta?, posts:[Post]? , error:Error?)
}

class PostViewController: UIViewController {
    //Outlets
    @IBOutlet weak var headerTableView: UITableView!
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    //variables
    var cellsHeader:[CustomCell] = []
    var cells:[CustomCell] = []
    var posts:[Post] = []
    var pagination:Pagination?
    var links:Links?
    
    // MARK: Properties
    var presenter: PostPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        configCells()
        self.indicatorView.startAnimating()
        let request = PostRequest(title: "",page: 1)
        presenter?.getPost(request: request)
    }
    func configTable() {
        self.headerTableView.dataSource = self
        self.headerTableView.delegate = self
        self.headerTableView.register(UINib(nibName: SearchBarCell.identifier, bundle: nil), forCellReuseIdentifier: SearchBarCell.identifier)
        self.headerTableView.isScrollEnabled = false
        self.headerTableView.tableFooterView = UIView()
        
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        self.postTableView.register(UINib(nibName: PostCell.identifier, bundle: nil), forCellReuseIdentifier: PostCell.identifier)
        self.postTableView.isScrollEnabled = true
        self.postTableView.tableFooterView = UIView()
    }
    func configCells() {
        cellsHeader = []
        cellsHeader.append(.searchBarCell(SearchBarCellData(placeHolder: "Buscar posts")))
        
        cells = []
        for post in posts {
            cells.append(.postCell(
                PostCellData(post: post)
            ))
        }
    }
    func loadTable() {
        self.postTableView.reloadData()
    }
}

extension PostViewController: PostViewControllerProtocol {
    func getPost(meta: Meta?, posts: [Post]?, error: Error?) {
        self.indicatorView.stopAnimating()
        self.indicatorView.isHidden = true
        if let error = error {
            print(error)
            return
        }
        if let posts = posts {
            self.posts = posts
        }
        if let pagination = meta?.pagination, let links = meta?.links {
            self.pagination = pagination
            self.links = links
        }
        self.configCells()
        self.loadTable()
    }
}
extension PostViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == headerTableView {
            return cellsHeader.count
        }
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == headerTableView {
            let custom = cellsHeader[indexPath.row]
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
        
        let custom = cells[indexPath.row]
        switch custom {
        case .postCell(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
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
        if tableView == headerTableView {
            let cell = cellsHeader[indexPath.row]
            switch cell {
            case .searchBarCell(_):
                return SearchBarCell.height
            default :
                return 0
            }
        }
        let cell = cells[indexPath.row]
        switch cell {
        case .postCell(_):
            return PostCell.height
        default :
            return 0
        }
    }
}
extension PostViewController: SearchBarCellDelegate {
    func search(cell: SearchBarCell, filter: String, page: Int) {
        let request = PostRequest(title: filter, page: page)
        presenter?.getPost(request: request)
    }
    func changeText(cell: SearchBarCell, searchText: String) {
        let request = PostRequest(title: searchText, page: 1)
        presenter?.getPost(request: request)
    }
}
extension PostViewController: PostCellDelegate {
    func selected(cell: PostCell) {
        guard let post = cell.data?.post else { return }
        let postDetailViewController = PostDetailWireFrame.createPostModule(post: post) as! PostDetailViewController
        self.present(postDetailViewController, animated: true)        
    }
}
