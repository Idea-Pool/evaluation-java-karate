package com;

import com.intuit.karate.junit5.Karate;

class AllTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
    
}
