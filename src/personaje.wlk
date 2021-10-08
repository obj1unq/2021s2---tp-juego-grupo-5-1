import wollok.game.*
import direcciones.*

object personaje {

	var property position = game.origin()
	var dir = derecha

	method image() = "pj-demo-"+ self.sufijo() +".png"
	
	method mover(direccion){
		dir = direccion
		self.irA(direccion.siguiente(self.position()))
	}
	
	method irA(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method sufijo(){
		return dir.sufijo()
	}

}