import wollok.game.*
import direcciones.*
import enemigos.*
import recursos.*
import hechizos.*
import objects.*

object personaje {
    var property mana
	var property position = game.origin()
	var direccion = derecha
	var property nivel = 1
	var property hechizosAprendidos = #{}//----
	var property vida = 10
	var property poder = 10
	var property exp = 0
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
	
	
	method ataqueMelee(){
		const enemigos = game.colliders(self)
		enemigos.forEach({ enemigo => 
			if(generadorEnemigos.enemigos().contains(enemigo)){
				enemigo.pierdeVida(self.poder())
			self.subirDeNivel(enemigo.expQueOtorga())
			}
			
		})
	}
	//ATAQUES A DISTANCIA--------------------------------------------
	method lanzar(tipo){
		self.validarSiSePuedeLanzar(tipo)
		self.gastarMana(tipo)
		tipo.lanzar(direccion,position)
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
	
	
//	method faltanEnemigos(){
//		return //game.hasVisual(esqueleto)
//	}
	
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
		exp += _exp
		if(exp >= 10 * nivel){
			exp -= 10 * nivel
			nivel += 1
			vida += 2
			poder += 1
			self.aprenderNuevoHechizo()
		}
	}
	
	//--------------------se modifico -----------------------------------
	method aprenderNuevoHechizo(){
		const niveles = [2,3,4]
		niveles.forEach({x => 
			if(self.esNivel(x)){
				const element = listaHechizosBonus.first()
				hechizosAprendidos.add(element)
				listaHechizosBonus.remove(element)
			}
		})
	} 
	
	method esNivel(numero){
		return nivel == numero
	}
	
	method concentrar(){
		self.validarQueEstaEnTemplo(temploDeMana)
		mana += 20
	}
	
	method validarQueEstaEnTemplo(tipo){
		if(! self.estaEnTemplo(tipo)){
			self.error("No puedo concentrar si no estoy en el templo!")
		}
	}
	
	method estaEnTemplo(tipo){  
	 return game.colliders(self).contains(tipo)
	}
	
	//Usar templo de experiencia -------------------------
	method experienciaDoble(){
		self.validarQueEstaEnTemplo(temploDeExperiencia)
		 generadorEnemigos.enemigos().forEach({enemigo => enemigo.duplicarExp()})
	}
	
	//---------------------------------------------------------

	method ganar(){
			game.say(self,"GANASTE")
			game.schedule(2000,{game.stop()})
	}
	method ganarNivel(){
		game.say(self,"Continuemos con el sig nivel!")
		game.schedule(2000,{nivel2.show()})
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