import wollok.game.*
import personaje.*
import enemigos.*

//HECHIZOS
class Hechizo{
	var property position = game.origin()
	var property image
	var property damage
	var property manaRequerida  
	var property alcance = 10
	
	method lanzar(dir,posicion){
		position = posicion
		
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
	
	method verificarAtaque(){
		const elementos = game.colliders(self)
		elementos.forEach({x => 
			if(generadorEnemigos.setDeEnemigos().contains(x)){
				player.subirDeNivel(x.expQueOtorga())
				x.pierdeVida(damage)
				self.desaparecer()
		}})
	}
	
	method desaparecer(){
		game.removeTickEvent("lanzarAtaque")
		game.removeVisual(self)
	}
	
}

//object escudo{
//	
//}

//LISTA DE HECHIZOS A DISTANCIA
const listaHechizosBonus = [new Fuego(), new Hielo(), new Rayo()]
class Fuego inherits Hechizo(damage = 5, image = "fuego.png",manaRequerida=20){}
class Hielo inherits Hechizo(damage = 5, image = "hielo.png",manaRequerida=20){}
class Rayo inherits Hechizo(damage = 5, image = "rayo.png",manaRequerida=20){}

