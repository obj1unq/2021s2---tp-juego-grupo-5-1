import wollok.game.*
import personaje.*

class Coin {
	const property cantidad 
	method tipo() = "Coin"
	method text() = "1 coin"
	//method text() = cantidad + "Coin" + if(cantidad > 1) {"s"} else{}
	method agregar(position){game.addVisualIn(self,position)}
	//FALTA METODO PARA QUE CUANDO COLISIONE CON PLAYER DESAPARESCA Y SE SUME A LOS COIN DEL PLAYER
}

class Arma {
//	var property position
	var property poder
	var property image
//	var contenedor = null

	
	method usar(_personaje){
		_personaje.arma(self)
		_personaje.poder(self.poder())
	}
	method tipo() = "Armamento"
	
//	method neutral(){
//		return true
//	}
//	method validarGuardado(){}
//	
//	method agregadoEn(_contenedor){
//		contenedor = _contenedor
//	}
	
//	method position(){
//		return if(contenedor != null){
//			contenedor.dondeEstoy(self)
//		}else{
//			position
//		}
//	}
}

object espada inherits Arma(image="items/espada.png",poder=4){}
object hacha  inherits Arma(image="items/hacha.png",poder=7){}
object lanza  inherits Arma(image="items/lanza.png",poder=5){}
object daga   inherits Arma(image="items/daga.png",poder=3){}

	
class Cura{
//	var property position
	const property poder
	var property image
	//var contenedor = null
	
	method usar(_personaje){
		_personaje.sumarVida(poder)
		game.removeVisual(self)
	}
	method tipo() = "Curacion"
//	
//	method neutral(){
//		return true	
//	}
//	method validarGuardado(){}
//	
//	method agregadoEn(_contenedor){
//		contenedor = _contenedor
//	}
//	
//	method position(){
//		return if(contenedor != null){
//			contenedor.dondeEstoy(self)
//		}else{
//			position
//		}
//	}
}
object curacion inherits Cura(poder = 10,image = "vida.png"){}


	







