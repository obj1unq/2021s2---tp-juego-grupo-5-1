import wollok.game.*
import personaje.*

class Arma {
	var property position
	var property poder
	var property image
	var contenedor = null
	
	method usar(_personaje){
		_personaje.arma(self)
		_personaje.poder(self.poder())
	}
	
	method neutral(){
		return true
	}
	method validarGuardado(){}
	
	method agregadoEn(_contenedor){
		contenedor = _contenedor
	}
	
	method position(){
		return if(contenedor != null){
			contenedor.dondeEstoy(self)
		}else{
			position
		}
	}
}

object espada inherits Arma(position=player.position(),image="items/espada.png",poder=4){}
object hacha  inherits Arma(position=player.position(),image="items/hacha.png",poder=7){}
object lanza  inherits Arma(position=player.position(),image="items/lanza.png",poder=5){}
object daga   inherits Arma(position=player.position(),image="items/daga.png",poder=3){}

	
class Cura{
	var property position
	const property poder
	var property image
	var contenedor = null
	
	method usar(_personaje){
		_personaje.sumarVida(poder)
		game.removeVisual(self)
	}
	
	method neutral(){
		return true	
	}
	method validarGuardado(){}
	
	method agregadoEn(_contenedor){
		contenedor = _contenedor
	}
	
	method position(){
		return if(contenedor != null){
			contenedor.dondeEstoy(self)
		}else{
			position
		}
	}
}
object curacion inherits Cura(position=player.position(),poder = 10,image = "vida.png"){}


	







