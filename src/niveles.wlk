import wollok.game.*
import enemigos.*
import personaje.*

object tutorial {
	method iniciar(){
		game.addVisual(escorpion)
		game.addVisualCharacter(personaje)
	}
	
}

object config{
	method configurarTeclas(){
		keyboard.left().onPressDo( { personaje.irA(personaje.position().left(1))})
		keyboard.right().onPressDo({ personaje.irA(personaje.position().right(1))})
		keyboard.up().onPressDo(   { personaje.irA(personaje.position().up(1))})
		keyboard.down().onPressDo( { personaje.irA(personaje.position().down(1))})
	}
}