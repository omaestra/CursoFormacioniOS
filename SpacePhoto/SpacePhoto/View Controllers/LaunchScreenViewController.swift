//
//  LaunchScreenViewController.swift
//  SpacePhoto
//
//  Created by omaestra on 08/08/2019.
//  Copyright © 2019 omaestra. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataAndNavigate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func fetchDataAndNavigate() {
        let queries: [String: String] = [
            "api_key": "vgmntRvK9bQ1SNnn1n6z9ieib2FcdlHhSsOqmfTf"
        ]
        
        photoInfoController.fetchMultiplePhotosInfo(queries: queries) { (photoInfoArray) in
            DispatchQueue.main.async {
                let mainNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
                
                let photoInfoTableViewController = mainNavigationController.topViewController as! PhotoInfoTableViewController
                
                photoInfoTableViewController.photoInfoArray = photoInfoArray
                photoInfoTableViewController.photoInfoController = self.photoInfoController
                
                let window = (UIApplication.shared.delegate as! AppDelegate).window
                
                UIView.animate(withDuration: 0.5, delay: 1.5, options: [.transitionCrossDissolve], animations: {
                    window?.rootViewController!.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut], animations: {
                        window?.rootViewController!.view.transform = CGAffineTransform.identity
                    }, completion: { (_) in
                        window?.rootViewController = mainNavigationController
                        window?.rootViewController?.navigationController?.navigationController?.navigationBar.prefersLargeTitles = true
                        window?.makeKeyAndVisible()
                    })
                })
                
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
