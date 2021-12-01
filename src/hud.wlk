import visuales.*
import direcciones.*
import wollok.game.*
import personaje.*
import enemigos.*
import niveles.*

//Articulos del HUD
const perfil = new Visual(position= game.at(0,0),image = "hud/cuadrado.png")
const flechaIzq = new Visual(position= game.at(17,0),image = "hud/izquierda.png")
const flechaDer = new Visual(position= game.at(19,0),image = "hud/derecha.png")
const flechaAba= new Visual(position= game.at(18,0),image = "hud/abajo.png")
const flechaArr= new Visual(position= game.at(18,1),image = "hud/arriba.png")
const cuadro= new Visual(position= game.at(13,0),image = "hud/cuadro.png")






object hud {
    
    var property mana = [new OrbeMana(position = game.at(4,0),image = "mp-"+personaje.mana() / 10+ ".png")]
    var property vida = [new OrbeVida(position = game.at(4,0),image = "hp-"+personaje.vida()+ ".png")]
    var property listaAtaquesBonus = [fuegoLogo, hieloLogo, rayoLogo]
    var property listaAtaquesBonusAprendido = []
    
    method actualizarVida(){
        if(game.hasVisual(vida.first())){
            game.removeVisual(vida.first())
            vida.remove(vida.first())
        }
        const nuevo = new OrbeVida(position = game.at(4,0),image = "hp-"+personaje.vida()+ ".png")
        vida.add(nuevo)
        game.addVisual(nuevo)

    }
    
    method actualizarMana(){
        if(game.hasVisual(mana.first())){
            game.removeVisual(mana.first())
        mana.remove(mana.first())
        }
        const nuevo = new OrbeMana(position = game.at(4,0),image = "mp-"+personaje.mana() / 10+ ".png")
        mana.add(nuevo)
        game.addVisual(nuevo)
    }
    
    method activarHechizo(){
        const aprendido = listaAtaquesBonus.first()
        game.addVisual(aprendido)
        listaAtaquesBonus.remove(aprendido)
        listaAtaquesBonusAprendido.add(aprendido)
    }
    
    method visualizar(){
        game.addVisual(perfil)
        game.addVisual(flechaIzq)
        game.addVisual(flechaDer)
        game.addVisual(flechaAba)
        game.addVisual(flechaArr)
        game.addVisual(cuadro)
        game.addVisual(hudMedio)
//        game.addVisual(hieloLogo)
//        game.addVisual(fuegoLogo)
//        game.addVisual(rayoLogo)
//        game.addVisual(hporb)
//        game.addVisual(manaorb)
        game.addVisual(vida.first())
        game.addVisual(mana.first())
        
    }
    method soloFlechasX(){
        game.removeVisual(flechaAba)
        game.removeVisual(flechaArr)
    }
    
    method reiniciarPoderes(){
        listaAtaquesBonusAprendido.forEach({x => game.addVisual(x)})
    }
    
}


class Orbe {
    var property position
    var property image 
    method agregar(){
        game.addVisual(self)
    }
    method remover(){
        game.removeVisual(self)
    }
    
}


class OrbeVida inherits Orbe(position = game.at(4,0),image = "hp-"+personaje.vida()+ ".png"){
    
    
}

class OrbeMana inherits Orbe(position = game.at(4,0),image ="hp-"+personaje.mana() / 10+ ".png"){
}


//--



object hudMedio{
	var property position = game.at(4,0)
	method image() = "hudmedio.png"
}

object hieloLogo{
	var property position = game.at(4,0)
	method image() = "hieloLogo.png"
}

object fuegoLogo{
	var property position = game.at(4,0)
	method image() = "fuegoLogo.png"
}

object rayoLogo{
	var property position = game.at(4,0)
	method image() = "rayoLogo.png"
}


object manaorb{
	var property position = game.at(4,0)
	method image() = "mp-10.png"
}

object hporb{
	var property position = game.at(4,0)
	method image() = "hp-10.png"
}


