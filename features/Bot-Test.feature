Feature: Jitsi Bot-Tests

  
  @test-join1
  Scenario: Ein Bot joint
    Given Bot 1 joint der Sitzung "hallo2" ohne Video
    When warte 20 Sekunden

  @test-join4
  Scenario: Vier Bots joint
    Given Bot 1 joint der Sitzung "hrtf1" ohne Video
    Given Bot 2 joint der Sitzung "hrtf1" ohne Video
    Given Bot 3 joint der Sitzung "hrtf1" ohne Video
    Given Bot 4 joint der Sitzung "hrtf1" ohne Video
    When warte 60 Sekunden


  @test-join8
  Scenario: Ein Bot joint
    Given Bot 1 joint der Sitzung "debug1" ohne Video
    Given Bot 2 joint der Sitzung "debug1" ohne Video
    Given Bot 3 joint der Sitzung "debug1" ohne Video
    Given Bot 4 joint der Sitzung "debug1" ohne Video
    Given Bot 5 joint der Sitzung "debug1" ohne Video
    Given Bot 6 joint der Sitzung "debug1" ohne Video
    Given Bot 7 joint der Sitzung "debug1" ohne Video
    Given Bot 8 joint der Sitzung "debug1" ohne Video
    When warte 20 Sekunden
  
  @test-audio1
  Scenario: Ein Bot mit Testaudio
    Given Bot 1 joint der Sitzung "debug1" ohne Video
    When Bot 1 Taste M betätigt
    When warte 20 Sekunden

  @test-audio3
  Scenario: 4er Lokalisation
    Given Bot 1 joint der Sitzung "x10" ohne Video
    Given Bot 2 joint der Sitzung "x10" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden
  
  
  @test-audio4
  Scenario: 4er Lokalisation
    Given Bot 1 joint der Sitzung "x11" ohne Video
    Given Bot 2 joint der Sitzung "x11" ohne Video
    Given Bot 3 joint der Sitzung "x11" ohne Video
    Given Bot 4 joint der Sitzung "x11" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden


  @test-audio8
  Scenario: 8er Lokalisation
    Given Bot 1 joint der Sitzung "x5" ohne Video
    Given Bot 2 joint der Sitzung "x5" ohne Video
    Given Bot 3 joint der Sitzung "x5" ohne Video
    Given Bot 4 joint der Sitzung "x5" ohne Video
    Given Bot 5 joint der Sitzung "x5" ohne Video
    Given Bot 6 joint der Sitzung "x5" ohne Video
    Given Bot 7 joint der Sitzung "x5" ohne Video
    Given Bot 8 joint der Sitzung "x5" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 8 Taste M betätigt
    When Bot 8 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 7 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 6 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 5 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 4 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 3 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 2 Taste M betätigt
    When Bot 1 Taste M betätigt
    When Bot 1 Taste M betätigt
    When warte 10 Sekunden


  @test-cp-4
  Scenario: 4er Cocktailparty
    Given Bot 1 joint der Sitzung "debug11" ohne Video
    Given Bot 2 joint der Sitzung "debug11" ohne Video
    Given Bot 3 joint der Sitzung "debug11" ohne Video
    Given Bot 4 joint der Sitzung "debug11" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 3 Taste M betätigt
    When warte 20 Sekunden

  
  @test-cp-8
  Scenario: 8er Cocktailparty
    Given Bot 1 joint der Sitzung "debug12" ohne Video
    Given Bot 2 joint der Sitzung "debug12" ohne Video
    Given Bot 3 joint der Sitzung "debug12" ohne Video
    Given Bot 4 joint der Sitzung "debug12" ohne Video
    Given Bot 5 joint der Sitzung "debug12" ohne Video
    Given Bot 6 joint der Sitzung "debug12" ohne Video
    Given Bot 7 joint der Sitzung "debug12" ohne Video
    Given Bot 8 joint der Sitzung "debug12" ohne Video
    When Bot 1 Taste M betätigt
    When Bot 8 Taste M betätigt
    When warte 20 Sekunden





  @test-last-4
  Scenario: Lasttest 1 bis 4 Bots
    Given Bot 1 macht einen Quick Beitritt zur Sitzung "last4"
    When warte 60 Sekunden
    Given Bot 2 macht einen Quick Beitritt zur Sitzung "last4"
    When warte 60 Sekunden
    Given Bot 3 macht einen Quick Beitritt zur Sitzung "last4"
    When warte 60 Sekunden
    Given Bot 4 macht einen Quick Beitritt zur Sitzung "last4"
    When warte 60 Sekunden

  @test-last-8
  Scenario: Lasttest 5 bis 8 Bots
    Given Bot 1 macht einen Quick Beitritt zur Sitzung "last8"
    Given Bot 2 macht einen Quick Beitritt zur Sitzung "last8"
    Given Bot 3 macht einen Quick Beitritt zur Sitzung "last8"
    Given Bot 4 macht einen Quick Beitritt zur Sitzung "last8"
    Given Bot 5 macht einen Quick Beitritt zur Sitzung "last8"
    When warte 60 Sekunden
    Given Bot 6 macht einen Quick Beitritt zur Sitzung "last8"
    When warte 60 Sekunden
    Given Bot 7 macht einen Quick Beitritt zur Sitzung "last8"
    When warte 60 Sekunden
    Given Bot 8 macht einen Quick Beitritt zur Sitzung "last8"
    When warte 60 Sekunden

  @test-last-12
  Scenario: Lasttest 9 bis 12 Bots
    Given Bot 1 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 2 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 3 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 4 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 5 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 6 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 7 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 8 macht einen Quick Beitritt zur Sitzung "last12"
    Given Bot 9 macht einen Quick Beitritt zur Sitzung "last12"
    When warte 60 Sekunden
    Given Bot 10 macht einen Quick Beitritt zur Sitzung "last12"
    When warte 60 Sekunden
    Given Bot 11 macht einen Quick Beitritt zur Sitzung "last12"
    When warte 60 Sekunden
    Given Bot 12 macht einen Quick Beitritt zur Sitzung "last12"
    When warte 60 Sekunden

  @test-last-16
  Scenario: Lasttest 13 bis 16 Bots
    Given Bot 1 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 2 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 3 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 4 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 5 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 6 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 7 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 8 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 9 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 10 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 11 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 12 macht einen Quick Beitritt zur Sitzung "last16"
    Given Bot 13 macht einen Quick Beitritt zur Sitzung "last16"
    When warte 60 Sekunden
    Given Bot 14 macht einen Quick Beitritt zur Sitzung "last16"
    When warte 60 Sekunden
    Given Bot 15 macht einen Quick Beitritt zur Sitzung "last16"
    When warte 60 Sekunden
    Given Bot 16 macht einen Quick Beitritt zur Sitzung "last16"
    When warte 60 Sekunden

  @test-last-20
  Scenario: Lasttest 17 bis 20 Bots
    Given Bot 1 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 2 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 3 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 4 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 5 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 6 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 7 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 8 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 9 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 10 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 11 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 12 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 13 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 14 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 15 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 16 macht einen Quick Beitritt zur Sitzung "last20"
    Given Bot 17 macht einen Quick Beitritt zur Sitzung "last20"
    When warte 60 Sekunden
    Given Bot 18 macht einen Quick Beitritt zur Sitzung "last20"
    When warte 60 Sekunden
    Given Bot 19 macht einen Quick Beitritt zur Sitzung "last20"
    When warte 60 Sekunden
    Given Bot 20 macht einen Quick Beitritt zur Sitzung "last20"
    When warte 60 Sekunden


  @debugbutton2
  Scenario: Zwei Bots joint
    Given Bot 1 joint der Sitzung "test5"
    Given Bot 2 joint der Sitzung "test5"
    When warte 30 Sekunden

  @debugbutton4
  Scenario: Vier Bots joint
    Given Bot 1 joint der Sitzung "test7"
    Given Bot 2 joint der Sitzung "test7"
    Given Bot 3 joint der Sitzung "test7"
    Given Bot 4 joint der Sitzung "test7"
    When warte 30 Sekunden

  @debugbutton8
  Scenario: Acht Bots joint
    Given Bot 1 joint der Sitzung "test4"
    Given Bot 2 joint der Sitzung "test4"
    Given Bot 3 joint der Sitzung "test4"
    Given Bot 4 joint der Sitzung "test4"
    Given Bot 5 joint der Sitzung "test4"
    Given Bot 6 joint der Sitzung "test4"
    Given Bot 7 joint der Sitzung "test4"
    Given Bot 8 joint der Sitzung "test4"
    When warte 30 Sekunden


  @pannertest4
  Scenario: Vier Bots joint
    Given Bot 13 joint der Sitzung "mic1"
    When warte 3 Sekunden
    When Bot 13 Taste M betätigt
    Given Bot 14 joint der Sitzung "mic1"
    When warte 3 Sekunden
    When Bot 14 Taste M betätigt
    Given Bot 15 joint der Sitzung "mic1"
    When warte 3 Sekunden
    When Bot 15 Taste M betätigt
    Given Bot 16 joint der Sitzung "mic1"
    When warte 3 Sekunden
    When Bot 16 Taste M betätigt

    When warte 10 Sekunden
    Then ich den Text "Lasttest-4 START" mit Timestamp logge

    When Bot 13 Taste M betätigt
    When warte 5 Sekunden
    When Bot 13 Taste M betätigt

    When warte 5 Sekunden
    When Bot 13 Taste M betätigt
    When warte 5 Sekunden
    When Bot 13 Taste M betätigt

    When Bot 14 Taste M betätigt
    When warte 5 Sekunden
    When Bot 14 Taste M betätigt

    When Bot 15 Taste M betätigt
    When warte 5 Sekunden
    When Bot 15 Taste M betätigt

    When Bot 16 Taste M betätigt
    When warte 5 Sekunden
    When Bot 16 Taste M betätigt

    When warte 10 Sekunden


@pannertest8
  Scenario: Acht Bots joint
    Given Bot 13 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 13 Taste M betätigt

    Given Bot 14 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 14 Taste M betätigt

    Given Bot 15 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 15 Taste M betätigt

    Given Bot 16 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 16 Taste M betätigt

    Given Bot 17 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 17 Taste M betätigt

    Given Bot 18 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 18 Taste M betätigt

    Given Bot 19 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 19 Taste M betätigt

    Given Bot 20 joint der Sitzung "test23"
    When warte 4 Sekunden
    When Bot 20 Taste M betätigt

    When warte 5 Sekunden
    Then ich den Text "Lasttest-4 START" mit Timestamp logge

    When Bot 13 Taste M betätigt
    When warte 5 Sekunden
    When Bot 13 Taste M betätigt

    When Bot 17 Taste M betätigt
    When warte 5 Sekunden
    When Bot 17 Taste M betätigt

    When Bot 14 Taste M betätigt
    When warte 5 Sekunden
    When Bot 14 Taste M betätigt

    When Bot 18 Taste M betätigt
    When warte 5 Sekunden
    When Bot 18 Taste M betätigt

    When Bot 15 Taste M betätigt
    When warte 5 Sekunden
    When Bot 15 Taste M betätigt

    When Bot 19 Taste M betätigt
    When warte 5 Sekunden
    When Bot 19 Taste M betätigt

    When Bot 16 Taste M betätigt
    When warte 5 Sekunden
    When Bot 16 Taste M betätigt

    When Bot 20 Taste M betätigt
    When warte 5 Sekunden
    When Bot 20 Taste M betätigt

    When warte 5 Sekunden