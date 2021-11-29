import wollok.game.*
import personaje.*
import recursos.*
import randomizer.*
import direcciones.*
import visuales.*

class Ataque{
	var property position = game.origin()
	const golpe
	const dir
	method text() = "ataque"
	
	method lanzar(pj){
		game.addVisual(self)
		var i = 10
		game.onTick(100,"enemigoAtaca",{
			if(i > 0){
				position = dir.siguiente(position)
				i -= 1
				self.verificarAtaque(pj)
			}else{
				self.desaparecer("enemigoAtaca")
			}
		})
	}
	
	method verificarAtaque(pj){
		if(game.hasVisual(self)){
			const elementos = game.colliders(self)
			if(elementos.contains(pj)){
				pj.perderVida(golpe)
				self.desaparecer("enemigoAtaca")
			}
		}
	}
	
	method desaparecer(evento){
		if(game.hasVisual(self)){
			game.removeVisual(self)
			game.removeTickEvent(evento)
		}
	}
}

class AtaqueFinal inherits Ataque{
	
	method crearAtaques(){
		const ataque2 = new Ataque(position = game.at(15,3),golpe = golpe,dir=dir)
		const ataque4 = new Ataque(position = game.at(15,5),golpe = golpe,dir=dir)
		const ataque6 = new Ataque(position = game.at(15,7),golpe = golpe,dir=dir)
		return [ataque2,ataque4,ataque6]
	}
	 override method lanzar(pj){
	 	self.crearAtaques().forEach({ataque => 
	 		game.addVisual(ataque)
			self.lanzarlo(ataque,pj)
	 	})
	}
	method lanzarlo(ataque,pj){
		var i = 10
		game.onTick(500,"enemigoAtacaLargo",{
			if(i > 0){
				moverse.moverAtaque(ataque)
				self.verificarAtaque(pj,ataque)
				i -= 1
			}else{
				self.desaparecer("enemigoAtacaLargo",ataque)
			}
		})
	}
	
	method verificarAtaque(pj,ataque){
			if(game.hasVisual(self)){
				const elementos = game.colliders(ataque)
				if(elementos.contains(pj)){
					pj.perderVida(golpe)
					self.desaparecer("enemigoAtacaLargo",ataque)
				}	
			}	
	}
	
	method desaparecer(evento,ataque){
		if(game.hasVisual(ataque)){
			game.removeVisual(ataque)
			game.removeTickEvent(evento)
		}
	}
	
}
