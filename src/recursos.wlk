import wollok.game.*
import personaje.*

class Arma {
	var property position
	var property poder
	var property image
	
	method usar(_personaje){
		_personaje.arma(self)
		_personaje.poder(self.poder())
	}
	
	method neutral(){
		return true
	}
	method validarGuardado(){}
}

object espada inherits Arma(position=game.at(2,2),image="items/espada.png",poder=4){}
object hacha  inherits Arma(position=game.at(4,2),image="items/hacha.png",poder=7){}
object lanza  inherits Arma(position=game.at(6,2),image="items/lanza.png",poder=5){}
object daga   inherits Arma(position=game.at(8,2),image="items/daga.png",poder=3){}

	
class Cura{
	var property position
	const property poder
	var property image
	
	method usar(_personaje){
		_personaje.sumarVida(poder) 
	}
	
//	method neutral(){
//		return true	
//	}
	method validarGuardado(){}
}
object curacion inherits Cura(position = game.at(7,5),poder = 10,image = "vida.png"){}


	







