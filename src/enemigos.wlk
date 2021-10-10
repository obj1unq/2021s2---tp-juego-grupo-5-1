import wollok.game.*
import personaje.*

object escorpion {
	var property position = game.at(8,8)
	var property hp = 7
	const property expQueOtorga = 2
	
	method image() = "escorpion.png"
	
	method pierdeVida(){
		hp -= 1
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
	
}

object hiena {
	var property position = game.at(8,3)
	var property hp = 4
	const property expQueOtorga = 5
	
	method image() = "hiena.png"
	
	method pierdeVida(){
		hp -= 1
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
	
}


