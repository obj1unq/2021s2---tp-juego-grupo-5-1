import wollok.game.*
import personaje.*

object espada {
	var property position = game.at(5,2)
	const property poder = 5

	method image() = "espada.png"
	
	method usar(_personaje){
			_personaje.arma(self)
			_personaje.poder(self.poder())
	}
}	
	


object curacion {
	var property position = game.at(7,4)
	const property poder = 10

	method image() = "vida.png"
	
	method usar(_personaje){
			_personaje.sumarVida(poder)
	}
}

object texto{
	method position() = game.at(2,2)
	method text() = personaje.vida().toString() + " "+ personaje.poder() + " " + personaje.nivel()
}

object inventario{
	method position() = game.at(5,4)
	method image() = "inv-demo.png"
	method text() = personaje.mochila().toString()
}



