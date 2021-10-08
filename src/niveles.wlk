import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*

object tutorial {
	method iniciar(){
		game.addVisual(escorpion)
		game.addVisual(personaje)
		config.configurarTeclas()
	}
	
}

object config{
	method configurarTeclas(){
		keyboard.left().onPressDo( { personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.up().onPressDo(   { personaje.mover(arriba)})
		keyboard.down().onPressDo( { personaje.mover(abajo)})
		keyboard.a().onPressDo({personaje.atacar()})
	}
	
	
	method configurarStamina(){
	   game.onTick(800, "Stamina", { personaje.recuperarStamina(1)})
    }
	
}