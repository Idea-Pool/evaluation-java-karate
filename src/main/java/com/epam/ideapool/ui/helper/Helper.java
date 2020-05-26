package com.epam.ideapool.ui.helper;

import net.minidev.json.JSONArray;

public class Helper {
    public static boolean hasNoHello(JSONArray options) {
        return options.stream().noneMatch("hello"::equals);
    }
}
