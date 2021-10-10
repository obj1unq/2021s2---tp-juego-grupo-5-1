import wollok.game.*
import direcciones.*
import enemigos.*

object personaje {
    var property stamina = 5
	var property position = game.origin()
	var dir = derecha
	var nivel = 1
	var exp = 0

	method image() = "pj-demo-"+ self.sufijo() +".png"
	
	method mover(direccion){
		if(direccion.esVertical()){
			self.irA(direccion.siguiente(self.position()))
		}
		else{
			dir = direccion
			self.irA(direccion.siguiente(self.position()))	
		}
	}
	
	method irA(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method sufijo(){
		return dir.sufijo()
	}
	
	
	method recuperarStamina(cantidad){ if (self.noTieneFullStamina()){ stamina += cantidad } }
	
	method noTieneFullStamina(){ return stamina < 5 }
	
    method gastaStamina(cantidad){ stamina -= cantidad } 
    
    method validarStamina(){ if(self.estaCansado()){ self.error("no hay Stamina para poder atacar") } }
	
	method estaCansado(){ return stamina == 0 }
	

    method atacar(enemigo){
		self.validarStamina()
        self.gastaStamina(1)
        enemigo.pierdeVida()
        self.subirDeNivel(enemigo.expQueOtorga())
	}

    method atacarEnemigoAdelante(){
    	const enemigos = game.colliders(self)
		enemigos.forEach({enemigo => self.atacar(enemigo)})
	}
	
	method subirDeNivel(_exp){
		exp += _exp
		if(exp >= 10){
			nivel += 1
			exp = 0
		}
	}

}