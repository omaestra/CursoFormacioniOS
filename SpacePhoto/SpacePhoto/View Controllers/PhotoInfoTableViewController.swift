//
//  PhotoInfoTableViewController.swift
//  SpacePhoto
//
//  Created by omaestra on 07/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import MBProgressHUD
import Kingfisher

class PhotoInfoTableViewController: UITableViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        return activityIndicator
    }()
    
    lazy var dataRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
//        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        return refreshControl
    }()

    var photoInfoController: PhotoInfoController = PhotoInfoController()
//    var photoInfoController: PhotoInfoController!
    
    var photoInfoArray: [PhotoInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let nib: UINib = UINib(nibName: "PhotoInfoTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "photoInfoCell")
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PhotoInfoTableViewCell.nib, forCellReuseIdentifier: PhotoInfoTableViewCell.reuseIdentifier)
        
        tableView.tableFooterView = UIView()
        tableView.backgroundView = activityIndicator
        
        tableView.refreshControl = dataRefreshControl
        
        fetchPhotosInfoData()
    }
    
    private func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: self.tableView, animated: true)
        hud.label.text = "Loading..."
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hide(for: self.tableView, animated: true)
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        fetchPhotosInfoData()
    }
    
    fileprivate func fetchPhotosInfoData() {
        let queries: [String: String] = [
            "api_key": "vgmntRvK9bQ1SNnn1n6z9ieib2FcdlHhSsOqmfTf"
        ]
        
        //        activityIndicator.startAnimating()
        showLoadingHUD()
        photoInfoController.fetchPhotosInfoUsingAlamofire(queries: queries) { [weak self] (photoInfoArray) in
            
            guard let strongSelf = self else { return }
            
            if let photoInfoArray = photoInfoArray {
                strongSelf.photoInfoArray = photoInfoArray
            }
            
            DispatchQueue.main.async {
                //                self.activityIndicator.stopAnimating()
                strongSelf.hideLoadingHUD()
                strongSelf.dataRefreshControl.endRefreshing()
                strongSelf.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photoInfoArray?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoInfoTableViewCell.reuseIdentifier, for: indexPath) as! PhotoInfoTableViewCell

        
        guard let photoInfo = photoInfoArray?[indexPath.row] else { return UITableViewCell() }
        
        cell.titleLabel.text = photoInfo.title
        cell.descriptionLabel.text = photoInfo.description
        cell.photoInfoImageView.kf.setImage(with: photoInfo.url)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
