//
//  CharactersCollectionViewController.swift
//  RickAndMortyMVP
//
//  Created by omaestra on 26/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit
import FirebaseAuth

class CharactersCollectionViewController: UICollectionViewController {
    
    var cellsPerRow: CGFloat = 1
    let cellPadding: CGFloat = 5

    var characters: [Character] = []
    var pagedData: PagedData<Character>?
    
    private let presenter = CharactersPresenter(service: CharacterService())
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(CharacterCollectionViewCell.nib, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        
        presenter.setViewDelegate(delegate: self)
        presenter.loadCharacters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        //        loadCharacters()
    }
    
    private func fetchNextPage() {
        //        loadCharacters()
    }
    
    private func isLoading(at indexPath: IndexPath) -> Bool {
        return indexPath.row == self.characters.count-1
    }
    
    // MARK: - Actions

    @IBAction func handleLogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            self.performSegue(withIdentifier: "unwindToMainViewController", sender: nil)
            //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //            let loginController = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
            //            appDelegate.window?.rootViewController = loginController
            //            appDelegate.window?.makeKeyAndVisible()
        } catch {
            print("[ERROR]: Couldn't log out user.")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacter" {
            let destination = segue.destination as! CharacterDetailsTableViewController

            if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                destination.character = characters[indexPath.row]
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
    
        let character = characters[indexPath.row]
        
        cell.nameLabel.text = character.name
        cell.characterImageView.loadImage(fromURL: character.image)
        cell.speciesLabel.text = "\(character.species)"
        
        if character.type != "" {
            cell.speciesLabel.text?.append(" - \(character.type)")
        }
        
        cell.genderLabel.text = character.gender
        cell.statusLabel.text = character.status.rawValue
        cell.statusLabel.textColor = character.status.color
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCharacter", sender: self)
    }
    
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

extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthMinusPadding = collectionView.bounds.width - (cellPadding + cellPadding * cellsPerRow)
        let eachSide = widthMinusPadding / cellsPerRow
        return CGSize(width: eachSide, height: eachSide)
        
//        return CGSize(width: view.frame.width - 10, height: view.frame.width - 10)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cellsPerRow = (traitCollection.verticalSizeClass == .compact) ? 3 : 1
        collectionView?.reloadData()
    }
}

extension CharactersCollectionViewController: CharacterViewDelegate {
    func displayCharacters(pagedData: PagedData<Character>) {
        self.pagedData = pagedData
        self.characters = pagedData.results
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}
