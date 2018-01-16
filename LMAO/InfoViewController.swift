import UIKit

class InfoViewController: UIViewController {

    @IBOutlet var imgIcon: UIImageView!
    
    @IBOutlet var TopIcon: NSLayoutConstraint!
    @IBOutlet var TopAppName: NSLayoutConstraint!
    @IBOutlet var TopTagLine: NSLayoutConstraint!
    @IBOutlet var TopCredits: NSLayoutConstraint!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgIcon.clipsToBounds = true
        imgIcon.layer.cornerRadius = 10
        
        if UIScreen.main.bounds.height == 480.0 {
            TopIcon.constant = 10
            TopAppName.constant = 8
            TopTagLine.constant = 10
            TopCredits.constant = 25
        }

        if UIDevice.current.userInterfaceIdiom == .pad {
            TopIcon.constant = 80
            TopAppName.constant = 30
            TopTagLine.constant = 50
            TopCredits.constant = 60
        }

    }
  }
