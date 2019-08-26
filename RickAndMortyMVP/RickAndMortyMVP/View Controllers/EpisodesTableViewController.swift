//
//  EpisodesTableViewController.swift
//  RickAndMortyMVP
//
//  Created by omaestra on 26/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class EpisodesTableViewController: UITableViewController {

    lazy var cancelButton: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel(_:)))
        return buttonItem
    }()
    
    var episodes: [Episode]?
    var episodesIds: [String]?
    var presenter: EpisodePresenter = EpisodePresenter(service: EpisodeService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        // Bind presenter
        presenter.setViewDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let episodesIds = self.episodesIds {
            self.navigationItem.leftBarButtonItem = cancelButton
            
            presenter.loadMultipleEpisodes(idsArray: episodesIds)
        } else {
            presenter.loadEpisodes()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.reuseIdentifier, for: indexPath) as! EpisodeTableViewCell
        
        let episode = episodes?[indexPath.row]
        
        cell.episodeLabel.text = episode?.episode
        cell.nameLabel.text = episode?.name
        cell.airDateLabel.text = episode?.airDate
        
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

extension EpisodesTableViewController: EpisodeViewDelegate {
    func displayPagedEpisodes(with pagedData: PagedData<Episode>) {
        self.episodes = pagedData.results
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayEpisodes(_ episodes: [Episode]) {
        self.episodes = episodes
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
