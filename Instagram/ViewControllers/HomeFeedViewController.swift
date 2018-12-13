//
//  HomeFeedViewController.swift
//  Instagram
//
//  Created by Stephon Fonrose on 12/6/18.
//  Copyright © 2018 Stephon Fonrose. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!
    var posts: [Post?] = []
    var didActionHappen:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = 300 //UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        self.navigationController?.navigationBar.isHidden = false
        activityIndicator.startAnimating()
        fetchPosts()
        tableView.reloadData()
        if didActionHappen == true {
            didActionHappen = !didActionHappen
            fetchPosts()
            tableView.reloadData()
        }
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeFeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        let username =  PFUser.current()?.username
        welcomeLabel.text = ("Welcome, \(username ?? "")")
    }
    
    func fetchPosts() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("createdAt")
        query?.limit = 20
        
        query?.findObjectsInBackground { (posts ,error) in
            if let posts = posts {
                print("Posts were found!")
                self.posts = posts as! [Post]
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchPosts()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath) as! PictureCell
        if let post = posts[indexPath.row] {
            print("Individual post opened!")
            let image = post.media
            
            image.getDataInBackground(block: {(data, error) in
                    if (error != nil) {
                        print(error!.localizedDescription)
                    } else {
                        print("Image was found!")
                        cell.postImage.image = UIImage(data: data!)
                    }
                
                })
            cell.postCaption.text = post.caption
        }
        
        return cell
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
                print(error!.localizedDescription)
            }
        }
        self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    @IBAction func onCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "composeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell {
        if let indexPath = tableView.indexPath(for: cell) {
            let post = posts[indexPath.row]
            let vc = segue.destination as! PostDetailsViewController
            vc.post = post
            }
        }
    }
    
}
