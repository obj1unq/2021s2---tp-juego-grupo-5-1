import wollok.game.*
import direcciones.*
import enemigos.*

object personaje {
    var property stamina = 5
	var property position = game.origin()
	var dir = derecha
	const property expNecesariaParaSubirLvl = 2
	var property expGanada = 0

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
	
	method recuperarStamina(cantidad){
		if( self.noTieneFullStamina()){
			stamina += cantidad
	}
	}
	
	method noTieneFullStamina(){
		return stamina < 5
	}
	
    method gastaStamina(cantidad){
    	stamina -=cantidad
    }
	
	method atacar(){    // esto funciona solo si es un enemigo, si quiero atacar otro enemigo????
	 const enemigo = game.colliders(self)
		if(self.estaEnMismaPosicionQue(enemigo)){
		self.validarStamina()
		enemigo.pierdeVida(1)  
		self.gastaStamina(1)
		self.ganarExperienciaSiSePuede(enemigo)	
		}
		else {self.validarStamina()
			  self.gastaStamina(1)
		}
	}
	
	method estaEnMismaPosicionQue(algo){
		return game.colliders(self).contains(algo)
	}
	
	method validarStamina(){
		if(self.estaCansado()){
			self.error("no hay Stamina para poder atacar")
		}
	}
	
	method estaCansado(){
		return stamina == 0
	}
	
	method ganarExperienciaSiSePuede(enemigo){
		if(enemigo.noTieneMasVida()){ expGanada += enemigo.experienciaAlMorir()}
	}
	

}