import Vapor
import Queues

struct OutsideJob: Job {
    struct Payload: Codable {
        let name: String
    }

    func dequeue(_ context: QueueContext, _ payload: Payload) -> EventLoopFuture<Void> {
        print("OutsideJob > dequeue: \(payload)")
        return context.queue.dispatch(InsideJob.self, .init(email: "chwe@nodesagency.com"))
    }

    func error(_ context: QueueContext, _ error: Error, _ payload: Payload) -> EventLoopFuture<Void> {
        print("OutsideJob > error: \(error)")
        return context.eventLoop.future()
    }
}
