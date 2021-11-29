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
		//config.sonido()
		config.configurarTeclas()
        config.configurarSpawnEnemigos()
		game.addVisual(mostrarOro)
		game.addVisual(temploDeMana)
		game.addVisual(temploDeExperiencia)
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
		game.addVisual(temploDeExperiencia)

	}
	
}
object tutorialBonus inherits Tutorial {
	override method iniciar(){
		visual.pj()
		personaje.position(game.at(0,3))
		game.addVisual(mostrarOro)
		keyboard.left().onPressDo( { personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		fabricaDiamantes.iniciar()
	}
	
}


class Nivel{
	const property position = game.at(0,2)
	
	const property escenario = []
	
	method show(){
		game.clear()
		game.addVisual(self)
		
	}
}

object inicio inherits Nivel{
	const property image = "bg.png"
	
	override method show(){
		super()
		keyboard.enter().onPressDo({
			nivel1.show()
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
	hud.visualizar()
	hud.reiniciar()
	tutorial2.iniciar()
	}
}

object bonus inherits Nivel{
	const property image = "bonus.png"
	override method show(){
	super()
	hud.visualizar()
	hud.reiniciar()
	hud.soloFlechasX()
	tutorialBonus.iniciar()
	}
}




