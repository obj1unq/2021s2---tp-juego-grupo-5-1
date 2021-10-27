import wollok.game.*
import enemigos.*
import personaje.*
import direcciones.*
import recursos.*

object tutorial {
	method iniciar(){
		visual.personaje()
		visual.armas()
		visual.enemigos()
		config.sonido()
		config.configurarTeclas()
		config.configurarStamina()
	}
	
}

object visual{
	method personaje(){
		game.addVisual(player)
		game.showAttributes(player)
	}
	
	method armas(){
		//game.addVisual(hacha)
		//game.addVisual(espada)
		//game.addVisual(lanza)
		//game.addVisual(daga)
	}
	method enemigos(){
		game.addVisual(escorpion)
		game.addVisual(hiena)
		game.addVisual(goblin)
		game.addVisual(brujo)
		game.showAttributes(escorpion)
		game.showAttributes(hiena)
		game.showAttributes(brujo)
		game.showAttributes(goblin)
	}
}

object config{
	method configurarTeclas(){
		self.equiparse()
		self.movimientos()
		
		keyboard.s().onPressDo({player.guardar()})
		
		keyboard.q().onPressDo({player.curarse()})
//		keyboard.i().onPressDo({personaje.abrirInventario()})
	}
	
	method sonido(){
		const sonido = game.sound("donkey-kong-country.mp3")
		sonido.shouldLoop(true)
		game.schedule(500, { sonido.play()} )
	}
	
	method equiparse(){
		keyboard.num1().onPressDo({player.armarse(espada)})
		keyboard.num2().onPressDo({player.armarse(hacha)})
		keyboard.num3().onPressDo({player.armarse(daga)})
		keyboard.num4().onPressDo({player.armarse(lanza)})
	}
	
	method movimientos(){
		keyboard.left().onPressDo( { player.mover(izquierda)})
		keyboard.right().onPressDo({ player.mover(derecha)})
		keyboard.up().onPressDo(   { player.mover(arriba)})
		keyboard.down().onPressDo( { player.mover(abajo)})
		keyboard.a().onPressDo({player.atacarEnemigoAdelante()})
	}
	
	method potas(){
		keyboard.q().onPressDo({player.curarse()})
		//keyboard.w().onPressDo({personaje.curarse(larga)})
		//keyboard.e().onPressDo({personaje.curarse(stamina)})
		//keyboard.r().onPressDo({personaje.curarse(veneno)})
	}
	
	
	method configurarStamina(){
	   game.onTick(900, "STAMINA", { player.recuperarStamina(1)})
    }
	
}

