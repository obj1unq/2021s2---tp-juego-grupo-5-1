import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*
import hechizos.*
import visuales.*
import hud.*
import config.*

class Tutorial {
	method iniciar(){
		visual.pj()
		config.sonido()
		config.configurarTeclas()
        config.configurarSpawnEnemigos()
		game.addVisual(mostrarOro)
		game.addVisual(temploDeMana)
		//game.addVisual(temploDeExperiencia)
	}
	
}
object tutorial inherits Tutorial{}

object tutorial2 inherits Tutorial {
	override method iniciar(){
		visual.pj()
		config.configurarTeclas()
        config.configurarSpawnEnemigosDos()
		game.addVisual(mostrarOro)
		game.addVisual(temploDeMana)
		//game.addVisual(temploDeExperiencia)

	}
	
}
object tutorialBonus inherits Tutorial {
	override method iniciar(){
//		config.sonidoBonus()
		visual.pj()
		personaje.position(game.at(0,3))
		game.addVisual(mostrarOro)
		keyboard.left().onPressDo( { personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		fabricaDiamantes.iniciar()
	}
	
}





class Nivel{
	var property position = game.at(0,2)
	
	
	const property escenario = []
	
	method show(){
		game.clear()
		game.addVisual(self)
		
	}
}

object inicio inherits Nivel(position = game.at(0,0)){
	const property image = "portada.png"
	
	override method show(){
		super()
		keyboard.enter().onPressDo({
			game.clear()
			tutorialDeJuego1.show()
		})
	}
}

object tutorialDeJuego1 inherits Nivel(position = game.at(0,0)){
	const property image = "tuto1.png"
	
	override method show(){
		super()
		keyboard.enter().onPressDo({
			game.clear()
			nivel1.show()
		})
		
		keyboard.right().onPressDo({
			game.clear()
			tutorialDeJuego2.show()
		})
	}
}

object tutorialDeJuego2 inherits Nivel(position = game.at(0,0)){
	const property image = "tuto2.png"
	
	override method show(){
		super()
		
		keyboard.enter().onPressDo({
			game.clear()
			nivel1.show()
		})
		
		keyboard.left().onPressDo({
			game.clear()
			tutorialDeJuego1.show()
		})
	}
}


object nivel1 inherits Nivel{
	const property image = "Battleground1.png"
	
	override method show(){
	hud.visualizar()
	game.addVisual(self)
	tutorial.iniciar()
	}
	
}

object nivel2 inherits Nivel{
	const property image = "Battleground2.png"
	override method show(){
	super()
	config.sonido2()
	hud.visualizar()
	hud.reiniciarPoderes()
	temploDeMana.reiniciar()
	tutorial2.iniciar()
	}
}

object bonus inherits Nivel{
	const property image = "bonus.png"
	override method show(){
	super()
	hud.visualizar()
	hud.soloFlechasX()
	tutorialBonus.iniciar()
	}
}
