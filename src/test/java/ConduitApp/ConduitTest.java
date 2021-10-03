package ConduitApp;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

class ConduitTest {

    @Test
    Karate testAll(){
        return Karate.run().relativeTo(getClass());
    }

    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@debug").relativeTo(getClass());
    }

}
