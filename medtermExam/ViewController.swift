//
//  ViewController.swift
//  medtermExam
//
//  Created by Abdalla Elnajjar on 2022-06-05.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    var dataStore = DataStore.shared
    var cellIdentifier = "cell"
    // TODO: add variables 20 points
    
    @IBOutlet weak var searchBar: UISearchBar!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: write UISearch setup add 20 points
        // add cabcel button
        // add text placeholder
        // add clear button
        
        searchBar.delegate = self
//        searchController.searchResultsUpdater = self
        
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Posts"
        
        navigationItem.titleView = searchBar
        
        dataStore.getData( hostURl:"jsonplaceholder.typicode.com" ,path: "/posts", params: nil, completion: { (result) in
            switch result {
                case .success(let result):
                    self.posts = result
        
                    self.tableView.reloadData()
                    break
                    
                case .failure(let error):
                    print(error)
                    
                    break;
            }
        })
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func searchPosts(for searchText: String) {
        // TODO: complete searchPosts 20 points
        posts = posts.filter { post in
            return post.title.contains(searchText.lowercased())
      }
      tableView.reloadData()
    }
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PostCell
        
        let post = posts[indexPath.row]
        cell.fillCell(title: post.title)
        
        return cell
    }
    
    // TODO: complete  UITableViewDataSource and  UITableView delegate 20 points

}
//MARK: UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        searchPosts(for: text)
    }
    
    // TODO: complete  UITableViewDataSource 20 points
}

//MARK: Navigation
extension ViewController{
    // TODO: Add segue and Detal View Screen 20 points
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedPost = posts[indexPath.row]
        
        let detailedView = DetailedViewController()
        detailedView.postDataLabel.text = selectedPost.body
        
        performSegue(withIdentifier: "DetailedView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailedView" {
            guard segue.destination is DetailedViewController else { return }
        }
    }
    
}


