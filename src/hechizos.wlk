import wollok.game.*
import personaje.*
import enemigos.*

class Hechizo{
	var property position = game.origin()
	var property image
	var property damage
	var property manaRequerida  
	var property alcance = 22
	
	method lanzar(dir,posicion){
		position = posicion
		if(not game.hasVisual(self)){
			game.addVisual(self)
		var i = alcance
		game.onTick(100,"lanzarAtaque",{
			if(i > 0){
			position = dir.siguiente(position)
			i -= 1
			self.verificarAtaque()
			}
			else{
				self.desaparecer()
			}
		})	
		}
		
	}
	
	method verificarAtaque(){
		const elementos = game.colliders(self)
		elementos.forEach({x => 
			if(generadorEnemigos.enemigos().contains(x)){
				personaje.subirDeNivel(x.expQueOtorga())
				x.pierdeVida(damage)
				self.desaparecer()
		}})
	}
	
	method desaparecer(){
		if(game.hasVisual(self)){
			game.removeVisual(self)
			game.removeTickEvent("lanzarAtaque")
		}
		
	}
	
}

//LISTA DE HECHIZOS A DISTANCIA
const listaHechizosBonus = [fuego, hielo, rayo]
object fuego inherits Hechizo(damage = 2, image = "fuego.png",manaRequerida=20){}
object hielo inherits Hechizo(damage = 10, image = "hielo.png",manaRequerida=40){}
object rayo inherits Hechizo(damage = 5, image = "rayo.png",manaRequerida=30){}

