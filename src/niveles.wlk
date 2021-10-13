import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*

object tutorial {
	method iniciar(){
		game.addVisual(escorpion)
		game.addVisual(personaje)
		game.addVisual(hiena)
		game.addVisual(espada)
		game.addVisual(curacion)
		game.addVisual(brujo)
		game.addVisual(texto)
		
		
		game.showAttributes(escorpion)
		game.showAttributes(hiena)
		game.showAttributes(espada)
		game.showAttributes(curacion)
		game.showAttributes(brujo)
		game.showAttributes(personaje)
		config.configurarTeclas()
		config.configurarStamina()
	}
	
}

object config{
	method configurarTeclas(){
		keyboard.left().onPressDo( { personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.up().onPressDo(   { personaje.mover(arriba)})
		keyboard.down().onPressDo( { personaje.mover(abajo)})
		keyboard.a().onPressDo({personaje.atacarEnemigoAdelante()})
		//AÑADIDOS================
		keyboard.s().onPressDo({personaje.guardar()})
		keyboard.b().onPressDo({personaje.armarse()})
		keyboard.d().onPressDo({personaje.curarse()})
	}
	
	
	method configurarStamina(){
	   game.onTick(900, "STAMINA", { personaje.recuperarStamina(1)})
    }
	
}

