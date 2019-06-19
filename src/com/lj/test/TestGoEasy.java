package com.lj.test;

import io.goeasy.GoEasy;
import org.junit.Test;

public class TestGoEasy {
    @Test
    public void testGoEasy(){
        GoEasy goEasy = new GoEasy( "http://rest-hangzhou.goeasy.io", "BC-39419ba4feae497a8f616b8fc931252f");
          goEasy.publish("my_channel","Hello, GoEasy!");
    }
}
