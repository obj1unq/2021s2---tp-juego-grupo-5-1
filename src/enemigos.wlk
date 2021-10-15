import wollok.game.*
import personaje.*

class Enemigo {
	var property position
	var property hp = 10
	const property expQueOtorga = 2
	var property golpe = 1
	var property image
	
	method pierdeVida(){
		hp = (hp - personaje.poder()).max(0)
		self.muere()
	}
	
	method muere(){
		if(self.noTieneMasVida()){
			game.removeVisual(self)
		}
	}
	
	method noTieneMasVida(){
		return hp == 0
	}
	
	method visualizar(){}
	
}

object brujo{
	var property position = game.at(15,5)
	var property hp = 20
	const property expQueOtorga = 5
	
	method golpe() = 2
	
	method image() = "enemigo.png"
	 
	method pierdeVida(){
		hp = (hp - personaje.poder()).max(0)
		self.muere()
	}
	
	method muere(){
		if(self.noTieneMasVida()){
			game.removeVisual(self)
			personaje.ganar()
		}
	}
	
	method noTieneMasVida(){
		return hp == 0
	}
	
}


