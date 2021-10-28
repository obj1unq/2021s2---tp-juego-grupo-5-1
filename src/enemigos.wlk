import wollok.game.*
import personaje.*
import recursos.*

class Enemigo {
	var property position
	var property hp = 10
	const property expQueOtorga = 2
	var property golpe = 1
	var property image
		
	method pierdeVida(poder){
		hp = (hp - poder).max(0)
		self.muere()
	}
	
	method muere(){
		if(self.noTieneMasVida()){
			game.removeVisual(self)
			self.soltarDrop()
			self.darRecompensaEnOro() // !!!!!
		}
	}
	
	method darRecompensaEnOro(){
		player.tomarOro(pocasMonedasDeOro) // esto solo es un caso de un monstruo de nivel bajo, se soluciona con inherit
		//player.mochila().sumarOro()
	}
	
	method soltarDrop(){ 
	    // se arma un drop en base a una lista de objetos, de momento se me ocurre armar una lista segun la clase de enemigo
	    // diferenciandolos por enemigos base, bosses, etc..
		const item = self.posiblesDrops().anyOne()
		
		if(not game.hasVisual(item))
		game.addVisual(item)
		else{}
	}
	
	method posiblesDrops(){
		return [curacion,hacha, espada]
	}
	
	method noTieneMasVida(){
		return hp == 0
	}
	
//	method neutral(){
//		return false	
//	}
	method validarGuardado(){self.error("No se puede guardar a un enemigo")}
	
}

class EnemigoFinal inherits Enemigo{
	
	override method muere(){
		super()
		player.ganar()
	}
}
//DEFINICION DE ENEMIGOS
const escorpion = new Enemigo(image="escorpion.png",position=game.at(8,8))
const hiena = new Enemigo(image="hiena.png",position=game.at(8,5))
const goblin = new Enemigo(image="enemigos/Goblin/Idle/1.png",position=game.at(3,5))
const brujo = new EnemigoFinal(position=game.at(15,5),hp = 20,expQueOtorga=5,golpe=2,image="enemigo.png")

//   SE INTENTO HACER UN DROP EN LA POSICIÓN DEL ENEMIGO A ELIMINAR.
//class Drop{
//	const property enemigo = new Enemigo()
//	var oro = 100
//	var property item
//	var property position = 
//	
//	method x(){return new Enemig }
//}
