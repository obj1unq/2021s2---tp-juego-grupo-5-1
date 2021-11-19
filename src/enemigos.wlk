
import wollok.game.*
import personaje.*
import recursos.*
import randomizer.*

class Enemigo {
	var property position
	var property hp = 10
	var property expQueOtorga = 2
	var property golpe = 1
	var property image
	const oroQueDa = (1 .. 10).anyOne()
		
	method pierdeVida(poder){
		hp = (hp - poder).max(0)
		self.muere()
	}
	
	method muere(){
		if(self.noTieneMasVida()){
			game.removeVisual(self)
			//self.soltarDrop()
			generadorEnemigos.remover(self)
			self.darRecompensaDeOro()
			
		}
	}
	
	method darRecompensaDeOro(){
		inventario.sumarOro(oroQueDa)
	}
	
	method noTieneMasVida(){
		return hp == 0
	}

	method validarGuardado(){self.error("No se puede guardar a un enemigo")}
	
	method buscar(pj)
	
	method atacar(pj)	
}

class EnemigoMele inherits Enemigo{
	override method buscar(pj){
		var positionDifX = (self.position().x() - pj.position().x()).abs()
		var positionDifY = (self.position().y() - pj.position().y()).abs()
		if(positionDifX != 0 and self.position().x() > pj.position().x()){
			self.position(self.position().left(1)) 
		}else if(positionDifX != 0 and self.position().x() < pj.position().x()){
			self.position(self.position().right(1))
		}else if(positionDifY != 0 and self.position().y() > pj.position().y()){
			self.position(self.position().down(1))
		}else if(positionDifY != 0 and self.position().y() < pj.position().y()){
			self.position(self.position().up(1)) 
		}else{
			self.atacar(pj)
		}
	}
	
	override method atacar(pj){
		return pj.perderVida(self.golpe())
	}
	
}

class EnemigoRango inherits Enemigo{
	override method buscar(pj){
		
	}
	override method atacar(pj){
		return pj.perderVida(self.golpe())
	}
}

class Ojo inherits EnemigoRango(image = "enemigos/ojo.png"){
	
}
class Goblin inherits EnemigoMele(image = "enemigos/goblin.png"){
	
}
class Hongo inherits EnemigoMele(image = "enemigos/hongo.png"){
	
}

//class EnemigoFinal inherits Enemigo{
//	
//	override method muere(){
//		super()
//		personaje.ganar()
//	}
//}
//
//const esqueleto = new EnemigoFinal(image="enemigos/esqueleto.png",position=game.at(15,5),hp = 20,expQueOtorga=5,golpe=2)


object generadorEnemigos{
	const property enemigos = #{}
	const max = 5
	const factoriesEnemigos = [hongoFactory,ojoFactory,goblinFactory]	
	
	method spawnearEnemigo(){
		if(self.hayQueSpawnear()){
			const enemigo = self.spawnEnemigos()
			game.addVisual(enemigo)
			game.showAttributes(enemigo)
			enemigos.add(enemigo)
		}
	}
	
	
	method hayQueSpawnear(){
		return enemigos.size()<max
	}
	
	method spawnEnemigos(){
		const factory = factoriesEnemigos.get((0 .. 2).anyOne())
		return factory.nuevoEnemigo() 
	}
	
	method remover(enemigo){
		enemigos.remove(enemigo)
	}
	
	method setDeEnemigos(){
		return /* #{esqueleto}*/ + self.enemigos()
		 
	}
}

object ojoFactory{
	method nuevoEnemigo(){
		return new Ojo(position=randomizer.emptyPosition())
	}
}

object hongoFactory{
	method nuevoEnemigo(){
		return new Hongo(position=randomizer.emptyPosition())
	}
}

object goblinFactory{
	method nuevoEnemigo(){
		return new Goblin(position=randomizer.emptyPosition())
	}
}

const listaDeEnemigos =[hongoFactory,ojoFactory,goblinFactory]


 