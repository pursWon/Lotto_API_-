import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var modeSwitchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayer()
        setFont()
        ThemeProvider.shared.register(observer: self)
    }
    
    let url = "https://www.randomnumberapi.com/api/v1.0/random?min=100&max=1000&count=5"
    
    func setFont() {
        titleLabel.font = .boldSystemFont(ofSize: 40)
    }
    
    func setLayer() {
        generateButton.layer.cornerRadius = 65
        modeSwitchButton.onTintColor = .green
    }
    
    func getLottoNumber(url: String) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            guard error == nil else { return }
            
            switch response.statusCode {
            case 200:
                print("성공")
                let lotto = try? JSONDecoder().decode([Int].self, from: data)
                if let lotto = lotto {
                    print(lotto)
                    DispatchQueue.main.async {
                        self.firstLabel.text = String(lotto[0])
                        self.secondLabel.text = String(lotto[1])
                        self.thirdLabel.text = String(lotto[2])
                        self.fourthLabel.text = String(lotto[3])
                        self.fifthLabel.text = String(lotto[4])
                    }
                } else {
                    print("파싱 실패")
                }
                
            default:
                print("실패")
            }
        }
        
        dataTask.resume()
    }
    
    @IBAction func ModeSwitch(_ sender: UISwitch) {
        ThemeProvider.shared.toggleTheme()
    }
    
    @IBAction func generateButton(_ sender: UIButton) {
        getLottoNumber(url: url)
    }
}

extension ViewController: Themeable {
    func apply(theme: Theme) {
        view.backgroundColor = theme.tableViewBackground
    }
}
