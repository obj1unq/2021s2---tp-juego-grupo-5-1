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
	
	
    method actualizarVida(vida){
    	orbeVida.actualizar(vida)
    }
    
    method actualizarMana(mana){
    	orbeMana.actualizar(mana)
    }
    
	method visualizar(){
		game.addVisual(perfil)
		game.addVisual(flechaIzq)
		game.addVisual(flechaDer)
		game.addVisual(flechaAba)
		game.addVisual(flechaArr)
		game.addVisual(cuadro)
		game.addVisual(hudMedio)
		game.addVisual(hieloLogo)
		game.addVisual(fuegoLogo)
		game.addVisual(rayoLogo)
		game.addVisual(hporb)
		game.addVisual(manaorb)
		//game.addVisual(orbeVida)
		//game.addVisual(orbeMana)
	}
	method soloFlechasX(){
		game.removeVisual(flechaAba)
		game.removeVisual(flechaArr)
	}
	
}


class Orbe {
	var property position
	var property image
	
	method actualizar(numero)
}


object orbeVida inherits Orbe(position = game.at(5,0), image = "hp-10.png" ){
	
	override method actualizar(_numero){
	 	self.image(_numero)
	}
	
	method image(numero) = "hp-"+ numero +".png"
}

object orbeMana inherits Orbe(position = game.at(7,0), image ="mp-10.png" ){
	
	override method actualizar(_numero){
	 	self.image(_numero)
	}
	
	method image(numero) = "mp-"+ numero +".png"
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


