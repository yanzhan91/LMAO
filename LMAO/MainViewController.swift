import UIKit

class MainViewController: UIViewController {

    @IBOutlet var imgBgTop: UIImageView!
    @IBOutlet var imgBgBottom: UIImageView!
    
    @IBOutlet var btnScreen: SpringButton!
    @IBOutlet var btnShare: SpringButton!
    @IBOutlet var btnInfo: SpringButton!
    
    @IBOutlet var txtQuote: SpringTextView!
    
    @IBOutlet var btnRandom: SpringButton!
    
    fileprivate let jokeService = JokesService()
    
    fileprivate var jokes: Array<Joke> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = APP_NAME
        
        setButtons()
        generateRandomQuote()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isAccepted = UserDefaults.standard.bool(forKey: "isAccepted")
        if !isAccepted {
            let disclaimerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "disclaimerVC") as? DisclaimerViewController
            self.present(disclaimerVC!, animated: true, completion: nil)
        }
    }
    
    // -------------------
    // BUTTON SCREEN QUOTE
    // -------------------
    
    @IBAction func btnScreen(_ sender: Any) {
        if let button = sender as? UIButton {
            button.isSelected = false
            
        }
        let img = takeScreenShot()
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        showAlert(msg: "Screenshot captured and sent to your photo album")
    }
    
    // ------------------
    // BUTTON SHARE QUOTE
    // ------------------
    
    @IBAction func btnShare(_ sender: AnyObject) {
        let img = takeScreenShot()
        let activityViewController = UIActivityViewController(activityItems: [img, SHARED_FROM], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func takeScreenShot() -> UIImage {
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenshot!
    }
    
    // -------------------
    // BUTTON RANDOM QUOTE
    // -------------------
    
    @IBAction func btnRandom(_ sender: AnyObject) {
        generateRandomQuote()
        txtQuote.animation = "fadeIn"
        txtQuote.duration = 1.8
        txtQuote.animate()
    }
    
    func generateRandomQuote() {
        jokeService.getJokes() { (response, error) in
            if error == nil {
                self.jokes = response
                self.formatQuote(response[0].joke)
            } else {
                if self.jokes.isEmpty {
                    self.showAlert(msg: "No network connection")
                } else {
                    let rand = Int(arc4random_uniform(UInt32(self.jokes.count)))
                    self.formatQuote(self.jokes[rand].joke)
                }
            }
        }
    }
    
    func formatQuote(_ quote: String){
        
        if UIDevice.current.userInterfaceIdiom == .pad {

            // iPAD Formatting
            // ---------------
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 8                                              // Line Height
            let attributes = [NSAttributedStringKey.paragraphStyle : style]
            txtQuote.attributedText = NSAttributedString(string: quote, attributes: attributes)
        
            txtQuote.font = FONT_QUOTE_iPad                                     // Font type & Size
            txtQuote.textColor = FONT_QUOTE_COLOR                               // Font Color
 
        } else {
        
            // iPhone/iPod Formatting
            // ----------------------
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 3                                               // Line Height
            let attributes = [NSAttributedStringKey.paragraphStyle : style]
            txtQuote.attributedText = NSAttributedString(string: quote, attributes: attributes)
        
            let screenSize: CGRect = UIScreen.main.bounds
            let screenHeight = screenSize.height
            
            if screenHeight == 480.0 {
            txtQuote.font = FONT_QUOTE_iPhone4                                  // Font type & Size iPhone 3.5
            } else {
            txtQuote.font = FONT_QUOTE_iPhone                                   // Font type & Size
            }

            txtQuote.textColor = FONT_QUOTE_COLOR                               // Font Color
            
        }

        txtQuote.textAlignment = .center                                    // Alignment
        txtQuote.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    func setButtons(){
        btnScreen.clipsToBounds = true
        btnScreen.layer.cornerRadius = 25
        btnScreen.layer.borderWidth = 3
        btnScreen.layer.borderColor = UIColor.white.cgColor
        
        btnShare.clipsToBounds = true
        btnShare.layer.cornerRadius = 25
        btnShare.layer.borderWidth = 3
        btnShare.layer.borderColor = UIColor.white.cgColor
        
        btnInfo.clipsToBounds = true
        btnInfo.layer.cornerRadius = 25
        btnInfo.layer.borderWidth = 3
        btnInfo.layer.borderColor = UIColor.white.cgColor
        
        btnScreen.animation = "fadeInRight"
        btnScreen.delay = 0.3
        btnScreen.duration = 1.0
        btnScreen.animate()
        
        btnShare.animation = "fadeInDown"
        btnShare.delay = 0.3
        btnShare.duration = 1.0
        btnShare.animate()
        
        btnInfo.animation = "fadeInLeft"
        btnInfo.delay = 0.3
        btnInfo.duration = 1.0
        btnInfo.animate()
        
        btnRandom.animation = "fadeIn"
        btnRandom.delay = 0.2
        btnRandom.duration = 3.4
        btnRandom.animate()
    }
    
    func showAlert(msg: String) {
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
