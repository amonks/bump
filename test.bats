#!/usr/bin/env bats

@test "bumps major version" {
    run ./lib/index.js major 2.2.2
    [ "$status" -eq 0 ]
    [ "$output" = "3.0.0" ]
}

@test "bumps minor version" {
    run ./lib/index.js minor 2.2.2
    [ "$status" -eq 0 ]
    [ "$output" = "2.3.0" ]
}

@test "bumps patch version" {
    run ./lib/index.js patch 2.2.2
    [ "$status" -eq 0 ]
    [ "$output" = "2.2.3" ]
}

@test "prints help when given no arguments" {
    run ./lib/index.js
    [ "$status" -eq 1 ]
    [[ $output =~ "BUMP" ]]
    [[ $output =~ "usage" ]]
}

@test "errors when given a bad command" {
    run ./lib/index.js majorrrr 1.0.0
    [ "$status" -ne 0 ]
    [[ $output =~ "usage" ]]
    [[ $output =~ "Unsupported type majorrr" ]]
}

@test "errors when given an unparseable version" {
    run ./lib/index.js major a.b.c
    [ "$status" -ne 0 ]
    [[ $output =~ "usage" ]]
    [[ $output =~ "Unparseable version a.b.c" ]]
}
