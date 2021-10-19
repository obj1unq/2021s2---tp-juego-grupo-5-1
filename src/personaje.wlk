import wollok.game.*
import direcciones.*
import enemigos.*
import recursos.*

object personaje {
    var property stamina = 5
	var property position = game.origin()
	var dir = derecha
	var  property nivel = 1
	var exp = 0
	var property vida = 10
	var property poder = 1
	var property arma
	const property mochila = []
	
	method image() = "pj-demo-"+ self.sufijo() +".png"
	
	method mover(direccion){
		self.irA(direccion.siguiente(self.position()))
		dir = direccion.cambiar(dir)
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

	method contiene(elemento){
		if(not mochila.contains(elemento)){
			self.error("no hay "+ elemento.toString() + " en el inventario")
		}else{
			mochila.contains(elemento)	
		}
	}
	
	method remove(elemento){mochila.remove(elemento)}
	
	
    method atacar(enemigo){
		self.validarStamina()
        self.gastaStamina(1)
        enemigo.pierdeVida()
        self.subirDeNivel(enemigo.expQueOtorga())
	}
	

    method atacarEnemigoAdelante(){
    	const enemigos = game.colliders(self)
		enemigos.forEach({
			enemigo => self.atacar(enemigo)
			self.perderVida(enemigo.golpe())
		})
	}
	
	method faltanEnemigos(){
		return game.hasVisual(brujo)
	}
	
	method armarse(){
		self.contiene(espada)
		espada.usar(self)
		self.remove(espada)
	}
	
	method perderVida(x){
		vida = (vida - x).max(0)
		self.perder()
	}
	
	method curarse(){
		self.contiene(curacion)
		curacion.usar(self)
		self.remove(curacion)
	}
	
	method sumarVida(x){vida = (vida + x).min(10)}
	
	
	method guardar(){
		const recursos = game.colliders(self)
		recursos.forEach({
			recurso => self.guardarEnInventario(recurso)})
	}
	
	method guardarEnInventario(recurso){
		mochila.add(recurso)
		game.removeVisual(recurso)
	}
	
	
	method subirDeNivel(_exp){
		exp += _exp
		if(exp >= 10 * nivel){
			nivel += 1
			exp = 0
			vida += 2
			poder += 1
		}
	}

	method ganar(){
		if(!self.faltanEnemigos()){
			game.say(self,"GANASTE")
			game.schedule(2000,{game.stop()})
		}
	}
	
	method perder(){
		if(vida == 0){
			game.say(self,"PERDISTE")
			game.schedule(2000,{game.stop()})
		}
	}
	
}