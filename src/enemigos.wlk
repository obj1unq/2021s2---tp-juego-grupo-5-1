import wollok.game.*
import personaje.*
import recursos.*
import randomizer.*
import direcciones.*
import visuales.*
import ataques.*

class Enemigo {
	var property position
	var property hp = 10
	var property expQueOtorga = 2
	var property golpe = 1
	var property image
	var property direccion = derecha
	const oroQueDa = (1 .. 10).anyOne()
	
	method image()
	
	method pierdeVida(poder){
		hp = (hp - poder).max(0)
		self.muere()
	}
	method sufijo(){return direccion.sufijo()}
	
	method muere(){
		if(self.noTieneMasVida()){
			game.removeVisual(self)
			generadorEnemigos.remover(self)
			self.darRecompensaDeOro()
		}
	}
	
	method darRecompensaDeOro(){
		inventario.sumarOro(oroQueDa)
	}
	
	method noTieneMasVida(){return hp == 0}
	
	method duplicarExp(){
		expQueOtorga *= 2
		game.schedule(5000,{expQueOtorga /= 2})
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
			moverse.perfilarse(self,pj)	
		}else {
			self.atacar(pj)
		}
	}
	
	override method atacar(pj){
		const ataque = new Ataque(position = self.position(),golpe = self.golpe(),dir = direccion, image= "ataqueEnemigo.png")
		ataque.lanzar(pj)	
	}
}

class Ojo inherits EnemigoRango(image = "enemigos/ojo.png"){
	 override method image() = "enemigos/ojo-" + self.sufijo() + ".png"
}
class Goblin inherits EnemigoMele(image = "enemigos/goblin.png"){
	override method image() = "enemigos/goblin-" + self.sufijo() + ".png"
}
class Hongo inherits EnemigoMele(image = "enemigos/hongo.png"){
	override method image() = "enemigos/hongo-" + self.sufijo() + ".png"
	 
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

class EnemigoFinal inherits Enemigo{
	
	override method image() = "enemigos/esqueleto-" + self.sufijo() + ".png"
	override method perseguir(pj){
		game.onTick(2000,"enY",{
			position = game.at(position.x(),2.randomUpTo(8).roundUp())
		})
		self.atacar(pj)
	}
	override method atacar(pj){
		const ataques = new AtaqueFinal(golpe= golpe,dir = izquierda, image= "ataqueEnemigo.png")
		game.onTick(3000,"lanzamiento",{
			ataques.lanzar(pj)
			
		})
	}

	override method muere(){
		super()
		if(self.noTieneMasVida()){
			personaje.ganarNivel()		
		}
	
	}
}



object generadorEnemigos {
	var property enemigos = #{}
	var property max  =10
	var property cantMax = 0
	const factoriesEnemigos = [hongoFactory,ojoFactory,goblinFactory]	
	
	method spawnearEnemigo(){
		if(self.hayQueSpawnear()){
			const enemigo = self.spawnEnemigos()
			game.addVisual(enemigo)
			game.showAttributes(enemigo)
			enemigos.add(enemigo)
			cantMax += 1
		}else if(cantMax == max){
			game.removeTickEvent("ENEMIGOS")
			self.validarFinal()
		}
	}
	method noHayMas(){return enemigos.size() == 0}
	
	method validarFinal(){
		if(enemigos.size() > 0){
			game.onTick(20,"noHayMas",{
				if(self.noHayMas()){
					game.removeTickEvent("noHayMas")
					self.final()
			}})
		}else{self.final()}
	}
	
	method final(){
		game.removeTickEvent("MOVENEMIGOS")
		const esqueleto = new EnemigoFinal(image="enemigos/esqueleto-izq.png",position=game.at(15,5),hp = 20,expQueOtorga=5,golpe=2)
		game.addVisual(esqueleto)
		enemigos.add(esqueleto)
		esqueleto.perseguir(personaje)
	}
	
	method hayQueSpawnear(){return enemigos.size()<max && cantMax < max}
	
	method spawnEnemigos(){
		const factory = factoriesEnemigos.get((0 .. 2).anyOne())
		return factory.nuevoEnemigo() 
	}
	
	method remover(enemigo){
		enemigos.remove(enemigo)
	}
	
	method reiniciar(){
		max += 10
		enemigos= #{}
		cantMax = 0
	}
	
}

class Factory{
	method posicionNueva(){
		const posicion = randomizer.emptyPosition()
		if(posicion.y() > 2 and posicion.y() < 8){
			return posicion	
		}else{
			const h = 2.randomUpTo(8).roundUp()
			return game.at(posicion.x(),h)
		}	
	}
}

object ojoFactory inherits Factory{
	method nuevoEnemigo(){
		return new Ojo(position= self.posicionNueva())
	}
}

object hongoFactory inherits Factory{
	method nuevoEnemigo(){
		return new Hongo(position=self.posicionNueva())
	}
}

object goblinFactory inherits Factory{
	method nuevoEnemigo(){
		return new Goblin(position=self.posicionNueva())
	}
}

const listaDeEnemigos =[hongoFactory,ojoFactory,goblinFactory]


 