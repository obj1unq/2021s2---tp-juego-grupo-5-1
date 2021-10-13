import wollok.game.*
import personaje.*

object espada {
	var property position = game.at(5,2)
	const property poder = 5
	method arma(){return true}
	method curacion(){return false}
	method image() = "espada.png"
	
	method usar(_personaje){
		if(_personaje.mochila().contains(self)){
			_personaje.arma(self)
			_personaje.poder(self.poder())
			_personaje.mochila().remove(self)
		}else{
			self.error("no hay espada en el inventario")
	}}
}

object curacion {
	var property position = game.at(7,4)
	const property poder = 10
	method arma(){return false}
	method curacion(){return true}
	method image() = "vida.png"
	
	method usar(_personaje){
		if(_personaje.mochila().contains(self)){
			_personaje.sumarVida(poder)
			_personaje.mochila().remove(self)
		}else{
			self.error("no hay curas en el inventario")
		}
	}
}

object texto{
	method position() = game.at(2,2)
	method text() = personaje.vida().toString() + " "+ personaje.poder() + " " + personaje.nivel()
}
