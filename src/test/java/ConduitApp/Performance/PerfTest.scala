package Performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol()

  //protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
   protocol.runner.karateEnv("perf")

  val createArticle = scenario("Create and delete article").exec(karateFeature("classpath:ConduitApp/Performance/createArticle.feature"))
  

  setUp(
    createArticle.inject(
        atOnceUsers(1)
        ).protocols(protocol)
  )

}