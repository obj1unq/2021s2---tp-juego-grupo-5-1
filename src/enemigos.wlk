import wollok.game.*
import personaje.*
import recursos.*

class Enemigo {
	var property position
	const property image
	var property objetoBonus = null
	var property enemigoSiguiente = null
	var property hp = 10
	var property expQueOtorga = 2
	var property golpe = 1
	const property coins = new Coin(cantidad = golpe * 2)
	method tipo() = "Enemigo"
		
	method validarGuardado(){self.error("No se puede guardar a un enemigo")}
	
	method pierdeVida(poder){
		hp = (hp - poder).max(0)
		self.muere()
	}
	
	method noTieneMasVida(){return hp == 0}
	
	method despedida(){game.say(self,"Mas enemigos vendran por ti")}
	
	method addLiberarCoin(){coins.agregar(position)}
	
	method addObjetoEspecial(){game.addVisualIn(objetoBonus,position)}
	
	method addEnemigoSiguiente(){game.addVisual(enemigoSiguiente)}
	
	method muere(){
		if(self.noTieneMasVida()){
			self.despedida()
			self.addLiberarCoin()
			self.addObjetoEspecial()
			self.addEnemigoSiguiente()
			game.schedule(1000,{game.removeVisual(self)})
			//self.soltarDrop()
		}
	}
	
	
//	method soltarDrop(){ 
//	    // se arma un drop en base a una lista de objetos, de momento se me ocurre armar una lista segun la clase de enemigo
//	    // diferenciandolos por enemigos base, bosses, etc..
//		const item = self.posiblesDrops().anyOne()
//		
//		if(not game.hasVisual(item))
//		game.addVisual(item)
//		else{}
//	}
	
//	method posiblesDrops(){
//		return [curacion,hacha, espada]
//	}
//	
	
	
//	method neutral(){
//		return false	
//	}

	
}

class EnemigoFinal inherits Enemigo{
	
	override method muere(){
		super()
		player.ganar()
	}
	override method despedida(){
		game.say(self,"Me vengare")
	}
	
}
//DEFINICION DE ENEMIGOS
//
const brujo = new EnemigoFinal(hp = 20,expQueOtorga=5,golpe=2,image="enemigo.png",position=game.at(15,5))
const hiena = new Enemigo(image="hiena.png",objetoBonus = new Cura(poder = 10,image = "vida.png"),enemigoSiguiente = brujo,position=game.at(10,5))
const escorpion = new Enemigo(position = game.at(8,8),image="escorpion.png",objetoBonus = new Arma(image="items/espada.png",poder=4),enemigoSiguiente = hiena)
const goblin = new Enemigo(image="enemigos/Goblin/Idle/1.png",position=game.at(3,5))


//   SE INTENTO HACER UN DROP EN LA POSICIÓN DEL ENEMIGO A ELIMINAR.
//class Drop{
//	const property enemigo = new Enemigo()
//	var oro = 100
//	var property item
//	var property position = 
//	
//	method x(){return new Enemig }
//}
