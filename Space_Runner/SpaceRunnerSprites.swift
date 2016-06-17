// ---------------------------------------
// Sprite definitions for 'SpaceRunnerSprites'
// Generated with TexturePacker 4.2.2
//
// http://www.codeandweb.com/texturepacker
// ---------------------------------------

import SpriteKit


class SpaceRunnerSprites {

    // sprite names
    let POWERUPHEALTH     = "PowerUpHealth"
    let ENEMYEXPLODE_01   = "enemyExplode/01"
    let ENEMYEXPLODE_02   = "enemyExplode/02"
    let ENEMYEXPLODE_03   = "enemyExplode/03"
    let ENEMYSHIP1        = "enemyShip1"
    let ENEMYSHIP2        = "enemyShip2"
    let ENEMYSHIP3        = "enemyShip3"
    let LASERBLUE         = "laserBlue"
    let LASERRED          = "laserRed"
    let METEOR1           = "meteor1"
    let METEOR2           = "meteor2"
    let METEOR3           = "meteor3"
    let METEOR4           = "meteor4"
    let METEOR5           = "meteor5"
    let PAUSEBUTTON       = "pauseButton"
    let PLAYEREXPLODE_01  = "playerExplode/01"
    let PLAYEREXPLODE_02  = "playerExplode/02"
    let PLAYEREXPLODE_03  = "playerExplode/03"
    let PLAYEREXPLODE_04  = "playerExplode/04"
    let PLAYERSHIP        = "playerShip"
    let PLAYERSHIPDAMAGE1 = "playerShipDamage1"
    let PLAYERSHIPDAMAGE2 = "playerShipDamage2"
    let PLAYERSHIPDAMAGE3 = "playerShipDamage3"


    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "SpaceRunnerSprites")


    // individual texture objects
    func PowerUpHealth() -> SKTexture     { return textureAtlas.textureNamed(POWERUPHEALTH) }
    func enemyExplode_01() -> SKTexture   { return textureAtlas.textureNamed(ENEMYEXPLODE_01) }
    func enemyExplode_02() -> SKTexture   { return textureAtlas.textureNamed(ENEMYEXPLODE_02) }
    func enemyExplode_03() -> SKTexture   { return textureAtlas.textureNamed(ENEMYEXPLODE_03) }
    func enemyShip1() -> SKTexture        { return textureAtlas.textureNamed(ENEMYSHIP1) }
    func enemyShip2() -> SKTexture        { return textureAtlas.textureNamed(ENEMYSHIP2) }
    func enemyShip3() -> SKTexture        { return textureAtlas.textureNamed(ENEMYSHIP3) }
    func laserBlue() -> SKTexture         { return textureAtlas.textureNamed(LASERBLUE) }
    func laserRed() -> SKTexture          { return textureAtlas.textureNamed(LASERRED) }
    func meteor1() -> SKTexture           { return textureAtlas.textureNamed(METEOR1) }
    func meteor2() -> SKTexture           { return textureAtlas.textureNamed(METEOR2) }
    func meteor3() -> SKTexture           { return textureAtlas.textureNamed(METEOR3) }
    func meteor4() -> SKTexture           { return textureAtlas.textureNamed(METEOR4) }
    func meteor5() -> SKTexture           { return textureAtlas.textureNamed(METEOR5) }
    func pauseButton() -> SKTexture       { return textureAtlas.textureNamed(PAUSEBUTTON) }
    func playerExplode_01() -> SKTexture  { return textureAtlas.textureNamed(PLAYEREXPLODE_01) }
    func playerExplode_02() -> SKTexture  { return textureAtlas.textureNamed(PLAYEREXPLODE_02) }
    func playerExplode_03() -> SKTexture  { return textureAtlas.textureNamed(PLAYEREXPLODE_03) }
    func playerExplode_04() -> SKTexture  { return textureAtlas.textureNamed(PLAYEREXPLODE_04) }
    func playerShip() -> SKTexture        { return textureAtlas.textureNamed(PLAYERSHIP) }
    func playerShipDamage1() -> SKTexture { return textureAtlas.textureNamed(PLAYERSHIPDAMAGE1) }
    func playerShipDamage2() -> SKTexture { return textureAtlas.textureNamed(PLAYERSHIPDAMAGE2) }
    func playerShipDamage3() -> SKTexture { return textureAtlas.textureNamed(PLAYERSHIPDAMAGE3) }


    // texture arrays for animations
    func enemyExplode() -> [SKTexture] {
        return [
            enemyExplode_01(),
            enemyExplode_02(),
            enemyExplode_03()
        ]
    }

    func enemyShip() -> [SKTexture] {
        return [
            enemyShip1(),
            enemyShip2(),
            enemyShip3()
        ]
    }

    func meteor() -> [SKTexture] {
        return [
            meteor1(),
            meteor2(),
            meteor3(),
            meteor4(),
            meteor5()
        ]
    }

    func playerExplode() -> [SKTexture] {
        return [
            playerExplode_01(),
            playerExplode_02(),
            playerExplode_03(),
            playerExplode_04()
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
