import Vapor
import Queues

struct InsideJob: Job {
    struct Payload: Codable {
        let email: String
    }

    func dequeue(_ context: QueueContext, _ payload: Payload) -> EventLoopFuture<Void> {
        context.logger.info("InsideJob > dequeue: \(payload)")
        return context.eventLoop.future()
    }

    func error(_ context: QueueContext, _ error: Error, _ payload: Payload) -> EventLoopFuture<Void> {
        context.logger.info("InsideJob > error: \(error)")
        return context.eventLoop.future()
    }
}
