 import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*
import hechizos.*

object tutorial {
	method iniciar(){
		visual.personaje()
		//visual.armas()
		
		//visual.enemigos()
		//config.sonido()
		config.configurarTeclas()
//		config.configurarStamina()
        config.configurarSpawnEnemigos()
        game.addVisual(esqueleto)
		
		game.addVisual(mostrarOro)
		game.addVisual(temploDeMana)
		game.addVisual(temploDeExperiencia)
		
		game.cellSize(45)
		//game.schedule(2000,{dialogo.inicial()})
	}
	
}
object dialogo {
	
	const tutorial = ["Hola guerrero","Necesito tu ayuda","para eliminar a los enemigos","Acercate al enemigo y","presiona la tecla A para atacar","cuando mueran nos daran oro"]
	
	method inicial(){
		tutorial.forEach({
			texto =>
			game.say(player,texto)
		})
	}
}
object visual{
	method personaje(){
		game.addVisual(player)
		game.showAttributes(player)
	}
	
//	method enemigos(){
//		game.addVisual(hongo)
//		game.addVisual(ojo)
//		game.addVisual(goblin)
//		game.addVisual(esqueleto)
//		game.showAttributes(hongo)
//		game.showAttributes(ojo)
//		game.showAttributes(esqueleto)
//		game.showAttributes(goblin)
//	}
}

object config{
	method configurarTeclas(){
		self.hechizos()
		self.movimientos()
		
		keyboard.s().onPressDo({player.guardar()})
		
		// keyboard.q().onPressDo({player.curarse()})
		// keyboard.i().onPressDo({personaje.abrirInventario()})
	}
	
	method configurarSpawnEnemigos(){
		game.onTick(4000,"ENEMIGOS",{generadorEnemigos.spawnearEnemigo()})
	}
	method sonido(){
		const sonido = game.sound("donkey-kong-country.mp3")
		sonido.shouldLoop(true)
		game.schedule(500, { sonido.play()} )
	}
	
	method hechizos(){
		keyboard.num1().onPressDo({player.lanzar(fuego)})
		keyboard.num2().onPressDo({player.lanzar(rayo)})
		keyboard.num3().onPressDo({player.lanzar(hielo)})
		keyboard.num4().onPressDo({player.lanzar(escudo)})
		keyboard.g().onPressDo({player.ataqueAdistancia(ataqueDeHielo)})
		keyboard.h().onPressDo({player.ataqueAdistancia(ataqueDeFuego)})
		keyboard.j().onPressDo({player.ataqueAdistancia(ataqueDeRayo)})
		
		keyboard.e().onPressDo({player.experienciaDoble()})
		keyboard.c().onPressDo({player.concentrar()})
	}
	
	method movimientos(){
		keyboard.left().onPressDo( { player.mover(izquierda)})
		keyboard.right().onPressDo({ player.mover(derecha)})
		keyboard.up().onPressDo(   { player.mover(arriba)})
		keyboard.down().onPressDo( { player.mover(abajo)})
//		keyboard.a().onPressDo({player.atacarEnemigoAdelante()})
	}
	
	method potas(){
//		keyboard.q().onPressDo({player.usarPocion(vida)})
//		keyboard.w().onPressDo({player.usarPocion(mana)})
		//keyboard.e().onPressDo({personaje.curarse(stamina)})
		//keyboard.r().onPressDo({personaje.curarse(veneno)})
	}
	
//	
//	method configurarStamina(){
//	   game.onTick(900, "STAMINA", { player.recuperarStamina(1)})
//    }
	
}
