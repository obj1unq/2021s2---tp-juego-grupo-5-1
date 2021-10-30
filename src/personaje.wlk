import wollok.game.*
import direcciones.*
import enemigos.*
import recursos.*
import hechizos.*

class Personaje {
    var property mana
	var property position = game.origin()
	var direccion = derecha
	var property nivel = 1
	var property hechizosAprendidos = [fuego, rayo]
	var property vida
	var property poder
	const property mochila = inventario
	
	method image() = "pj-"+ self.sufijo() +".png"
	
	method mover(_direccion){
		direccion = _direccion
		self.irA(_direccion.siguiente(self.position()))
	}
	
	method irA(nuevaPosicion){
		position = nuevaPosicion
	}
	
	method sufijo(){
		return direccion.sufijo()
	}
	
	method recuperarMana(cantidad){ if (self.noTieneFullMana()){ mana += cantidad } }
	
	method noTieneFullMana(){ return mana < 100 }
	
	method agotoMana(){ return mana == 0 }

	method contiene(elemento){
		if(not mochila.tiene(elemento)){
			self.error("no hay "+ elemento.toString() + " en el inventario")
		}
	}
	
	method remove(elemento){mochila.eliminar(elemento)}
	
	//
	
	method lanzar(hechizo){
		self.validarSiSePuedeLanzar(hechizo)
		const enemigos = game.colliders(self)
		enemigos.forEach({ enemigo => 
			enemigo.pierdeVida(hechizo.damage())
			self.gastarMana(hechizo)
			self.subirDeNivel(enemigo.expQueOtorga())
			self.perderVida(enemigo.golpe())
		})
	}
	
	method gastarMana(hechizo){
		mana -= hechizo.manaRequerida().max(0)
	}
	
	method validarSiSePuedeLanzar(hechizo){
		self.validarSiAprendio(hechizo)
		self.validarSiAlcanzaElMana(hechizo)
	}
	
	method validarSiAprendio(hechizo){
		if(! self.hechizosAprendidos().contains(hechizo)){
			self.error("no aprendí el hechizo " + hechizo.toString())
		}
	}
	
	method validarSiAlcanzaElMana(hechizo){
		if(hechizo.manaRequerida() > self.mana() || self.agotoMana()){
			self.error("no hay suficiente mana para lanzar " + hechizo.toString())
		}
	}
	
	
	//
//	
//    method atacar(enemigo){
//        enemigo.pierdeVida(poder)
//        self.subirDeNivel(enemigo.expQueOtorga())
//	}
//	
//    method atacarEnemigoAdelante(){
//    	const enemigos = game.colliders(self)
//		enemigos.forEach({
//			enemigo => self.atacar(enemigo)
//			self.perderVida(enemigo.golpe())
//		})
//	}
	
	method faltanEnemigos(){
		return game.hasVisual(brujo)
	}
	
	method armarse(_arma){
		self.contiene(_arma)
		_arma.usar(self)
		//self.remove(_arma)
	}
	
	method perderVida(x){
		vida = (vida - x).max(0)
		self.perder()
	}
	
//	method curarse(){
//		self.contiene(curacion)
//		curacion.usar(self)
//		self.remove(curacion)
//	}
//	
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
		var exp = 0
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
	var property cantidadDeOro = 0
	
	// --------------------------------------------
	method sumarOro(cantidad){   
		cantidadDeOro += cantidad 
	}
	//--------------------------------------------------
	method agregar(elemento){
		mochilaPersonaje.add(elemento)
		elemento.agregadoEn(self)
	}
	method eliminar(elemento){
		mochilaPersonaje.remove(elemento)
		elemento.agregadoEn(null)
		elemento.position()
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
const player = new Personaje(mana = 100,poder = 5,vida = 10)