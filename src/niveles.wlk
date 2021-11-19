 import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*
import hechizos.*

object tutorial {
	method iniciar(){
		visual.pj()
		//visual.armas()
		
		//visual.enemigos()
		//config.sonido()
		config.configurarTeclas()
//		config.configurarStamina()
        config.configurarSpawnEnemigos()
//        game.addVisual(esqueleto)
		config.movimientoEnemigos()
		
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
			game.say(personaje,texto)
		})
	}
}
object visual{
	method pj(){
		game.addVisual(personaje)
		game.showAttributes(personaje)
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
		self.ataques()
		self.movimientos()
		
		keyboard.s().onPressDo({personaje.guardar()})
		
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
	
	method ataques(){
		
		keyboard.a().onPressDo({personaje.ataqueMelee()})
		
		keyboard.num1().onPressDo({personaje.lanzar(fuego)})
		keyboard.num2().onPressDo({personaje.lanzar(rayo)})
		keyboard.num3().onPressDo({personaje.lanzar(hielo)})
//		keyboard.num4().onPressDo({player.lanzar(escudo)})
		
		keyboard.e().onPressDo({personaje.experienciaDoble()})
		keyboard.c().onPressDo({personaje.concentrar()})
	}
	
	method movimientos(){
		keyboard.left().onPressDo( { personaje.mover(izquierda)})
		keyboard.right().onPressDo({ personaje.mover(derecha)})
		keyboard.up().onPressDo(   { personaje.mover(arriba)})
		keyboard.down().onPressDo( { personaje.mover(abajo)})
	}
	
	method movimientoEnemigos(){
		game.onTick(1000,"MOVENEMIGOS",{generadorEnemigos.enemigos().forEach({enemigo => enemigo.buscar(personaje)})})
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
