import UIKit

class DisclaimerViewController: UIViewController {
    @IBOutlet weak var agreeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        agreeButton.backgroundColor = .clear
        agreeButton.layer.cornerRadius = 5
        agreeButton.layer.borderWidth = 1
        agreeButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    @IBAction func agreeAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isAccepted")
        dismiss(animated: true, completion: nil)
    }
}
