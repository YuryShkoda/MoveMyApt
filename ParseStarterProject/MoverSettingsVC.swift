//
//  MoverSettingsVC.swift
//  moveMyStuff
//
//  Created by Yury on 9/5/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class MoverSettingsVC: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                var errorMessage = "Error while logging out!!!"
                let error = error as NSError?
                
                if let parseError = error?.userInfo["error"] as? String {
                    errorMessage = parseError
                }
                //TODO: show error to user
                print(errorMessage)
            } else {
                self.performSegue(withIdentifier: "moverLogOutSegue", sender: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
