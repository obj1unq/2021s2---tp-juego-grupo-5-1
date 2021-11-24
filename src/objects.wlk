import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*
import hechizos.*
import niveles.*

class Visual{
	var property image
	var property position
}

const fondo = new Visual(image = "bg.png",position = game.origin())
const columna = new Visual(image = "columnas.png", position = game.at(0,20))
//const columna = new Visual(image = "", position = "")
//const columna = new Visual(image = "", position = "")
//const columna = new Visual(image = "", position = "")
//const columna = new Visual(image = "", position = "")


class Nivel{
	const property position = game.at(0,0)
	
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
		game.addVisual(pepita)
		keyboard.enter().onPressDo({
			nivel1.show()
		})
		
	}
}

object nivel1 inherits Nivel{
	const property image = "Battleground1.png"
	
	override method show(){
	super()
	personaje.position(game.at(0,1))
	
	tutorial.iniciar()
	//.configurarTeclas()
	//keyboard.enter().onPressDo({nivel2.show()})	
	}
	
}

object nivel2 inherits Nivel{
	const property image = "Battleground2.png"
	override method show(){
	super()
	keyboard.enter().onPressDo({game.stop()})
		
	}
}

object pepita {
	
	method position() = game.center()
	
	method text() = "¡Para comenzar el juego presione ENTER!"
}
