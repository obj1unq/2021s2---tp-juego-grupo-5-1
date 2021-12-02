import wollok.game.*
import direcciones.*
import enemigos.*
import recursos.*
import hechizos.*
import visuales.*
import hud.*
import config.*
import niveles.*

object personaje {
    var property mana = 100
	var property position = game.at(0,2)
	var direccion = derecha
	var property nivel = 1
	var property hechizosAprendidos = #{}
	var property vida = 10
	var property poder = 10
	var property exp = 0
	var pantalla = 1
	const property mochila = inventario
	
	method image() = "pj-"+ self.sufijo() +".png"
	
	method reiniciar(){
		mana = 100
		position = game.at(0,2)
		direccion = derecha
		vida = 10
		poder = 10
		exp = 0
	}
	method mover(_direccion){
		direccion = _direccion
		self.irA(_direccion.siguiente(self.position()))
	}
	
	method irA(nuevaPosicion){position = nuevaPosicion}
	
	method sufijo(){return direccion.sufijo()}
	
	method recuperarMana(cantidad){
        if (self.noTieneFullMana()){ 
            mana = (mana + cantidad).min(100)
            hud.actualizarMana()
        }
    }
	
	method noTieneFullMana(){ return mana < 100 }
	
	method agotoMana(){ return mana == 0 }
	

	method contiene(elemento){
		if(not mochila.tiene(elemento)){
			self.error("no hay "+ elemento.toString() + " en el inventario")
		}
	}
		method guardar(){
		const recursos = game.colliders(self)
		recursos.forEach({recurso => 
			recurso.validarGuardado()
			self.guardarEnInventario(recurso)
		})
	}
	
	method guardarEnInventario(recurso){
		recurso.desaparecer()
		self.sumarVida(recurso.poder())
		
	}
	
	method remove(elemento){mochila.eliminar(elemento)}
//********************
	
	method ataqueMelee(){
		const enemigos = game.colliders(self)
		enemigos.forEach({ enemigo => 
			if(generadorEnemigos.enemigos().contains(enemigo)){
				enemigo.pierdeVida(self.poder())
			self.subirDeNivel(enemigo.expQueOtorga())
			}
			
		})
	}

	method lanzar(tipo){
		self.validarSiSePuedeLanzar(tipo)
		self.gastarMana(tipo)
		tipo.lanzar(direccion,position)
	}
	
	method gastarMana(hechizo){
        mana -= hechizo.manaRequerida().max(0)
        hud.actualizarMana()
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
	
	method perderVida(x){
        vida = (vida - x).max(0)
        hud.actualizarVida()
        self.perder()
    }

	  method sumarVida(x){
        vida = (vida + x).min(10)
        hud.actualizarVida()
    }
	

	method subirDeNivel(_exp){
		exp += _exp
		if(exp >= 10 * nivel){
			exp -= 10 * nivel
			nivel += 1
			poder += 1
			self.sumarVida(2)
			self.aprenderNuevoHechizo()
		}
	}

	method aprenderNuevoHechizo(){
        const niveles = [2,3,4]
        niveles.forEach({x => 
            if(self.esNivel(x)){
                const element = listaHechizosBonus.first()
                hechizosAprendidos.add(element)
                listaHechizosBonus.remove(element)
                hud.activarHechizo()
            }
        })
    }
	
	method esNivel(numero){return nivel == numero}
	
	method concentrar(){
        self.validarQueEstaEnTemplo(temploDeMana)
        if(mana < 100){
            mana = (mana + 20).min(100)
            hud.actualizarMana()
            self.cambiarImagen()
        }
    }
    
      method cambiarImagen(){
        const anterior = direccion
        direccion = concentrando
        game.schedule(3000,{direccion = anterior})
    }
	
	method validarQueEstaEnTemplo(tipo){
		if(! self.estaEnTemplo(tipo)){
			self.error("No estoy en el templo!")
		}
	}
	
	method estaEnTemplo(tipo){  
	 return game.colliders(self).contains(tipo)
	}

//	method experienciaDoble(){
//		self.validarQueEstaEnTemplo(temploDeExperiencia)
//		 generadorEnemigos.enemigos().forEach({enemigo => enemigo.duplicarExp()})
//	}
	
	method ganar(){
			game.say(self,"GANASTE")
			game.schedule(8000,{game.stop()})
	}
	
	method ganarNivel(){
		game.say(self,"Continuemos con el sig nivel!")
		if(pantalla == 1){
			game.schedule(4000,{nivel2.show()})
			pantalla += 1
		}
		else if(pantalla == 2){
			game.schedule(2000,{bonus.show()})
			pantalla += 1
		}
		
	}
	
	method perder(){
		if(vida == 0){
			game.say(self,"PERDISTE")
			game.schedule(8000,{game.stop()})
		}
	}
	
}

object inventario{
	const property mochilaPersonaje = []
	var property cantidadDeOro = 0
	
	method sumarOro(cantidad){   
		cantidadDeOro += cantidad 
	}

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