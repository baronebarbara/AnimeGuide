import class UIKit.UIViewController

enum AnimeListFactory {
    static func build() -> UIViewController {
        let viewModel = AnimeListViewModel()
        return AnimeListViewController(viewModel: viewModel)
    }
}
