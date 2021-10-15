import wollok.game.*
import personaje.*

object espada {
	var property position = game.at(5,2)
	const property poder = 5

	method image() = "espada.png"
	
	method usar(_personaje){
			if(not game.hasVisual(self)){
				_personaje.arma(self)
			    _personaje.poder(self.poder())
			}
			else{_personaje.arma(self)
			    _personaje.poder(self.poder())
			    game.removeVisual(self)
			    }
				
	}
	
	

	method visualizar(){
		   game.addVisual(self)	
	}
	
	method reubicar(){position = game.at(6,5)}
	method dejarDeVisualizar(){game.removeVisual(self)}
}	
	
object curacion {
	var property position = game.at(7,5)
	const property poder = 10

	method image() = "vida.png"
	
	method usar(_personaje){
		if(not game.hasVisual(self)){
			_personaje.sumarVida(poder) 
		}
		else{
			_personaje.sumarVida(poder)
			game.removeVisual(self)
		}
		      
		
	}
	
	
	
	
	method reubicar(){position = game.at(8,5)}
	
	method visualizar(){
		   game.addVisual(self)	
	}
	
	method dejarDeVisualizar(){game.removeVisual(self)}
}

object texto{
	method position() = game.at(2,2)
	method text() = personaje.vida().toString() + " "+ personaje.poder() + " " + personaje.nivel()
}


// idea: de alguna manera devolver una lista con los png de los items y mostrarla junto con el inventario 

object inventario{
	method position() = game.at(5,4)
	method image() = "inv-demo.png"
	
}







