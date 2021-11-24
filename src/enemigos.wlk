
import wollok.game.*
import personaje.*
import recursos.*
import randomizer.*
import direcciones.*
import objects.*

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
	
	method perseguir(pj)
	
	method atacar(pj)	
}

class EnemigoMele inherits Enemigo{
	
	override method perseguir(pj){
		const positionDifX = (self.position().x() - pj.position().x()).abs()
		const positionDifY = (self.position().y() - pj.position().y()).abs()
		if(positionDifX != 0){
			moverse.sobreX(self,pj)	
		}else if(positionDifY != 0){
			moverse.sobreY(self,pj)
		}else {
			self.atacar(pj)
		}
	}
	
	override method atacar(pj){
		return pj.perderVida(self.golpe())
	}
	
}


class EnemigoRango inherits Enemigo{
	override method perseguir(pj){

		const positionDifY = (self.position().y() - pj.position().y()).abs()
		if(positionDifY != 0){
			moverse.sobreY(self,pj)	
		}else {
			self.atacar(pj)
		}
	}
	
	override method atacar(pj){
		const ataque = new Ataque(position = self.position(),golpe = self.golpe())
		ataque.lanzar(pj)
		
	}
}

class Ataque{
	var property position
	const golpe
	method text() = "ataque"
	method lanzar(pj){
		game.addVisual(self)
		var i = 10
		game.onTick(100,"enemigoAtaca",{
			if(i > 0){
				moverse.sobreX(self,pj)
				i -= 1
				self.verificarAtaque(pj)
			}else{
				self.desaparecer()
			}
		})
	}
	method verificarAtaque(pj){
		const elementos = game.colliders(self)
		if(elementos.contains(pj)){
			pj.perderVida(golpe)
			self.desaparecer()
		}
	}
	
	method desaparecer(){
		if(game.hasVisual(self)){
			game.removeVisual(self)
			game.removeTickEvent("enemigoAtaca")
		}
	}
}

class Ojo inherits EnemigoRango(image = "enemigos/ojo.png"){
	
}
class Goblin inherits EnemigoMele(image = "enemigos/goblin.png"){
	
}
class Hongo inherits EnemigoMele(image = "enemigos/hongo.png"){
	override method perseguir(pj){
		const positionDifX = (self.position().x() - pj.position().x()).abs()
		const positionDifY = (self.position().y() - pj.position().y()).abs()
		if(positionDifY != 0){
			moverse.sobreY(self,pj)	
		}else if(positionDifX != 0){
			moverse.sobreX(self,pj)
		}else {
			self.atacar(pj)
		}
	}
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
	var cantMax = 0
	const factoriesEnemigos = [hongoFactory,ojoFactory,goblinFactory]	
	
	method spawnearEnemigo(){
		if(self.hayQueSpawnear()){
			const enemigo = self.spawnEnemigos()
			game.addVisual(enemigo)
			game.showAttributes(enemigo)
			enemigos.add(enemigo)
			cantMax += 1
		}else if(cantMax == 10){
			self.validarFin()
		}
	}
	
	method validarFin(){
		if(enemigos.size() == 0){
			personaje.ganarNivel()
		}
	}
	
	method hayQueSpawnear(){
		return enemigos.size()<max && cantMax < 10
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


 