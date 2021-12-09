
import UIKit
import FirebaseAuth

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = LikeListViewController()
//        let vc3 = ReviewViewController()
        let vc3 = MyProfileViewController()

        vc1.title = "홈"
        vc2.title = "좋아요"
        vc3.title = "나의 정보"
//        vc4.title = "나의 정보"

        self.setViewControllers([vc1, vc2, vc3], animated: false)

        guard let items = self.tabBar.items else { return }

        let images = ["house", "suit.heart.fill", "person.fill"]

        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        self.modalPresentationStyle = .fullScreen
        
            
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            
            let tabBarVC = TabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: false, completion: nil)
            
        } else {
            
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false, completion: nil)
        }
    }
}
