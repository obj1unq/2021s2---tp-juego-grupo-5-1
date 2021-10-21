import wollok.game.*
import direcciones.*
import enemigos.*
import recursos.*

class Personaje {
    var property stamina
	var property position = game.origin()
	var dir = derecha
	var  property nivel = 1
	var exp = 0
	var property vida
	var property poder
	var property arma = null
	const property mochila = inventario
	
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
		if(not mochila.tiene(elemento)){
			self.error("no hay "+ elemento.toString() + " en el inventario")
		}
	}
	
	method remove(elemento){mochila.remove(elemento)}
	
	
    method atacar(enemigo){
		self.validarStamina()
        self.gastaStamina(1)
        enemigo.pierdeVida(poder)
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
	
	method armarse(_arma){
		self.contiene(_arma)
		_arma.usar(self)
		self.remove(_arma)
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
		recursos.forEach({recurso => 
			recurso.validarGuardado()
			self.guardarEnInventario(recurso)
		})
	}
	
	method guardarEnInventario(recurso){
		mochila.agregar(recurso)
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

object inventario{
	const property mochilaPersonaje = []
	
	method agregar(elemento){
		mochilaPersonaje.add(elemento)
		elemento.agregadoEn(self)
	}
	method eliminar(elemento){
		mochilaPersonaje.remove(elemento)
		elemento.agregadoEn(null)
		//elemento.position()
	}
	method tiene(elemento){
		return mochilaPersonaje.contains(elemento)
	}
	method dondeEstoy(elemento){
		return game.at(self.calcularX(elemento), 10)
	}
	method calcularX(elemento){
		var x = 0
		var encontrado = false
		mochilaPersonaje.forEach({_elemento =>
			if(elemento != _elemento && ! encontrado){
				x = x + 1
			}else{
				encontrado = true
			}
		})
		return x
	}
}



//DEFINICION DE PLAYER 1 
const player = new Personaje(stamina = 5,poder = 5,vida = 10)
