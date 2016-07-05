// ---------------------------------------
// Sprite definitions for 'SpaceRunnerSprites'
// Generated with TexturePacker 4.2.2
//
// http://www.codeandweb.com/texturepacker
// ---------------------------------------

import SpriteKit


class SpaceRunnerSprites {

    // sprite names
    let FIREBUTTONLIGHT   = "FireButtonLight"
    let POWERUPHEALTH     = "PowerUpHealth"
    let SETTINGS          = "Settings"
    let ENEMYBLACK1       = "enemyBlack1"
    let ENEMYBLACK2       = "enemyBlack2"
    let ENEMYBLACK3       = "enemyBlack3"
    let ENEMYBLACK4       = "enemyBlack4"
    let ENEMYBLACK5       = "enemyBlack5"
    let ENEMYBLUE1        = "enemyBlue1"
    let ENEMYBLUE2        = "enemyBlue2"
    let ENEMYBLUE3        = "enemyBlue3"
    let ENEMYBLUE4        = "enemyBlue4"
    let ENEMYBLUE5        = "enemyBlue5"
    let ENEMYEXPLODE1     = "enemyExplode1"
    let ENEMYEXPLODE2     = "enemyExplode2"
    let ENEMYEXPLODE3     = "enemyExplode3"
    let GREYMETEOR1       = "greyMeteor1"
    let LASERBLUE         = "laserBlue"
    let LASERRED          = "laserRed"
    let METEOR1           = "meteor1"
    let METEOR2           = "meteor2"
    let METEOR3           = "meteor3"
    let METEOR4           = "meteor4"
    let METEOR5           = "meteor5"
    let METEOR6           = "meteor6"
    let METEOR7           = "meteor7"
    let METEOR8           = "meteor8"
    let PAUSEBUTTON       = "pauseButton"
    let PLAYEREXPLODE1    = "playerExplode1"
    let PLAYEREXPLODE2    = "playerExplode2"
    let PLAYEREXPLODE3    = "playerExplode3"
    let PLAYEREXPLODE4    = "playerExplode4"
    let PLAYERSHIPBLUE    = "playerShipBlue"
    let PLAYERSHIPDAMAGE1 = "playerShipDamage1"
    let PLAYERSHIPDAMAGE2 = "playerShipDamage2"
    let PLAYERSHIPDAMAGE3 = "playerShipDamage3"
    let PLAYERSHIPGREEN   = "playerShipGreen"
    let PLAYERSHIPORANGE  = "playerShipOrange"
    let PLAYERSHIPRED     = "playerShipRed"


    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "SpaceRunnerSprites")


    // individual texture objects
    func FireButtonLight() -> SKTexture   { return textureAtlas.textureNamed(FIREBUTTONLIGHT) }
    func PowerUpHealth() -> SKTexture     { return textureAtlas.textureNamed(POWERUPHEALTH) }
    func Settings() -> SKTexture          { return textureAtlas.textureNamed(SETTINGS) }
    func enemyBlack1() -> SKTexture       { return textureAtlas.textureNamed(ENEMYBLACK1) }
    func enemyBlack2() -> SKTexture       { return textureAtlas.textureNamed(ENEMYBLACK2) }
    func enemyBlack3() -> SKTexture       { return textureAtlas.textureNamed(ENEMYBLACK3) }
    func enemyBlack4() -> SKTexture       { return textureAtlas.textureNamed(ENEMYBLACK4) }
    func enemyBlack5() -> SKTexture       { return textureAtlas.textureNamed(ENEMYBLACK5) }
    func enemyBlue1() -> SKTexture        { return textureAtlas.textureNamed(ENEMYBLUE1) }
    func enemyBlue2() -> SKTexture        { return textureAtlas.textureNamed(ENEMYBLUE2) }
    func enemyBlue3() -> SKTexture        { return textureAtlas.textureNamed(ENEMYBLUE3) }
    func enemyBlue4() -> SKTexture        { return textureAtlas.textureNamed(ENEMYBLUE4) }
    func enemyBlue5() -> SKTexture        { return textureAtlas.textureNamed(ENEMYBLUE5) }
    func enemyExplode1() -> SKTexture     { return textureAtlas.textureNamed(ENEMYEXPLODE1) }
    func enemyExplode2() -> SKTexture     { return textureAtlas.textureNamed(ENEMYEXPLODE2) }
    func enemyExplode3() -> SKTexture     { return textureAtlas.textureNamed(ENEMYEXPLODE3) }
    func greyMeteor1() -> SKTexture       { return textureAtlas.textureNamed(GREYMETEOR1) }
    func laserBlue() -> SKTexture         { return textureAtlas.textureNamed(LASERBLUE) }
    func laserRed() -> SKTexture          { return textureAtlas.textureNamed(LASERRED) }
    func meteor1() -> SKTexture           { return textureAtlas.textureNamed(METEOR1) }
    func meteor2() -> SKTexture           { return textureAtlas.textureNamed(METEOR2) }
    func meteor3() -> SKTexture           { return textureAtlas.textureNamed(METEOR3) }
    func meteor4() -> SKTexture           { return textureAtlas.textureNamed(METEOR4) }
    func meteor5() -> SKTexture           { return textureAtlas.textureNamed(METEOR5) }
    func meteor6() -> SKTexture           { return textureAtlas.textureNamed(METEOR6) }
    func meteor7() -> SKTexture           { return textureAtlas.textureNamed(METEOR7) }
    func meteor8() -> SKTexture           { return textureAtlas.textureNamed(METEOR8) }
    func pauseButton() -> SKTexture       { return textureAtlas.textureNamed(PAUSEBUTTON) }
    func playerExplode1() -> SKTexture    { return textureAtlas.textureNamed(PLAYEREXPLODE1) }
    func playerExplode2() -> SKTexture    { return textureAtlas.textureNamed(PLAYEREXPLODE2) }
    func playerExplode3() -> SKTexture    { return textureAtlas.textureNamed(PLAYEREXPLODE3) }
    func playerExplode4() -> SKTexture    { return textureAtlas.textureNamed(PLAYEREXPLODE4) }
    func playerShipBlue() -> SKTexture    { return textureAtlas.textureNamed(PLAYERSHIPBLUE) }
    func playerShipDamage1() -> SKTexture { return textureAtlas.textureNamed(PLAYERSHIPDAMAGE1) }
    func playerShipDamage2() -> SKTexture { return textureAtlas.textureNamed(PLAYERSHIPDAMAGE2) }
    func playerShipDamage3() -> SKTexture { return textureAtlas.textureNamed(PLAYERSHIPDAMAGE3) }
    func playerShipGreen() -> SKTexture   { return textureAtlas.textureNamed(PLAYERSHIPGREEN) }
    func playerShipOrange() -> SKTexture  { return textureAtlas.textureNamed(PLAYERSHIPORANGE) }
    func playerShipRed() -> SKTexture     { return textureAtlas.textureNamed(PLAYERSHIPRED) }


    // texture arrays for animations
    func enemyBlack() -> [SKTexture] {
        return [
            enemyBlack1(),
            enemyBlack2(),
            enemyBlack3(),
            enemyBlack4(),
            enemyBlack5()
        ]
    }

    func enemyBlue() -> [SKTexture] {
        return [
            enemyBlue1(),
            enemyBlue2(),
            enemyBlue3(),
            enemyBlue4(),
            enemyBlue5()
        ]
    }

    func enemyExplode() -> [SKTexture] {
        return [
            enemyExplode1(),
            enemyExplode2(),
            enemyExplode3()
        ]
    }

    func meteor() -> [SKTexture] {
        return [
            meteor1(),
            meteor2(),
            meteor3(),
            meteor4(),
            meteor5(),
            meteor6(),
            meteor7(),
            meteor8()
        ]
    }

    func playerExplode() -> [SKTexture] {
        return [
            playerExplode1(),
            playerExplode2(),
            playerExplode3(),
            playerExplode4()
        ]
    }

    func playerShipDamage() -> [SKTexture] {
        return [
            playerShipDamage1(),
            playerShipDamage2(),
            playerShipDamage3()
        ]
    }


}
