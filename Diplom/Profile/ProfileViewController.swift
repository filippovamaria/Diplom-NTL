//
//  ProfileViewController.swift
//  Diplom
//
//  Created by Мария Филиппова on 12.04.2022.
//

import UIKit

 class ProfileViewController: UIViewController {

    private lazy var tableViewFeed: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableViewFeed)
        self.setupView()
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = false
    }

    private func setupView() {
        self.view.backgroundColor = .white
        
        let tableViewFeedTop = self.tableViewFeed.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let tableViewFeedLeft = self.tableViewFeed.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let tableViewFeedRight = self.tableViewFeed.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let tableViewFeedBottom = self.tableViewFeed.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            tableViewFeedTop, tableViewFeedLeft, tableViewFeedRight, tableViewFeedBottom
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate, ExtendedPostDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableViewFeed.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableViewFeed.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            let model = postArray[indexPath.row - 1]
            cell.selectionStyle = .none
            cell.delegate = self
            cell.setUpCell(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return postArray.count + 1
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photosViewController = PhotosViewController()
        if  indexPath.row == 0 {
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row != 0 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tableViewFeed.beginUpdates()
        if indexPath.row != 0 {
            postArray.remove(at: indexPath.row - 1)
            tableViewFeed.deleteRows(at: [indexPath], with: .automatic)
        }
        self.tableViewFeed.endUpdates()
    }
    
    func didTapLikesLabelDelegate(cell: PostTableViewCell) {
        guard let index = tableViewFeed.indexPath(for: cell)?.row else { return }
        postArray[index - 1].likes += 1
        let indexRow = IndexPath(row: index, section: 0)
        tableViewFeed.reloadRows(at: [indexRow], with: .none)
    }
    
    func didTapPostImageDelegate(cell: PostTableViewCell) {
        let expendedPost = ExtendedPost()
        expendedPost.delegate = self
        
        guard let index = tableViewFeed.indexPath(for: cell)?.row else { return }
        postArray[index - 1].views += 1
        let indexRow = IndexPath(row: index, section: 0)
        tableViewFeed.reloadRows(at: [indexRow], with: .none)
        
        let newModel = postArray[index - 1]
        expendedPost.setUpCell(with: newModel)
        navigationController?.tabBarController?.tabBar.isHidden = true
        
        view.addSubview(expendedPost)

        let top = expendedPost.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let left = expendedPost.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let right = expendedPost.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = expendedPost.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        NSLayoutConstraint.activate([top, left, right, bottom])
    }
    
    func didTapButtonMultiplyDelegate(view: ExtendedPost) {
        navigationController?.tabBarController?.tabBar.isHidden = false
        view.removeFromSuperview()
    }
}

