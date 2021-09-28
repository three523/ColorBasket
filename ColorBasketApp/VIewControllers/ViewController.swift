
import UIKit

class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
//        let vc3 = ReviewViewController()
        let vc3 = MyProfileViewController()

        vc1.title = "홈"
        vc2.title = "검색"
        vc3.title = "평가"
        vc4.title = "나의 정보"

        self.setViewControllers([vc1, vc2, vc3, vc4], animated: false)

        guard let items = self.tabBar.items else { return }

        let images = ["house", "magnifyingglass", "star", "person.fill"]

        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }

        self.modalPresentationStyle = .fullScreen
        
    }
}
