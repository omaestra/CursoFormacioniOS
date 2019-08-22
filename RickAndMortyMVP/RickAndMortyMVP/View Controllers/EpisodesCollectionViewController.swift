//
//  EpisodesCollectionViewController.swift
//  RickAndMorty
//
//  Created by Usuario on 14/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class EpisodesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var cancelButton: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel(_:)))
        return buttonItem
    }()
    
    var episodes: [Episode]?
    var episodesIds: [String]?
    let episodeController = EpisodeController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView?.register(EpisodeCollectionViewCell.nib, forCellWithReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier)

        if let episodesIds = self.episodesIds {
            
            self.navigationItem.leftBarButtonItem = cancelButton
            
            episodeController.loadMultipleEpisodes(withIds: episodesIds) { [weak self] (episodes) in
                self?.episodes = episodes
                
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            }
        } else {
            episodeController.loadEpisodes { [weak self] (pagedData) in
                if let pagedData = pagedData {
                    self?.episodes = pagedData.results
                }
                
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func handleCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return episodes?.count ?? 0
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.reuseIdentifier, for: indexPath) as! EpisodeCollectionViewCell
        
        let episode = episodes?[indexPath.row]
        
        cell.episodeLabel.text = episode?.episode
        cell.episodeNameLabel.text = episode?.name
        cell.episodeAirDateLabel.text = episode?.airDate
    
        return cell
    }
    
    // MARK: UICollectionViewFlowLayoutDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        
        return CGSize(width: size.width/2-10, height: size.width/2-10)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
