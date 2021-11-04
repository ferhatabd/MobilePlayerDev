
import UIKit
import AVKit
import MobilePlayer

enum PlaybackMode: Int {
    case none = 0
    case local = 1
    case remote = 2
    
}

// MARK: - Added models for demo purposes
struct Course {
    var courseUrl: String? = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
    var title = "Some Title"
}
struct PlayerViewModel {
    var course: Course?
}

 // TODO:
class CoursePlayerVC: MobilePlayer.MobilePlayerViewController {

   

    /* ------------------------------------------------------- */
    // MARK:  Properties
    /* ------------------------------------------------------- */
    
    //
    // MARK: Private properties
    //
    
    /// View model
    fileprivate var viewModel: PlayerViewModel!
    
    /// Current playback mode
    private var playbackMode: PlaybackMode = .none
    
    // MARK: -  Public properties
    //
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .landscapeLeft
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        [.landscapeLeft, .landscapeRight]
    }
    
    override class var bundleForResources: URL? { Bundle.main.bundleURL }
    
    // MARK: - UIViewController lifecycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PlayerViewModel(course: Course())
        _setupUI()
    }
    
    override func readyToPlay() {
        super.readyToPlay()
    }
    
    
    /* MARK: -  */
    /* ------------------------------------------------------- */
    // MARK: Init
    /* ------------------------------------------------------- */
    
    
    /* MARK: -  */
    /* ------------------------------------------------------- */
    // MARK: Methods
    /* ------------------------------------------------------- */
    
    /* MARK: -  */
    // MARK:  Private methods
    //
    /// Prepare the layout
    private func _setupUI() {
        //
        // Prepare the elements
        //
        
        //
        if viewModel != nil { layout() }
    }
    
    /// Sets the ui
    private func layout() {
        guard let course = viewModel?.course, let path = course.courseUrl, let url = URL(string: path)
            else { return }
        
        self.setConfig(contentURL: url)
        self.title = course.title
        self.activityItems = [url]

    }
    
    // MARK: - Public methods
    //
    
    
    /// Sets a new model for the player
    /// - Parameter model: New model
    public func setModel(_ model: PlayerViewModel) {
        self.viewModel = model
        DispatchQueue.main.async {
            self.layout()
        }
    }
    
}
