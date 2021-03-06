import Slam

class MockQueueView: QueueView {
    var wasShowMatchesCalled = false
    var wasRemovedMatchCalled = false

    override func showMatches(matches: [Match]) {
        self.wasShowMatchesCalled = true
    }

    override func removedMatch() {
        self.wasRemovedMatchCalled = true
    }
}