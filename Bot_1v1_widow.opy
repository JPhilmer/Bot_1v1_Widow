settings {
    "main": {
        "description": "//[1vs1 TRAINING MOD WIDOW]\\\\                                                 /          NO HS ONLY) GL&HF         \\                                           .                .By Philmer (シ)                                         You cant hold ur RMB more than 2s                                                 Training smartbot widow ^^"
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "enableMatchVoiceChat": true,
        "ffaSlots": 2,
        "spectatorSlots": 12
    },
    "gamemodes": {
        "ffa": {
            "enabledMaps": [
                "castillo"
            ],
            "gameLengthInMn": 15,
            "scoreToWin": 50
        },
        "general": {
            "roleLimit": "2OfEachRolePerTeam",
            "spawnHealthPacks": "disabled"
        }
    },
    "heroes": {
        "allTeams": {
            "widowmaker": {
                "ability1Cooldown%": 55,
                "jumpVerticalSpeed%": 107,
                "movementSpeed%": 107,
                "projectileSpeed%": 107,
                "enableUlt": false,
                "enableAbility2": false
            },
            "enabledHeroes": [
                "ana",
                "ashe",
                "doomfist",
                "genji",
                "hanzo",
                "mccree",
                "pharah",
                "reaper",
                "soldier",
                "tracer",
                "widowmaker"
            ],
            "general": {
                "jumpVerticalSpeed%": 107,
                "movementSpeed%": 107,
                "projectileSpeed%": 107,
                "enableUlt": false
            }
        }
    }
}

#Global variables

globalvar grappin_pos1 26
globalvar grappin_pos2 27
globalvar bumper_white 28
globalvar bumper_red 29
globalvar bumper_blue 30


#Player variables

playervar tps_respawn_bot 26
playervar tps_txt_end 27


rule "TRAINING ROOM BY <PHILMER>":
    J = vect(-103.644, 37.181, 58.653)
    createInWorldText(getAllPlayers(), "AIM TRAINING ROOM 1vs1", J + vect(0, 35, 0), 2.2, Clip.SURFACES, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "By", J + vect(0, 33, 0), 2, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.LIME_GREEN, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "Philmer", J + vect(0, 31, 0), 1.8, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)
    createInWorldText(getAllPlayers(), "Bot training : Widow", J + vect(0, 29, 0), 1.8, Clip.SURFACES, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)


rule "<///===================Philmer mod 1vs1 Widow=====================///>   Var Global":
    grappin_pos1 = vect(-100.299, 39.058, 73.592)
    grappin_pos2 = vect(-106.271, 39.058, 43.087)
    bumper_white = vect(-129.412, 35.877, 63.636)
    bumper_blue = vect(-99.283, 34.066, 95.053)
    bumper_red = vect(-113.104, 34.749, 31.266)


rule "if kills an enemy, Says hello":
    @Event playerEarnedElimination
    @Hero all
    @Condition eventPlayer == eventPlayer.isAlive()
    @Condition eventPlayer.isDummy() == eventPlayer.isAlive()
    
    wait(0.25)
    eventPlayer.communicate(Comms.HELLO)


/*
rule "if scope (> 2 sec.) , gets stunned 1 sec":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() != true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    wait(2, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 1)
    smallMessage(eventPlayer, l"Stop")
*/

/*
rule "scope timer":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.T = 2
    chase(eventPlayer.T, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    hudHeader(eventPlayer, eventPlayer.T, HudPosition.TOP, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.F = getLastCreatedText()
    wait(0.557, Wait.ABORT_WHEN_FALSE)
    destroyHudText(eventPlayer.E)
*/

/*
rule "erase scope timer":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    destroyHudText(eventPlayer.F)
*/

rule "assemble time":
    @Condition isAssemblingHeroes() == true
    
    setMatchTime(0)
    disableGamemodeCompletion()


rule "match time":
    @Condition isAssemblingHeroes() == false
    
    setMatchTime(3600)


rule "kill > heal":
    @Event playerDealtFinalBlow
    @Hero all
    
    heal(eventPlayer, null, 999)
    eventPlayer.forceButtonPress(Button.RELOAD)


rule "respawn fast":
    @Event playerDied
    @Hero all
    @Condition eventPlayer.isDummy() == true
    
    wait(0.28)
    eventPlayer.respawn()


rule "Bumper pad":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.WHITE, vect(-129.412, 35.877, 63.636), 0.755, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "BUMPER", vect(-129.412, 32.877, 63.636), 1.557, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)


rule "Bumper pad jump":
    @Event eachPlayer
    @Hero all
    @Condition distance(eventPlayer, vect(-129.412, 34.877, 63.636)) <= abs(1.3)
    
    eventPlayer.applyImpulse(Vector.UP, 28, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.applyImpulse(directionTowards(vect(-129.412, 35.877, 63.636), vect(-89.396, 40.143, 55.93)), 55, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
    eventPlayer.setStatusEffect(null, Status.ROOTED, abs(0.5))


rule "TP zone pad A":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.BLUE, vect(-99.283, 34.066, 95.053), 0.755, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "TP", vect(-99.283, 32.066, 95.053), 1.557, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.BLUE, SpecVisibility.DEFAULT)


rule "TP pad A":
    @Event eachPlayer
    @Hero all
    @Condition distance(eventPlayer, vect(-99.283, 33.066, 95.053)) <= abs(1.3)
    
    eventPlayer.teleport(vect(-117.914, 42.772, 48.42))


rule "TP zone pad B":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.RED, vect(-113.104, 34.749, 31.266), 0.755, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    createInWorldText(getAllPlayers(), "TP", vect(-113.104, 32.749, 31.266), 1.557, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.RED, SpecVisibility.DEFAULT)


rule "TP pad B":
    @Event eachPlayer
    @Hero all
    @Condition distance(eventPlayer, vect(-113.16, 33.749, 30.76)) <= abs(1.3)
    
    eventPlayer.teleport(vect(-113.121, 42.772, 72.854))


rule "==== Bot widow for training ====":


rule "player enter in game":
    @Event playerJoined
    @Hero all
    
    L = len(getAllPlayers())
    G = 1 - L


rule "player left the game":
    @Event playerLeft
    @Hero all
    
    L = len(getAllPlayers())
    G = 1 - L


rule "bot initialisation":
    F = []
    F.append(Hero.WIDOWMAKER)


rule "bot widow add spawn with pos":
    @Condition G >= E
    
    wait(0.2)
    if not RULE_CONDITION:
        return
    createDummy(random.choice(F), Team.ALL, -1, vect(-89.988, 40.14, 55.838), random.choice(getAllPlayers()))
    if RULE_CONDITION:
        goto RULE_START


/*
rule "TESTING FOV SURFACE VIEW SHOT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 7) == true
    
    wait(0.005)
    if not RULE_CONDITION:
        return
    eventPlayer.startFacing(getPlayersOnHero(Hero.WIDOWMAKER, Team.ALL), 400, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    goto RULE_START
*/

/*
rule "TESTING FOV SURFACE VIEW SHOT":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition isInLoS(eventPlayer, getPlayersInRadius(getFarthestPlayer(eventPlayer, Team.ALL), 557, Team.ALL, LosCheck.SURFACES), BarrierLos.PASS_THROUGH_BARRIERS) == true
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 55) == true
    
    wait(0.005)
    if not RULE_CONDITION:
        return
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    if RULE_CONDITION:
        goto RULE_START
*/

rule "bot patern 1 deplacement":
    @Event playerTookDamage
    @Hero all
    @Condition eventPlayer.isDummy() == true
    
    eventPlayer.startForcingThrottle(0.7, 2, 0, 0, 0.5, 2)


rule "bot patern 2 view":
    @Event playerTookDamage
    @Hero all
    @Condition eventPlayer.isDummy() == true
    
    wait(0.287, Wait.ABORT_WHEN_FALSE)
    eventPlayer.A = attacker
    eventPlayer.startFacing(vectorTowards(eventPlayer.getEyePosition(), eventPlayer.A.getEyePosition() + worldVector(Vector.UP, eventPlayer.A, Transform.ROTATION) * 0.155 + worldVector(vect(eventPlayer.A.getSpeedInDirection(worldVector(Vector.LEFT, eventPlayer, Transform.ROTATION)) / abs(9999999) / 1, 0, 0), eventPlayer, Transform.ROTATION)), abs(9999999) + abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    if RULE_CONDITION:
        goto RULE_START


rule "bot patern 3":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition isInLoS(getPlayersInSlot(0, Team.ALL), eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS) == true
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 55) == true
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition distance(eventPlayer, eventPlayer.A) >= 7
    
    if not RULE_CONDITION:
        return
    wait(0.728)
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    if RULE_CONDITION:
        goto RULE_START


rule "bot patern 4":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition isInLoS(getPlayersInSlot(0, Team.ALL), eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS) == true
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 55) == true
    @Condition distance(eventPlayer, eventPlayer.A) <= 7
    
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    wait(2.25)
    eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)


rule "bot patern 5":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.isMoving() == true
    @Condition isInLoS(getPlayersInSlot(0, Team.ALL), eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS) == true
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 55) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) != true
    
    wait(1.007)
    if not RULE_CONDITION:
        return
    eventPlayer.forceButtonPress(Button.JUMP)
    eventPlayer.startForcingButton(Button.PRIMARY_FIRE)
    wait(0.45)
    if RULE_CONDITION:
        goto RULE_START


rule "bot patern 6":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isDummy() == true
    @Condition isInLoS(getPlayersInSlot(0, Team.ALL), eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS) == true
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 55) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(1.007)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    eventPlayer.startThrottleInDirection(random.choice(T), 1, Relativity.TO_PLAYER, Throttle.REPLACE_EXISTING, ThrottleReeval.NONE)
    wait(0.287)
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(0.728)
    eventPlayer.startForcingButton(Button.CROUCH)
    wait(1.007)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(0.728)
    eventPlayer.stopForcingButton(Button.CROUCH)
    eventPlayer.startThrottleInDirection(random.choice(T), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.NONE)
    wait(0.35)
    eventPlayer.forceButtonPress(Button.JUMP)
    wait(1.007)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "bot patern 7":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.isDummy() == true
    @Condition isInLoS(getPlayersInSlot(0, Team.ALL), eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS) == true
    @Condition eventPlayer.getPlayersInViewAngle(Team.ALL, 55) == true
    @Condition eventPlayer.isInAir() == true
    
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    wait(1)
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    wait(0.25)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
*/

rule "bot patern 8":
    @Event playerEarnedElimination
    @Hero widowmaker
    @Condition eventPlayer.isDummy() == true
    @Condition victim.isDummy() != true
    
    eventPlayer.A = getLivingPlayers(Team.ALL).exclude(eventPlayer)
    eventPlayer.startFacing(vectorTowards(eventPlayer.getEyePosition(), eventPlayer.A.getEyePosition() + worldVector(Vector.UP, eventPlayer.A, Transform.ROTATION) * 0.155 + worldVector(vect(eventPlayer.A.getSpeedInDirection(worldVector(Vector.LEFT, eventPlayer, Transform.ROTATION)) / abs(9999999) / 1, 0, 0), eventPlayer, Transform.ROTATION)), abs(9999999) + abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)


rule "bot patern punch":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.A.getHealth() <= 30
    @Condition distance(eventPlayer, getFarthestPlayer(eventPlayer, Team.ALL)) <= 3
    
    eventPlayer.forceButtonPress(Button.MELEE)


rule "bot patern grappin #1":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-99.835, 34.055, 76.217)) <= abs(10)
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), grappin_pos1), abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(0.287, Wait.ABORT_WHEN_FALSE)
    eventPlayer.stopFacing()
    wait(5.576)
    if RULE_CONDITION:
        goto RULE_START


rule "bot patern grappin #2":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-106.68, 34.055, 40.731)) <= abs(10)
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), grappin_pos2), abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(0.287, Wait.ABORT_WHEN_FALSE)
    eventPlayer.stopFacing()
    wait(5.576)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "zone effect grap #3":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.LIME_GREEN, vect(-73.993, 33.5, 52.648), 7.55, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

rule "bot patern grappin #3":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-73.993, 33.5, 52.648)) <= abs(7.55)
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), vect(-80.729, 39.358, 54.175)), abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(0.287, Wait.ABORT_WHEN_FALSE)
    eventPlayer.stopFacing()
    wait(5.576)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "zone effect grap #4":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.LIME_GREEN, vect(-82.265, 34.226, 37.771), 8.28, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

rule "bot patern grappin #4":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-82.265, 33.226, 37.771)) <= abs(8.28)
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), vect(-85.316, 40.075, 44.841)), abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(0.287, Wait.ABORT_WHEN_FALSE)
    eventPlayer.stopFacing()
    wait(5.576)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "zone effect grap #5":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.LIME_GREEN, vect(-76.093, 34.3, 69.966), 8.28, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

rule "bot patern grappin #5":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-76.093, 33.3, 69.966)) <= abs(8.28)
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), vect(-81.516, 40.078, 64.396)), abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(0.287, Wait.ABORT_WHEN_FALSE)
    eventPlayer.stopFacing()
    wait(5.576)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "zone effect grap statue":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIME_GREEN, vect(-101.731, 36.564, 58.297), 14.55, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

rule "bot patern grappin #6":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-101.731, 36, 58.297)) <= abs(14.55)
    
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), vect(-101.731, 36, 58.297)), abs(9999999), Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait(0.287, Wait.ABORT_WHEN_FALSE)
    eventPlayer.stopFacing()
    wait(5.576)
    if RULE_CONDITION:
        goto RULE_START


/*
rule "Zone effect tp bumper white mid":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.ORANGE, vect(-125.282, 35.878, 63.01), 7.55, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

/*
rule "bot patern bis grappin disable":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() != true
    @Condition eventPlayer.isUsingAbility1() == true
    
    if eventPlayer.isUsingAbility1():
        eventPlayer.disallowButton(Button.ABILITY_1)
        wait(5.55)
    eventPlayer.allowButton(Button.ABILITY_1)
*/

rule "Zone action tp bumper white mid":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-125.282, 35.878, 63.01)) <= abs(7.55)
    
    eventPlayer.teleport(bumper_white)


/*
rule "Zone effect tp bumper red house2 sombra":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.RED, vect(-112.839, 34.066, 26.958), 8.28, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

rule "Zone action tp bumper red house2 sombra":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-112.839, 34.066, 26.958)) <= abs(8.28)
    
    eventPlayer.teleport(bumper_red)


/*
rule "Zone effect tp bumper blue house1 pub":
    @Event eachPlayer
    @Hero all
    
    createEffect(getAllPlayers(), Effect.RING, Color.BLUE, vect(-100.269, 34.068, 91.017), 8.28, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

rule "Zone action tp bumper blue house1 pub":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-100.269, 34.068, 91.017)) <= abs(8.28)
    
    eventPlayer.teleport(bumper_blue)


rule "unblockZone_Debug 1":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-110.018, 35.014, 72.055)) <= abs(3.28)
    
    eventPlayer.teleport(vect(-113.112, 35.053, 80.871))


rule "unblockZone_Debug 2":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-117.22, 35.407, 55.701)) <= abs(2.28)
    
    eventPlayer.teleport(vect(-113.887, 35.054, 53.326))


rule "unblockZone_Debug 3":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-124.634, 33.996, 43.743)) <= abs(1.55)
    
    eventPlayer.teleport(vect(-121.382, 36.069, 45.948))


rule "unblockZone_Debug 4":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-121.951, 39.055, 74.726)) <= abs(1.28)
    
    eventPlayer.teleport(vect(-120.405, 40.058, 72.385))


rule "unblockZone_Debug 5":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-87.986, 39.14, 58.413)) <= abs(1.28)
    
    eventPlayer.teleport(vect(-84.872, 40.139, 59.446))


rule "unblockZone_Debug 6 action_tp":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition eventPlayer.A.getScore() >= 1
    @Condition getNumberOfLivingPlayers(Team.ALL) == 2
    
    wait(30, Wait.ABORT_WHEN_FALSE)
    eventPlayer.teleport(bumper_white)
    if RULE_CONDITION:
        goto RULE_START


rule "unblockZone_Debug 6 timer":
    @Event eachPlayer
    @Hero all
    @Condition getNumberOfLivingPlayers(Team.ALL) == 2
    
    eventPlayer.tps_respawn_bot = 30
    chase(eventPlayer.tps_respawn_bot, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    hudText(eventPlayer, null, "TP Bot in : ", eventPlayer.tps_respawn_bot, HudPosition.LEFT, 1, Color.YELLOW, Color.WHITE, Color.GREEN, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.tps_txt_end = getLastCreatedText()
    wait(30, Wait.ABORT_WHEN_FALSE)
    destroyHudText(eventPlayer.tps_txt_end)
    if RULE_CONDITION:
        goto RULE_START


rule "unblockZone_Debug 6 erase timer":
    @Event eachPlayer
    @Hero all
    @Condition getNumberOfLivingPlayers(Team.ALL) != 2
    
    destroyHudText(eventPlayer.tps_txt_end)


rule "unblockZone_Debug 7":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer.isDummy() == true
    @Condition distance(eventPlayer, vect(-123.959, 35.303, 54.211)) <= abs(2.28)
    
    eventPlayer.teleport(vect(-121.713, 36.037, 58.887))


/*
rule "effet sphere1 test grap1":
    createEffect(getAllPlayers(), Effect.SPHERE, Color.AQUA, vect(-99.835, 34.055, 76.217), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

/*
rule "effet sphere2 test grap1":
    createEffect(getAllPlayers(), Effect.SPHERE, Color.BLUE, vect(-99.835, 34.055, 76.217), 9.557, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

/*
rule "effet sphere1 test grap2":
    createEffect(getAllPlayers(), Effect.SPHERE, Color.AQUA, vect(-106.68, 34.054, 40.731), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
*/

rule "Bot_hello_asw":
    @Event eachPlayer
    @Hero all
    @Condition eventPlayer == eventPlayer.isAlive()
    @Condition eventPlayer.isCommunicating(Comms.HELLO) == true
    
    wait(1.287)
    getClosestPlayer(eventPlayer, Team.ALL).communicate(Comms.HELLO)


