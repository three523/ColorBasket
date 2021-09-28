
import UIKit

class ViewController: UITabBarController {
    
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
