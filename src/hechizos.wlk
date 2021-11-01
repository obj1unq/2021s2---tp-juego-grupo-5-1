import wollok.game.*
import personaje.*
import enemigos.*
class Hechizo {
	var property damage 
	var property manaRequerida
	
}

object fuego inherits Hechizo(damage=2,manaRequerida=20){}
object rayo inherits Hechizo(damage=3,manaRequerida=20){}
object hielo inherits Hechizo(damage=1,manaRequerida=20){}
object escudo inherits Hechizo(damage=0,manaRequerida=20){}

//HECHIZOS A DISTANCIA
class AtaqueLargo{
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

//LISTA DE HECHIZOS A DISTANCIA
const listaHechizosBonus = [ataqueDeFuego,ataqueDeHielo,ataqueDeRayo,escudo,rayo,hielo]
object ataqueDeFuego inherits AtaqueLargo(damage = 5, image = "fuego.png",manaRequerida=20){}
object ataqueDeHielo inherits AtaqueLargo(damage = 5, image = "hielo.png",manaRequerida=20){}
object ataqueDeRayo inherits AtaqueLargo(damage = 5, image = "rayo.png",manaRequerida=20){}

