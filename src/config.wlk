import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*
import hechizos.*
import visuales.*
import hud.*

object config{
	var property sonido = game.sound("theme.mp3")
	var property sonido2 = game.sound("theme2.mp3")
	var property sonidoBonus = game.sound("bonusTheme.mp3")
	
	method configurarTeclas(){
		self.ataques()
		self.movimientos()		
		keyboard.s().onPressDo({personaje.guardar()})
	}
	
	method configurarSpawnEnemigos(){
		game.onTick(4000,"ENEMIGOS",{generadorEnemigos.spawnearEnemigo()})
		game.onTick(1000,"MOVENEMIGOS",{generadorEnemigos.enemigos().forEach({enemigo => enemigo.perseguir(personaje)})})
	
	}
	method configurarSpawnEnemigosDos(){
		generadorEnemigos.reiniciar()
		game.onTick(2000,"ENEMIGOS",{generadorEnemigos.spawnearEnemigo()})
		game.onTick(700,"MOVENEMIGOS",{generadorEnemigos.enemigos().forEach({enemigo => enemigo.perseguir(personaje)})})
	
	}
	
	method sonido(){
		sonido.shouldLoop(true)
		game.schedule(500, { sonido.play()} )
	}
	
		method sonido2(){
		sonido.stop()	
		sonido2.shouldLoop(true)
		game.schedule(500, { sonido2.play()} )
	}
	
	method sonidoBonus(){
		sonido2.stop()
		sonidoBonus.shouldLoop(true)
		game.schedule(500, { sonidoBonus.play()} )
	}
	
	method ataques(){
		keyboard.a().onPressDo({personaje.ataqueMelee()})
		keyboard.num1().onPressDo({personaje.lanzar(fuego)})
		keyboard.num2().onPressDo({personaje.lanzar(hielo)})
		keyboard.num3().onPressDo({personaje.lanzar(rayo)})
		//keyboard.e().onPressDo({personaje.experienciaDoble()})
		keyboard.c().onPressDo({personaje.concentrar()})
	}
	
	method movimientos(){
		keyboard.left().onPressDo( { personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.up().onPressDo(   { personaje.mover(arriba)})
		keyboard.down().onPressDo( { personaje.mover(abajo)})
	}
}


