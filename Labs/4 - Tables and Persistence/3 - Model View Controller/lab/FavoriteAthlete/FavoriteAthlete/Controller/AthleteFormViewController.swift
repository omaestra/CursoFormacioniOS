//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by omaestra on 25/07/2019.
//

import UIKit

class AthleteFormViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var leagueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    
    var athlete: Athlete?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateView()
    }
    
    func updateView() {
        if let athlete = self.athlete {
            self.nameTextField.text = athlete.name
            self.ageTextField.text = "\(athlete.age)"
            self.leagueTextField.text = athlete.league
            self.teamTextField.text = athlete.team
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
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let name = nameTextField.text,
            let ageString = ageTextField.text,
            let age = Int(ageString),
            let league = leagueTextField.text,
            let team = teamTextField.text else { return }
        
        self.athlete = Athlete(name: name, age: age, league: league, team: team)
        
        self.performSegue(withIdentifier: "unwindToAthleteTableViewController", sender: athlete)
    }
    
}
